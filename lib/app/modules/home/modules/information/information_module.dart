import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/repositories/information_repository.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/repositories/information_repository_impl.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/view/information_page.dart';
import 'package:dengue_tcc/app/utils/enums/information_enum/information_enum.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InformationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<InformationRepository>(
      (i) => InformationRepositoryImpl(
        client: Modular.get(),
      ),
    ),
    Bind.lazySingleton<InformationControllerInterface>(
      (i) => InformationControllerCubit(informationRepository: Modular.get()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, __) => InformationPage(
        controller: Modular.get(),
        pageType: Modular.args.data as InformationEnum?,
      ),
    )
  ];
}
