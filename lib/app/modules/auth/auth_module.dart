import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/modules/auth/view/auth_page.dart';
import 'package:dengue_tcc/app/modules/tutorial/tutorial_module.dart';
import 'package:dengue_tcc/app/utils/images_precache/images_precache.dart';
import 'package:dengue_tcc/app/utils/images_precache/images_precache_impl.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton<ImagesPrecache>(
      (i) => ImagesPrecacheImpl(),
    ),
    Bind.lazySingleton<AuthControllerInterface>(
      (i) => AuthControllerCubit(
        imagesPrecache: Modular.get(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute, 
      child: (_, __) => AuthPage(
        controller: Modular.get()
          ..loadData(),
      ),
    ),
    ModuleRoute(
      ModulesRoute.tutorial, 
      module: TutorialModule(),
    ),
  ];

}