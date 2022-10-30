import 'dart:async';

import 'package:dengue_tcc/app/app_module.dart';
import 'package:dengue_tcc/app/app_widget.dart';
import 'package:dengue_tcc/app/utils/environment/environment_impl.dart';
import 'package:dengue_tcc/app/utils/firebase_utils/firebase_utils.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EnvironmentImpl().configureEnvironment();
    await FirebaseUtils.initialize();

    runApp(
      DevicePreview(
        builder: (_) => ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
        enabled: false,
        availableLocales: const [
          Locale('pt', 'BR'),
        ],
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
