import 'package:dengue_tcc/app/modules/core/repositories/map_repository/map_repository.dart';
import 'package:dengue_tcc/app/modules/core/repositories/map_repository/map_repository_impl.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/modules/core/widgets/permissions/cubit/permissions_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/information_module.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/tutorial_module.dart';
import 'package:dengue_tcc/app/modules/home/view/home_page.dart';
import 'package:dengue_tcc/app/modules/home/view/map_marker_page.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    show Modular, Module, Bind, ChildRoute, ModularRoute, ModuleRoute;

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<CustomMapControllerInterface>(
      (i) => CustomMapControllerCubit(
        environment: Modular.get(),
        customLocation: Modular.get(),
        repository: Modular.get(),
      ),
    ),
    Bind.lazySingleton<MapRepository>(
      (i) => MapRepositoryImpl(client: Modular.get()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, __) => MultiBlocProvider(
        providers: [
          BlocProvider<CustomMapControllerInterface>(
            create: (_) => Modular.get(),
          ),
          BlocProvider<PermissionsCubit>(
            create: (context) => PermissionsCubit(
              permissions: Modular.get(),
            ),
          ),
        ],
        child: const HomePage(),
      ),
    ),
    ChildRoute(
      ModulesRoute.homeMapMarker,
      child: (context, __) => BlocProvider.value(
        value: Modular.get<CustomMapControllerInterface>(),
        child: MapMarkerPage(
          model: Modular.args.data,
        ),
      ),
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
