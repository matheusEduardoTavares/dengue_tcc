import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/markers_list/view/markers_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MarkersListModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, __) => BlocProvider.value(
        value: Modular.get<CustomMapControllerInterface>(),
        child: MarkersListPage(
          mapController: Modular.args.data,
        ),
      ),
    )
  ];
}
