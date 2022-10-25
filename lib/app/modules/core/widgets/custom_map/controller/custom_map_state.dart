part of 'custom_map_cubit.dart';

class CustomMapState {
  CustomMapState({
    this.selectedStyle = MapStylesEnum.STREET,
    this.userPosition,
    this.mapPosition,
  });

  final MapStylesEnum selectedStyle;
  final CustomLatLngModel? userPosition;
  final CustomLatLngModel? mapPosition;

  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    CustomLatLngModel? mapPosition,
  }) {
    return CustomMapState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      mapPosition: mapPosition ?? this.mapPosition,
    );
  }
}

class LoadingGetMarkersCustomMapState extends CustomMapState {
  LoadingGetMarkersCustomMapState({
    required super.selectedStyle,
    required super.userPosition,
    super.mapPosition,
  });
}

class ErrorGetMarkersCustomMapState extends CustomMapState {
  ErrorGetMarkersCustomMapState({
    required super.selectedStyle,
    required super.userPosition,
    required this.errorMessage,
    super.mapPosition,
  });

  @override
  CustomMapState copyWith({
    MapStylesEnum? selectedStyle,
    CustomLatLngModel? userPosition,
    String? errorMessage,
    CustomLatLngModel? mapPosition,
  }) {
    return ErrorGetMarkersCustomMapState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      errorMessage: errorMessage ?? this.errorMessage,
      mapPosition: mapPosition ?? this.mapPosition,
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
    super.mapPosition,
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
    CustomLatLngModel? mapPosition,
  }) {
    return SuccessGetMarkersCustomMapState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      filteredMarkers: filteredMarkers ?? this.filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      mapPosition: mapPosition ?? this.mapPosition,
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
    super.mapPosition,
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
        mapPosition: mapPosition,
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
    CustomLatLngModel? mapPosition,
  }) {
    return CustomMapStateWithMarkers(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      filteredMarkers: filteredMarkers ?? this.filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      mapPosition: mapPosition ?? this.mapPosition,
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
    super.mapPosition,
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
    CustomLatLngModel? mapPosition,
  }) {
    return CustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      mapPosition: mapPosition ?? this.mapPosition,
    );
  }
}

class CustomMapUpdateMarkerSuccess extends CustomMapStateWithMarkers {
  CustomMapUpdateMarkerSuccess({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    super.filteredMarkers,
    super.showFinishedMarkers,
    super.showUnfinishedMarkers,
    super.hasIncrementedMarkerCounter,
    super.selectedMarker,
    super.mapPosition,
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
    CustomLatLngModel? mapPosition,
  }) {
    return CustomMapStateWithMarkers(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      mapPosition: mapPosition ?? this.mapPosition,
    );
  }
}

class CustomMapUpdateMarkerLoading extends CustomMapStateWithMarkers {
  CustomMapUpdateMarkerLoading({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    super.filteredMarkers,
    super.showFinishedMarkers,
    super.showUnfinishedMarkers,
    super.hasIncrementedMarkerCounter,
    super.selectedMarker,
    super.mapPosition,
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
    CustomLatLngModel? mapPosition,
  }) {
    return CustomMapStateWithMarkers(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      mapPosition: mapPosition ?? this.mapPosition,
    );
  }
}

class CustomMapUpdateMarkerError extends CustomMapStateWithMarkers {
  CustomMapUpdateMarkerError({
    required super.selectedStyle,
    required super.userPosition,
    required super.markers,
    required this.errorMessage,
    super.filteredMarkers,
    super.showFinishedMarkers,
    super.showUnfinishedMarkers,
    super.hasIncrementedMarkerCounter,
    super.selectedMarker,
    super.mapPosition,
  });

  final String errorMessage;

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
    String? errorMessage,
    CustomLatLngModel? mapPosition,
  }) {
    return CustomMapUpdateMarkerError(
      errorMessage: errorMessage ?? this.errorMessage,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      mapPosition: mapPosition ?? this.mapPosition,
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
    super.mapPosition,
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
    CustomLatLngModel? mapPosition,
  }) {
    return LoadingCustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      mapPosition: mapPosition ?? this.mapPosition,
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
    super.mapPosition,
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
    CustomLatLngModel? mapPosition,
  }) {
    return ErrorCustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      errorMessage: errorMessage ?? this.errorMessage,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      mapPosition: mapPosition ?? this.mapPosition,
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
    super.mapPosition,
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
    CustomLatLngModel? mapPosition,
  }) {
    return SuccessCustomMapAddingMarkerState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      userPosition: userPosition ?? this.userPosition,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      temporaryMarkers: temporaryMarkers ?? this.temporaryMarkers,
      filteredMarkers: filteredMarkers,
      showFinishedMarkers: showFinishedMarkers ?? this.showFinishedMarkers,
      showUnfinishedMarkers:
          showUnfinishedMarkers ?? this.showUnfinishedMarkers,
      hasIncrementedMarkerCounter: hasIncrementedMarkerCounter,
      mapPosition: mapPosition ?? this.mapPosition,
    );
  }
}
