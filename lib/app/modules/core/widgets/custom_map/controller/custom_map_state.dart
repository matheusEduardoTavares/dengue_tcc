part of 'custom_map_cubit.dart';

class CustomMapState {
  CustomMapState({
    required this.mapController,
    this.selectedStyle = MapStylesEnum.STREET,
  });

  final MapController mapController;
  final MapStylesEnum selectedStyle;

  CustomMapState copyWith({
    MapController? mapController,
    MapStylesEnum? selectedStyle,
  }) {
    return CustomMapState(
      mapController: mapController ?? this.mapController,
      selectedStyle: selectedStyle ?? this.selectedStyle,
    );
  }
}
