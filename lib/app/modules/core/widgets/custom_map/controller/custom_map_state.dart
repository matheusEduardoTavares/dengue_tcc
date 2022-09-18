part of 'custom_map_cubit.dart';

class CustomMapState {
  CustomMapState({
    this.selectedStyle = MapStylesEnum.STREET,
    this.userPosition,
  });

  final MapStylesEnum selectedStyle;
  final CustomLatLngModel? userPosition;

  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
  }) {
    return CustomMapState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
    );
  }
}

class LoadingGetMarkersCustomMapState extends CustomMapState {
  LoadingGetMarkersCustomMapState({
    required super.selectedStyle,
    required super.userPosition,
  });
}

class ErrorGetMarkersCustomMapState extends CustomMapState {
  ErrorGetMarkersCustomMapState({
    required super.selectedStyle,
    required super.userPosition,
    required this.errorMessage,
  });

  final String errorMessage;
}

class SuccessGetMarkersCustomMapState extends CustomMapStateWithMarkers {
  SuccessGetMarkersCustomMapState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
  });
}

abstract class CustomMapStateWithMarkers extends CustomMapState {
  CustomMapStateWithMarkers({
    required super.selectedStyle,
    required super.userPosition,
    required this.markers,
  });

  final List<MapMarkerModel> markers;
}

class CustomMapAddingMarkerState extends CustomMapStateWithMarkers {
  CustomMapAddingMarkerState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required this.temporaryMarkers,
  });

  final List<MapMarkerModel> temporaryMarkers;

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    List<MapMarkerModel>? temporaryMarkers,
    List<MapMarkerModel>? markers,
  }) {
    return CustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      markers: markers ?? this.markers,
    );
  }
}

class LoadingCustomMapAddingMarkerState extends CustomMapAddingMarkerState {
  LoadingCustomMapAddingMarkerState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required super.temporaryMarkers,
  });
}

class ErrorCustomMapAddingMarkerState extends CustomMapAddingMarkerState {
  ErrorCustomMapAddingMarkerState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required super.temporaryMarkers,
    required this.errorMessage,
  });

  final String errorMessage;
}

class SuccessCustomMapAddingMarkerState extends CustomMapAddingMarkerState {
  SuccessCustomMapAddingMarkerState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required super.temporaryMarkers,
  });
}
