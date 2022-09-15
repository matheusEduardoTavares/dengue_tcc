import 'package:dengue_tcc/app/modules/home/modules/information/information_module.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/tutorial_module.dart';
import 'package:dengue_tcc/app/modules/home/view/home_page.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, __) => const HomePage(),
    ),
    ModuleRoute(
      ModulesRoute.tutorialModule,
      module: TutorialModule(),
    ),
    ModuleRoute(
      ModulesRoute.informationModule,
      module: InformationModule(),
    ),
  ];
}
