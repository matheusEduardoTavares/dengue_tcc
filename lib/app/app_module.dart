import 'package:dengue_tcc/app/modules/tutorial/view/tutorial_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute, 
      child: (_, __) => const TutorialPage()
    )
  ];
}