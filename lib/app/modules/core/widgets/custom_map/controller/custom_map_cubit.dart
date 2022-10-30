import 'package:dengue_tcc/app/modules/core/models/map_marker/map_marker_model.dart';
import 'package:dengue_tcc/app/modules/core/repositories/map_repository/map_repository.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/utils/custom_location/custom_location.dart';
import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';
import 'package:dengue_tcc/app/utils/enums/map_styles_enum.dart';
import 'package:dengue_tcc/app/utils/environment/environment.dart';
import 'package:dengue_tcc/app/utils/environment/environment_keys.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:collection/collection.dart';

part 'custom_map_state.dart';

class CustomMapControllerCubit extends CustomMapControllerInterface {
  CustomMapControllerCubit({
    required Environment environment,
    required CustomLocation customLocation,
    required MapRepository repository,
  })  : _environment = environment,
        _customLocation = customLocation,
        _repository = repository,
        super(
          CustomMapState(),
        );

  final Environment _environment;
  final CustomLocation _customLocation;
  final MapRepository _repository;

  @override
  void changeMapStyle(MapStylesEnum newStyle) {
    emit(state.copyWith(
      selectedStyle: newStyle,
      mapPosition: state.mapPosition,
      userPosition: state.userPosition,
    ));
  }

  @override
  String getMapKey() {
    return _environment.getVariable(EnvironmentKeys.mapAccessToken)!;
  }

