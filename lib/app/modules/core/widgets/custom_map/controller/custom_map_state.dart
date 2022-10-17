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

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    String? errorMessage,
  }) {
    return ErrorGetMarkersCustomMapState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  final String errorMessage;
}

class SuccessGetMarkersCustomMapState extends CustomMapStateWithMarkers {
  SuccessGetMarkersCustomMapState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    super.filteredMarkers,
    super.showFinishedMarkers,
    super.showUnfinishedMarkers,
    super.hasIncrementedMarkerCounter,
    super.selectedMarker,
  });

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    List<MapMarkerModel>? markers,
    List<MapMarkerModel>? filteredMarkers,
    bool? showFinishedMarkers,
    bool? showUnfinishedMarkers,
    bool? hasIncrementedMarkerCounter,
    MapMarkerModel? selectedMarker,
  }) {
    return SuccessGetMarkersCustomMapState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker ?? this.selectedMarker,
      filteredMarkers: filteredMarkers ?? this.filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter:
          hasIncrementedMarkerCounter ?? this.hasIncrementedMarkerCounter,
    );
  }
}

class CustomMapStateWithMarkers extends CustomMapState {
  CustomMapStateWithMarkers({
    required super.selectedStyle,
    required super.userPosition,
    required this.markers,
    this.showFinishedMarkers = true,
    this.showUnfinishedMarkers = true,
    this.filteredMarkers,
    this.hasIncrementedMarkerCounter,
    this.selectedMarker,
  });

  final List<MapMarkerModel> markers;
  final List<MapMarkerModel>? filteredMarkers;
  final bool showFinishedMarkers;
  final bool showUnfinishedMarkers;
  final bool? hasIncrementedMarkerCounter;
  final MapMarkerModel? selectedMarker;

  List<MapMarkerModel> get getFilteredOrAllMarkers =>
      filteredMarkers ?? markers;

  CustomMapState clearSelectedMarker() => CustomMapStateWithMarkers(
        selectedStyle: selectedStyle,
        userPosition: userPosition,
        markers: markers,
        selectedMarker: null,
        hasIncrementedMarkerCounter: null,
        filteredMarkers: filteredMarkers,
        showFinishedMarkers: showFinishedMarkers,
        showUnfinishedMarkers: showUnfinishedMarkers,
      );

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    List<MapMarkerModel>? markers,
    List<MapMarkerModel>? filteredMarkers,
    MapMarkerModel? selectedMarker,
    bool? showFinishedMarkers,
    bool? showUnfinishedMarkers,
    bool? hasIncrementedMarkerCounter,
  }) {
    return CustomMapStateWithMarkers(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker ?? this.selectedMarker,
      filteredMarkers: filteredMarkers ?? this.filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter:
          hasIncrementedMarkerCounter ?? this.hasIncrementedMarkerCounter,
    );
  }
}

class CustomMapAddingMarkerState extends CustomMapStateWithMarkers {
  CustomMapAddingMarkerState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required this.temporaryMarkers,
    super.filteredMarkers,
    super.showFinishedMarkers,
    super.showUnfinishedMarkers,
    super.hasIncrementedMarkerCounter,
    super.selectedMarker,
  });

  final List<MapMarkerModel> temporaryMarkers;

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    List<MapMarkerModel>? temporaryMarkers,
    List<MapMarkerModel>? markers,
    List<MapMarkerModel>? filteredMarkers,
    bool? showFinishedMarkers,
    bool? showUnfinishedMarkers,
    bool? hasIncrementedMarkerCounter,
    MapMarkerModel? selectedMarker,
  }) {
    return CustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker ?? this.selectedMarker,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      hasIncrementedMarkerCounter:
          hasIncrementedMarkerCounter ?? this.hasIncrementedMarkerCounter,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
    );
  }
}

class LoadingCustomMapAddingMarkerState extends CustomMapAddingMarkerState {
  LoadingCustomMapAddingMarkerState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required super.temporaryMarkers,
    super.filteredMarkers,
    super.showFinishedMarkers,
    super.showUnfinishedMarkers,
    super.hasIncrementedMarkerCounter,
    super.selectedMarker,
  });

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    List<MapMarkerModel>? markers,
    List<MapMarkerModel>? filteredMarkers,
    List<MapMarkerModel>? temporaryMarkers,
    bool? showFinishedMarkers,
    bool? showUnfinishedMarkers,
    bool? hasIncrementedMarkerCounter,
    MapMarkerModel? selectedMarker,
  }) {
    return LoadingCustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker ?? this.selectedMarker,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter:
          hasIncrementedMarkerCounter ?? this.hasIncrementedMarkerCounter,
    );
  }
}

class ErrorCustomMapAddingMarkerState extends CustomMapAddingMarkerState {
  ErrorCustomMapAddingMarkerState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required super.temporaryMarkers,
    required this.errorMessage,
    super.filteredMarkers,
    super.showFinishedMarkers,
    super.showUnfinishedMarkers,
    super.hasIncrementedMarkerCounter,
    super.selectedMarker,
  });

  final String errorMessage;

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    List<MapMarkerModel>? markers,
    List<MapMarkerModel>? filteredMarkers,
    List<MapMarkerModel>? temporaryMarkers,
    String? errorMessage,
    bool? showFinishedMarkers,
    bool? showUnfinishedMarkers,
    bool? hasIncrementedMarkerCounter,
    MapMarkerModel? selectedMarker,
  }) {
    return ErrorCustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker ?? this.selectedMarker,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      errorMessage: errorMessage ?? this.errorMessage,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter:
          hasIncrementedMarkerCounter ?? this.hasIncrementedMarkerCounter,
    );
  }
}

class SuccessCustomMapAddingMarkerState extends CustomMapAddingMarkerState {
  SuccessCustomMapAddingMarkerState({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required super.temporaryMarkers,
    super.filteredMarkers,
    super.showFinishedMarkers,
    super.showUnfinishedMarkers,
    super.hasIncrementedMarkerCounter,
    super.selectedMarker,
  });

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    List<MapMarkerModel>? markers,
    List<MapMarkerModel>? filteredMarkers,
    List<MapMarkerModel>? temporaryMarkers,
    bool? showFinishedMarkers,
    bool? showUnfinishedMarkers,
    bool? hasIncrementedMarkerCounter,
    MapMarkerModel? selectedMarker,
  }) {
    return SuccessCustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker ?? this.selectedMarker,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter:
          hasIncrementedMarkerCounter ?? this.hasIncrementedMarkerCounter,
    );
  }
}
