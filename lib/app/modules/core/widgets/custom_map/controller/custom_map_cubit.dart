import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/utils/enums/map_styles_enum.dart';
import 'package:dengue_tcc/app/utils/environment/environment.dart';
import 'package:dengue_tcc/app/utils/environment/environment_keys.dart';
import 'package:flutter_map/plugin_api.dart';

part 'custom_map_state.dart';

class CustomMapControllerCubit extends CustomMapControllerInterface {
  CustomMapControllerCubit({
    required Environment environment,
  })  : _environment = environment,
        super(
          CustomMapState(
            mapController: MapControllerImpl(),
          ),
        );

  final Environment _environment;

  @override
  void changeMapStyle(MapStylesEnum newStyle) {
    emit(state.copyWith(selectedStyle: newStyle));
  }

  @override
  String getMapKey() {
    return _environment.getVariable(EnvironmentKeys.mapAccessToken)!;
  }
}