  @override
  Future<void> updateUserPosition(MapController mapController) async {
    final userPosition = await _customLocation.getUserLocation();
    emit(state.copyWith(
      mapPosition: state.mapPosition,
      userPosition: userPosition,
      selectedStyle: state.selectedStyle,
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

  @override
  void addTemporaryMarker(MapController mapController) {
    final currentState = state as CustomMapStateWithMarkers;
    emit(CustomMapAddingMarkerState(
      mapPosition: state.mapPosition,
      selectedStyle: state.selectedStyle,
      userPosition: state.userPosition,
      temporaryMarkers: [
        MapMarkerModel(
          status: MapMarkerEnum.active,
          latLngModel: CustomLatLngModel(
            lat: mapController.center.latitude,
            lon: mapController.center.longitude,
          ),
        )
      ],
      markers: currentState.markers,
      hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
      filteredMarkers: currentState.filteredMarkers,
      selectedMarker: currentState.selectedMarker,
      showFinishedMarkers: currentState.showFinishedMarkers,
      showUnfinishedMarkers: currentState.showUnfinishedMarkers,
    ));
  }

  @override
  void removeTemporaryMarker() {
    final currentState = state as CustomMapStateWithMarkers;
    emit(CustomMapStateWithMarkers(
      mapPosition: state.mapPosition,
      selectedStyle: state.selectedStyle,
      userPosition: state.userPosition,
      markers: currentState.markers,
      filteredMarkers: currentState.filteredMarkers,
      hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
      selectedMarker: currentState.selectedMarker,
      showFinishedMarkers: currentState.showFinishedMarkers,
      showUnfinishedMarkers: currentState.showUnfinishedMarkers,
    ));
  }

  @override
  Future<void> createMarkerOnAPI({
    required String title,
    required String description,
  }) async {
    final currentState = state as CustomMapAddingMarkerState;
    emit(LoadingCustomMapAddingMarkerState(
      mapPosition: state.mapPosition,
      selectedStyle: state.selectedStyle,
      userPosition: state.userPosition,
      markers: currentState.markers,
      filteredMarkers: currentState.filteredMarkers,
      hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
      selectedMarker: currentState.selectedMarker,
      showFinishedMarkers: currentState.showFinishedMarkers,
      showUnfinishedMarkers: currentState.showUnfinishedMarkers,
      temporaryMarkers: currentState.temporaryMarkers,
    ));

    final either = await _repository.addMarker(
      currentState.temporaryMarkers[0].copyWith(
        title: title,
        description: description,
      ),
    );

    either.fold(
      (errorMessage) => emit(ErrorCustomMapAddingMarkerState(
        mapPosition: state.mapPosition,
        selectedStyle: state.selectedStyle,
        userPosition: state.userPosition,
        markers: currentState.markers,
        filteredMarkers: currentState.filteredMarkers,
        hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
        selectedMarker: currentState.selectedMarker,
        showFinishedMarkers: currentState.showFinishedMarkers,
        showUnfinishedMarkers: currentState.showUnfinishedMarkers,
        temporaryMarkers: currentState.temporaryMarkers,
        errorMessage: errorMessage,
      )),
      (markers) {
        emit(SuccessCustomMapAddingMarkerState(
          mapPosition: state.mapPosition,
          selectedStyle: state.selectedStyle,
          userPosition: state.userPosition,
          markers: currentState.markers,
          filteredMarkers: currentState.filteredMarkers,
          hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
          selectedMarker: currentState.selectedMarker,
          showFinishedMarkers: currentState.showFinishedMarkers,
          showUnfinishedMarkers: currentState.showUnfinishedMarkers,
          temporaryMarkers: currentState.temporaryMarkers,
        ));
      },
    );
  }

  @override
  Future<void> getMarkersFromAPI() async {
    emit(LoadingGetMarkersCustomMapState(
      mapPosition: state.mapPosition,
      selectedStyle: state.selectedStyle,
      userPosition: state.userPosition,
    ));

    final either = await _repository.getMarkers();
    either.fold(
      (errorMessage) => emit(ErrorGetMarkersCustomMapState(
        mapPosition: state.mapPosition,
        selectedStyle: state.selectedStyle,
        userPosition: state.userPosition,
        errorMessage: errorMessage,
      )),
      (markers) {
        emit(SuccessGetMarkersCustomMapState(
          mapPosition: state.mapPosition,
          selectedStyle: state.selectedStyle,
          userPosition: state.userPosition,
          markers: markers,
        ));
      },
    );
  }

  @override
  void updateTemporaryMarkerDescription(String description) {
    final currentState = state as CustomMapStateWithMarkers;
    final updatedMarker = currentState.selectedMarker!.copyWith(
      description: description,
    );

    emit(
      currentState.copyWith(
        mapPosition: state.mapPosition,
        selectedMarker: updatedMarker,
      ),
    );
  }

  @override
  void updateTemporaryMarkerTitle(String title) {
    final currentState = state as CustomMapStateWithMarkers;
    final updatedMarker = currentState.selectedMarker!.copyWith(
      title: title,
    );

    emit(
      currentState.copyWith(
        mapPosition: state.mapPosition,
        selectedMarker: updatedMarker,
      ),
    );
  }

  @override
  void updateTemporaryMarkerPosition(CustomLatLngModel latLngModel) {
    final currentState = state as CustomMapAddingMarkerState;
    final updatedMarker = currentState.temporaryMarkers[0].copyWith(
      latLngModel: latLngModel,
    );
    final newList = [updatedMarker];

    emit(
      currentState.copyWith(
        mapPosition: state.mapPosition,
        temporaryMarkers: newList,
      ),
    );
  }

  @override
  List<MapMarkerModel> filterAllMarkers() {
    final currentState = state as CustomMapStateWithMarkers;

    return currentState.markers;
  }

  @override
  List<MapMarkerModel> filterFinishedMarkers() {
    final currentState = state as CustomMapStateWithMarkers;
    return _filterMarkersBasedOnStatus(
      allMarkers: currentState.markers,
      status: MapMarkerEnum.finished,
    );
  }

  @override
  List<MapMarkerModel> filterUnfinishedMarkers() {
    final currentState = state as CustomMapStateWithMarkers;
    return _filterMarkersBasedOnStatus(
      allMarkers: currentState.markers,
      status: MapMarkerEnum.active,
    );
  }

  List<MapMarkerModel> _filterMarkersBasedOnStatus({
    required MapMarkerEnum status,
    required List<MapMarkerModel> allMarkers,
  }) {
    return allMarkers.fold<List<MapMarkerModel>>([], (previousValue, element) {
      if (element.status == status) {
        previousValue.add(element);
      }

      return previousValue;
    });
  }

  @override
  void toggleFinishedMarkers() {
    final currentState = state as CustomMapStateWithMarkers;

    if (currentState.showFinishedMarkers &&
        currentState.showUnfinishedMarkers) {
      final unfinishedMarkers = filterUnfinishedMarkers();
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        showFinishedMarkers: false,
        showUnfinishedMarkers: true,
        filteredMarkers: unfinishedMarkers,
      ));
    } else if (currentState.showFinishedMarkers == false &&
        currentState.showUnfinishedMarkers) {
      final allMarkers = filterAllMarkers();
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        showFinishedMarkers: true,
        showUnfinishedMarkers: true,
        filteredMarkers: allMarkers,
      ));
    } else if (currentState.showFinishedMarkers == false &&
        currentState.showUnfinishedMarkers == false) {
      final finishedMarkers = filterFinishedMarkers();
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        showFinishedMarkers: true,
        showUnfinishedMarkers: false,
        filteredMarkers: finishedMarkers,
      ));
    } else {
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        showFinishedMarkers: false,
        showUnfinishedMarkers: false,
        filteredMarkers: [],
      ));
    }
  }

  @override
  void toggleUnfinishedMarkers() {
    final currentState = state as CustomMapStateWithMarkers;

    if (currentState.showFinishedMarkers &&
        currentState.showUnfinishedMarkers) {
      final finishedMarkers = filterFinishedMarkers();
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        showFinishedMarkers: true,
        showUnfinishedMarkers: false,
        filteredMarkers: finishedMarkers,
      ));
    } else if (currentState.showFinishedMarkers == false &&
        currentState.showUnfinishedMarkers) {
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        showFinishedMarkers: false,
        showUnfinishedMarkers: false,
        filteredMarkers: [],
      ));
    } else if (currentState.showFinishedMarkers == false &&
        currentState.showUnfinishedMarkers == false) {
      final unfinishedMarkers = filterUnfinishedMarkers();
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        showFinishedMarkers: false,
        showUnfinishedMarkers: true,
        filteredMarkers: unfinishedMarkers,
      ));
    } else {
      final allMarkers = filterAllMarkers();
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        showFinishedMarkers: true,
        showUnfinishedMarkers: true,
        filteredMarkers: allMarkers,
      ));
    }
  }

  @override
  void flyToMarker({
    required MapMarkerModel marker,
    required MapController mapController,
    required VoidCallback closePage,
  }) {
    mapController.move(
      marker.latLngModel.getIntoLatLongPackage,
      mapController.zoom,
    );

    closePage();
  }

  @override
  void clearCreateMarkerOnAPIError() {
    final currentState = state as CustomMapAddingMarkerState;
    emit(CustomMapAddingMarkerState(
      mapPosition: state.mapPosition,
      markers: currentState.markers,
      selectedStyle: currentState.selectedStyle,
      temporaryMarkers: currentState.temporaryMarkers,
      userPosition: currentState.userPosition,
      filteredMarkers: currentState.filteredMarkers,
      showFinishedMarkers: currentState.showFinishedMarkers,
      showUnfinishedMarkers: currentState.showUnfinishedMarkers,
      hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
      selectedMarker: currentState.selectedMarker,
    ));
  }

  @override
  void incrementTemporaryMarkerCounter() {
    final currentState = state as CustomMapStateWithMarkers;
    emit(currentState.copyWith(
      mapPosition: state.mapPosition,
      selectedMarker: currentState.selectedMarker!.copyWith(
        counter: currentState.selectedMarker!.counter + 1,
      ),
      hasIncrementedMarkerCounter: true,
    ));
  }

  @override
  void decrementTemporaryMarkerCounter() {
    final currentState = state as CustomMapStateWithMarkers;
    emit(currentState.copyWith(
      mapPosition: state.mapPosition,
      selectedMarker: currentState.selectedMarker!.copyWith(
        counter: currentState.selectedMarker!.counter - 1,
      ),
      hasIncrementedMarkerCounter: false,
    ));
  }

  @override
  void openMarkerPage({
    required bool isCreatingMarker,
    MapMarkerModel? markerToUpdate,
  }) {
    if (isCreatingMarker) {
      final currentState = state as CustomMapAddingMarkerState;
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        selectedMarker: currentState.temporaryMarkers[0].copyWith(),
      ));
    } else {
      final currentState = state as CustomMapStateWithMarkers;
      emit(currentState.copyWith(
        mapPosition: state.mapPosition,
        selectedMarker: markerToUpdate,
      ));
    }

    Modular.to.pushNamed(
      ModulesRoute.homeMapMarkerNavigate,
    );
  }

  @override
  void clearUpdateMarkerOnAPIError() {
    final currentState = state as CustomMapStateWithMarkers;
    emit(CustomMapStateWithMarkers(
      mapPosition: state.mapPosition,
      markers: currentState.markers,
      selectedStyle: currentState.selectedStyle,
      userPosition: currentState.userPosition,
      filteredMarkers: currentState.filteredMarkers,
      showFinishedMarkers: currentState.showFinishedMarkers,
      showUnfinishedMarkers: currentState.showUnfinishedMarkers,
      hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
      selectedMarker: currentState.selectedMarker,
    ));
  }

  @override
  Future<void> updateMarkerOnAPI({
    required String title,
    required String description,
  }) async {
    final currentState = state as CustomMapStateWithMarkers;
    emit(CustomMapUpdateMarkerLoading(
      mapPosition: state.mapPosition,
      selectedStyle: state.selectedStyle,
      userPosition: state.userPosition,
      markers: currentState.markers,
      filteredMarkers: currentState.filteredMarkers,
      hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
      selectedMarker: currentState.selectedMarker,
      showFinishedMarkers: currentState.showFinishedMarkers,
      showUnfinishedMarkers: currentState.showUnfinishedMarkers,
    ));

    final associatedMarker = currentState.selectedMarker!.isCreatedMarker
        ? currentState.markers.firstWhereOrNull(
            (element) => element.id == currentState.selectedMarker!.id,
          )
        : null;
    final isSendMarkersQuantity = associatedMarker != null &&
        associatedMarker.counter < currentState.selectedMarker!.counter;

    final either = await _repository.updateMarker(
      model: currentState.selectedMarker!.copyWith(
        title: title,
        description: description,
      ),
      isSendMarkersQuantity: isSendMarkersQuantity,
    );

    either.fold(
      (errorMessage) => emit(CustomMapUpdateMarkerError(
        mapPosition: state.mapPosition,
        selectedStyle: state.selectedStyle,
        userPosition: state.userPosition,
        markers: currentState.markers,
        filteredMarkers: currentState.filteredMarkers,
        hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
        selectedMarker: currentState.selectedMarker,
        showFinishedMarkers: currentState.showFinishedMarkers,
        showUnfinishedMarkers: currentState.showUnfinishedMarkers,
        errorMessage: errorMessage,
      )),
      (markers) {
        emit(CustomMapUpdateMarkerSuccess(
          mapPosition: state.mapPosition,
          selectedStyle: state.selectedStyle,
          userPosition: state.userPosition,
          markers: currentState.markers,
          filteredMarkers: currentState.filteredMarkers,
          hasIncrementedMarkerCounter: currentState.hasIncrementedMarkerCounter,
          selectedMarker: currentState.selectedMarker,
          showFinishedMarkers: currentState.showFinishedMarkers,
          showUnfinishedMarkers: currentState.showUnfinishedMarkers,
        ));
      },
    );
  }

  @override
  void markSelectedMarkerWithinFinished() {
    final currentState = state as CustomMapStateWithMarkers;
    emit(currentState.copyWith(
      mapPosition: state.mapPosition,
      selectedMarker: currentState.selectedMarker!.copyWith(
        status: MapMarkerEnum.finished,
      ),
    ));
  }

  @override
  void clearSelectedMarkerCounter() {
    final currentState = state as CustomMapStateWithMarkers;
    emit(currentState.copyWith(
      mapPosition: state.mapPosition,
      hasIncrementedMarkerCounter: null,
      selectedMarker: null,
    ));
  }

  @override
  Future<void> updateApproximatedMarkerCounter({
    required MapMarkerModel approximatedMarker,
  }) async {
    try {
      final currentState = state as CustomMapStateWithMarkers;
      emit(currentState.copyWith(
          mapPosition: state.mapPosition,
          selectedMarker: approximatedMarker.copyWith(
            counter: approximatedMarker.counter + 1,
          )));

      await updateMarkerOnAPI(
        title: approximatedMarker.title!,
        description: approximatedMarker.description!,
      );
    } finally {
      clearSelectedMarkerCounter();
    }
  }

  @override
  void updateMapPosition({required CustomLatLngModel latLng}) {
    emit(state.copyWith(
      mapPosition: latLng,
    ));
  }
}
