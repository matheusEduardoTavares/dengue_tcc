import 'dart:isolate';

import 'package:dengue_tcc/app/utils/remote_config_utils/remote_config_utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseUtils {
  FirebaseUtils._();

  static Future<void> initialize() async {
    await Firebase.initializeApp();

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      Isolate.current.addErrorListener(RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
          reason: 'Errors outside of Flutter',
          printDetails: true,
        );
      }).sendPort);
    }

    await RemoteConfigUtils.initialize();
  }

  static Future<void> sendToCrashlytics({
    required dynamic error,
    required StackTrace? stackTrace,
    String? reason,
  }) async {
    if (error is DioError) {
      await FirebaseCrashlytics.instance.recordError(
        error.error,
        stackTrace,
        fatal: true,
        reason: 'Request de ${error.requestOptions.method} para: '
            '${error.requestOptions.baseUrl}${error.requestOptions.path} com '
            'status code ${error.response?.statusCode ?? 'indefinido'} |'
            'Data: ${error.requestOptions.data} |'
            'QueryParams: ${error.requestOptions.queryParameters} |'
            'Headers: ${error.requestOptions.headers} |'
            'Erro: ${error.response?.data ?? error.response}',
      );
    } else {
      await FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        fatal: true,
        reason: reason,
      );
    }
  }

  static Future<void> setUserToCrashlytics({
    required int? userId,
  }) async {
    if (userId != null) {
      await FirebaseCrashlytics.instance.setUserIdentifier(userId.toString());
    }
  }
}
