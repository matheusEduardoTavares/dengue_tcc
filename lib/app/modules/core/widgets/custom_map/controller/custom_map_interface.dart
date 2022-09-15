import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/utils/enums/map_styles_enum.dart';
import 'package:flutter_map/plugin_api.dart';

abstract class CustomMapControllerInterface extends Cubit<CustomMapState> {
  CustomMapControllerInterface(CustomMapState initialState)
      : super(initialState);

  void changeMapStyle(MapStylesEnum newStyle);
  Future<void> updateUserPosition(MapController mapController);
  Future<void> goToUserLocation(MapController mapController);
  String getMapKey();
}
