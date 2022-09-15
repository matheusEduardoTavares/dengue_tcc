import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/view/information_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InformationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<InformationControllerInterface>(
      (i) => InformationControllerCubit(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, __) => InformationPage(
        controller: Modular.get(),
      ),
    )
  ];
}
