import 'package:dengue_tcc/app/modules/auth/auth_module.dart';
import 'package:dengue_tcc/app/modules/core/repositories/auth_repository/auth_repository.dart';
import 'package:dengue_tcc/app/modules/core/repositories/auth_repository/auth_repository_impl.dart';
import 'package:dengue_tcc/app/modules/core/repositories/local_repository/local_repository.dart';
import 'package:dengue_tcc/app/modules/core/repositories/local_repository/local_repository_impl.dart';
import 'package:dengue_tcc/app/utils/custom_location/custom_location.dart';
import 'package:dengue_tcc/app/utils/custom_location/custom_location_impl.dart';
import 'package:dengue_tcc/app/utils/environment/environment.dart';
import 'package:dengue_tcc/app/utils/environment/environment_impl.dart';
import 'package:dengue_tcc/app/utils/input_formatter/input_formatter.dart';
import 'package:dengue_tcc/app/utils/input_formatter/input_formatter_impl.dart';
import 'package:dengue_tcc/app/utils/local_storage/local_storage.dart';
import 'package:dengue_tcc/app/utils/local_storage/shared_preferences_local_storage_impl.dart';
import 'package:dengue_tcc/app/utils/permissions/permissions.dart';
import 'package:dengue_tcc/app/utils/permissions/permissions_impl.dart';
import 'package:dengue_tcc/app/utils/rest_client/dio_rest_client_impl.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<Permissions>(
      (i) => PermissionsImpl(),
    ),
    Bind.lazySingleton<CustomLocation>(
      (i) => CustomLocationImpl(),
    ),
    Bind.lazySingleton<Environment>(
      (i) => EnvironmentImpl(),
    ),
    Bind.lazySingleton<InputFormatter>(
      (i) => InputFormatterImpl(),
    ),
    Bind.lazySingleton<LocalStorage>(
      (i) => SharedPreferencesLocalStorage(),
    ),
    Bind.lazySingleton<LocalRepository>(
      (i) => LocalRepositoryImpl(
        localStorage: Modular.get(),
      ),
    ),
    Bind.lazySingleton<RestClient>(
      (i) => DioRestClient(
        localRepository: Modular.get(),
        environment: Modular.get(),
      ),
    ),
    Bind.lazySingleton<AuthRepository>(
      (i) => AuthRepositoryImpl(client: Modular.get()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: AuthModule(),
    )
  ];
}
