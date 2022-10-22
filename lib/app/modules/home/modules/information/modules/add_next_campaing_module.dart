import 'package:dengue_tcc/app/modules/home/modules/information/modules/controller/add_next_campaing_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/modules/controller/add_next_campaing_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/modules/view/add_next_campaing_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddNextCampaingModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<AddNextCampaingControllerInterface>(
      (i) => AddNextCampaingControllerCubit(
        informationRepository: Modular.get(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, __) => BlocProvider<AddNextCampaingControllerInterface>(
        create: (context) => Modular.get<AddNextCampaingControllerInterface>(),
        child: const AddNextCampaignPage(),
      ),
    )
  ];
}
