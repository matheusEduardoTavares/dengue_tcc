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

  @override
  void addTemporaryMarker(MapController mapController) {
    final currentState = state as CustomMapStateWithMarkers;
    emit(CustomMapAddingMarkerState(
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
    ));
  }

  @override
  void removeTemporaryMarker() {
    final currentState = state as CustomMapStateWithMarkers;
    emit(SuccessGetMarkersCustomMapState(
      selectedStyle: currentState.selectedStyle,
      userPosition: currentState.userPosition,
      markers: currentState.markers,
    ));
  }

  @override
  Future<void> createMarkerOnAPI({
    required String title,
    required String description,
  }) async {
    final currentState = state as CustomMapAddingMarkerState;
    emit(LoadingCustomMapAddingMarkerState(
      selectedStyle: state.selectedStyle,
      userPosition: state.userPosition,
      markers: currentState.markers,
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
        selectedStyle: state.selectedStyle,
        userPosition: state.userPosition,
        markers: currentState.markers,
        temporaryMarkers: currentState.temporaryMarkers,
        errorMessage: errorMessage,
      )),
      (markers) {
        emit(SuccessCustomMapAddingMarkerState(
          selectedStyle: state.selectedStyle,
          userPosition: state.userPosition,
          markers: currentState.markers,
          temporaryMarkers: currentState.temporaryMarkers,
        ));
      },
    );
  }

  @override
  Future<void> getMarkersFromAPI() async {
    emit(LoadingGetMarkersCustomMapState(
      selectedStyle: state.selectedStyle,
      userPosition: state.userPosition,
    ));

    final either = await _repository.getMarkers();
    either.fold(
      (errorMessage) => emit(ErrorGetMarkersCustomMapState(
        selectedStyle: state.selectedStyle,
        userPosition: state.userPosition,
        errorMessage: errorMessage,
      )),
      (markers) {
        emit(SuccessGetMarkersCustomMapState(
          selectedStyle: state.selectedStyle,
          userPosition: state.userPosition,
          markers: markers,
        ));
      },
    );
  }

  @override
  void updateTemporaryMarkerDescription(String description) {
    final currentState = state as CustomMapAddingMarkerState;
    final updatedMarker = currentState.temporaryMarkers[0].copyWith(
      description: description,
    );
    final newList = [updatedMarker];

    emit(
      currentState.copyWith(
        temporaryMarkers: newList,
      ),
    );
  }

  @override
  void updateTemporaryMarkerTitle(String title) {
    final currentState = state as CustomMapAddingMarkerState;
    final updatedMarker = currentState.temporaryMarkers[0].copyWith(
      title: title,
    );
    final newList = [updatedMarker];

    emit(
      currentState.copyWith(
        temporaryMarkers: newList,
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
        temporaryMarkers: newList,
      ),
    );
  }

  @override
  void goToMarkerPage() {
    final currentState = state as CustomMapAddingMarkerState;
    Modular.to.pushNamed(
      ModulesRoute.homeMapMarkerNavigate,
      arguments: currentState.temporaryMarkers[0],
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
        showFinishedMarkers: false,
        showUnfinishedMarkers: true,
        filteredMarkers: unfinishedMarkers,
      ));
    } else if (currentState.showFinishedMarkers == false &&
        currentState.showUnfinishedMarkers) {
      final allMarkers = filterAllMarkers();
      emit(currentState.copyWith(
        showFinishedMarkers: true,
        showUnfinishedMarkers: true,
        filteredMarkers: allMarkers,
      ));
    } else if (currentState.showFinishedMarkers == false &&
        currentState.showUnfinishedMarkers == false) {
      final finishedMarkers = filterFinishedMarkers();
      emit(currentState.copyWith(
        showFinishedMarkers: true,
        showUnfinishedMarkers: false,
        filteredMarkers: finishedMarkers,
      ));
    } else {
      emit(currentState.copyWith(
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
        showFinishedMarkers: true,
        showUnfinishedMarkers: false,
        filteredMarkers: finishedMarkers,
      ));
    } else if (currentState.showFinishedMarkers == false &&
        currentState.showUnfinishedMarkers) {
      emit(currentState.copyWith(
        showFinishedMarkers: false,
        showUnfinishedMarkers: false,
        filteredMarkers: [],
      ));
    } else if (currentState.showFinishedMarkers == false &&
        currentState.showUnfinishedMarkers == false) {
      final unfinishedMarkers = filterUnfinishedMarkers();
      emit(currentState.copyWith(
        showFinishedMarkers: false,
        showUnfinishedMarkers: true,
        filteredMarkers: unfinishedMarkers,
      ));
    } else {
      final allMarkers = filterAllMarkers();
      emit(currentState.copyWith(
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
  void clearTitleAndDescriptionFromTemporaryMarker() {
    if (state is CustomMapAddingMarkerState) {
      final currentState = state as CustomMapAddingMarkerState;
      final updatedMarker = currentState.temporaryMarkers[0].nullify(
        description: true,
        title: true,
      );
      final newList = [updatedMarker];

      emit(
        currentState.copyWith(
          temporaryMarkers: newList,
        ),
      );
    }
  }

  @override
  void clearCreateMarkerOnAPIError() {
    final currentState = state as CustomMapAddingMarkerState;
    emit(CustomMapAddingMarkerState(
      markers: currentState.markers,
      selectedStyle: currentState.selectedStyle,
      temporaryMarkers: currentState.temporaryMarkers,
      userPosition: currentState.userPosition,
      filteredMarkers: currentState.filteredMarkers,
      showFinishedMarkers: currentState.showFinishedMarkers,
      showUnfinishedMarkers: currentState.showUnfinishedMarkers,
    ));
  }
}
