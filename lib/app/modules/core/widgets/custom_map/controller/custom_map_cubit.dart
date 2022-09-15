import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/utils/custom_location/custom_location.dart';
import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_styles_enum.dart';
import 'package:dengue_tcc/app/utils/environment/environment.dart';
import 'package:dengue_tcc/app/utils/environment/environment_keys.dart';
import 'package:flutter_map/plugin_api.dart';

part 'custom_map_state.dart';

class CustomMapControllerCubit extends CustomMapControllerInterface {
  CustomMapControllerCubit({
    required Environment environment,
    required CustomLocation customLocation,
  })  : _environment = environment,
        _customLocation = customLocation,
        super(
          CustomMapState(
            mapController: MapControllerImpl(),
          ),
        );

  final Environment _environment;
  final CustomLocation _customLocation;

  @override
  void changeMapStyle(MapStylesEnum newStyle) {
    emit(state.copyWith(selectedStyle: newStyle));
  }

  @override
  String getMapKey() {
    return _environment.getVariable(EnvironmentKeys.mapAccessToken)!;
  }

  @override
  Future<void> updateUserPosition(MapController mapController) async {
    final userPosition = await _customLocation.getUserLocation();
    emit(state.copyWith(
      userPosition: userPosition,
    ));
  }

  @override
  Future<void> goToUserLocation(MapController mapController) async {
    await updateUserPosition(mapController);

    if (state.userPosition != null) {
      mapController.move(
        state.userPosition!.getIntoLatLongPackage,
        mapController.zoom,
      );
    }
  }
}
