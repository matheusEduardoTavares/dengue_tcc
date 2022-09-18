import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_styles_enum.dart';
import 'package:flutter_map/plugin_api.dart';

abstract class CustomMapControllerInterface extends Cubit<CustomMapState> {
  CustomMapControllerInterface(CustomMapState initialState)
      : super(initialState);

  void changeMapStyle(MapStylesEnum newStyle);
  Future<void> updateUserPosition(MapController mapController);
  Future<void> goToUserLocation(MapController mapController);
  void goToMarkerPage();
  void addTemporaryMarker(MapController mapController);
  void removeTemporaryMarker();
  void updateTemporaryMarkerTitle(String title);
  void updateTemporaryMarkerPosition(CustomLatLngModel latLngModel);
  void updateTemporaryMarkerDescription(String description);
  Future<void> createMarkerOnAPI({
    required String title,
    required String description,
  });
  Future<void> getMarkersFromAPI();
  String getMapKey();
}
