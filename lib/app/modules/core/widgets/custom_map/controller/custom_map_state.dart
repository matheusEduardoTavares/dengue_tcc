part of 'custom_map_cubit.dart';

class CustomMapState {
  CustomMapState({
    required this.mapController,
    this.selectedStyle = MapStylesEnum.STREET,
    this.userPosition,
  });

  final MapController mapController;
  final MapStylesEnum selectedStyle;
  final CustomLatLngModel? userPosition;

  CustomMapState copyWith({
    MapController? mapController,
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
  }) {
    return CustomMapState(
      mapController: mapController ?? this.mapController,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
    );
  }
}
