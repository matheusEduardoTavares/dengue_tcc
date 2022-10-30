import 'dart:async';
import 'dart:developer';

import 'package:dengue_tcc/app/modules/core/repositories/auth_repository/auth_repository.dart';
import 'package:dengue_tcc/app/modules/core/repositories/local_repository/local_repository.dart';
import 'package:dengue_tcc/app/utils/firebase_utils/firebase_utils.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required LocalRepository localRepository,
    required RestClient restClient,
    required AuthRepository authRepository,
    this.logout,
  })  : _localRepository = localRepository,
        _restClient = restClient,
        _authRepository = authRepository;

  final LocalRepository _localRepository;
  final RestClient _restClient;
  final AuthRepository _authRepository;
  final Future<void> Function()? logout;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['auth_required'] == true) {
      final localData = await _localRepository.getUser();

      if (localData == null) {
        return handler.reject(DioError(
          requestOptions: options,
          error: 'Needs authentication',
          type: DioErrorType.cancel,
        ));
      }

      final accessToken = localData.authToken;
      options.headers['Authorization'] = 'Bearer $accessToken';

      if ((options.method == 'POST') && options.data is Map<String, dynamic>) {
        options.data = {
          ...options.data as Map<String, dynamic>,
          'usuario_id': localData.id,
        };
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    log(
      err.response?.data?.toString() ?? err.error.toString(),
      stackTrace: err.stackTrace,
    );
    if (!kDebugMode) {
      FirebaseUtils.sendToCrashlytics(
        error: err,
        stackTrace: err.stackTrace,
      );
    }

    if (err.requestOptions.extra['auth_required'] == true) {
      final statusCode = err.response?.statusCode;
      if (statusCode == 403 || statusCode == 401) {
        return _retryRequest(err, handler);
      }
    }

    return handler.next(err);
  }

  Future<void> _refreshToken() async {
    final authLocalModel = await _localRepository.getUser();

    final response = await _authRepository.refreshToken(
      model: authLocalModel!,
    );
    await response.fold(
      (error) async => _loginExpire(),
      (authModel) async => _localRepository.saveUser(authModel),
    );
  }

  Future<void> _loginExpire() async {
    if (logout != null) {
      await logout!.call();
    } else {
      await _authRepository.logout();
      await _localRepository.clearLocal();

      Modular.to.navigate(
        Modular.initialRoute,
      );
    }
  }

  Future<void> _retryRequest(
      DioError err, ErrorInterceptorHandler handler) async {
    try {
      final requestOptions = err.requestOptions;

      final result = await _restClient.request(
        requestOptions.path,
        method: requestOptions.method,
        data: requestOptions.data,
        headers: requestOptions.headers,
        queryParameters: requestOptions.queryParameters,
        extra: requestOptions.extra,
      );

      handler.resolve(Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ));
    } on RestClientException catch (e) {
      return handler.reject(e.error);
    }
  }
}
