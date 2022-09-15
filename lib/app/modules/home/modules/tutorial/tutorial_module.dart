import 'package:dengue_tcc/app/modules/home/modules/tutorial/controller/tutorial_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/controller/tutorial_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/view/tutorial_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TutorialModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<TutorialControllerInterface>(
      (i) => TutorialControllerCubit(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, __) => TutorialPage(
        initialIndex: Modular.args.data as int?,
        controller: Modular.get(),
      ),
    )
  ];
}
