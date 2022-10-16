import 'package:dengue_tcc/app/modules/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/map_marker/map_marker_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/general_error/general_error_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:dengue_tcc/app/utils/app_definitions/app_definitions.dart';
import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_styles_enum.dart';
import 'package:dengue_tcc/app/utils/map_utils/map_utils.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;
import 'package:latlong2/latlong.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({
    super.key,
  });

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  late CustomMapControllerInterface _controller;
  late MapController _mapController;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();

    _scaffoldKey = GlobalKey<ScaffoldState>();
    _controller = context.read()..getMarkersFromAPI();
    _mapController = MapControllerImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        mapController: _mapController,
      ),
      body: BlocConsumer<CustomMapControllerInterface, CustomMapState>(
        bloc: _controller,
        listenWhen: (_, currentState) =>
            currentState is SuccessCustomMapAddingMarkerState,
        listener: (context, state) async {
          if (state is SuccessCustomMapAddingMarkerState) {
            _controller
              ..removeTemporaryMarker()
              ..getMarkersFromAPI();

            Modular.to.pop();
          }
        },
        builder: (context, state) {
          if (state is LoadingGetMarkersCustomMapState ||
              state is LoadingCustomMapAddingMarkerState) {
            return const LoadingWidget();
          }

          if (state is ErrorGetMarkersCustomMapState) {
            return GeneralErrorWidget(
              retryCallback: () {
                _controller.getMarkersFromAPI();
              },
              title: 'Erro ao baixar os pontos',
            );
          }

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(
                    MapUtils.barraBonitaCityCenterLat,
                    MapUtils.barraBonitaCityCenterLon,
                  ),
                  zoom: 16,
                  maxZoom: 18,
                  minZoom: 13,
                  onTap: state is CustomMapAddingMarkerState
                      ? (_, position) {
                          _controller.updateTemporaryMarkerPosition(
                            CustomLatLngModel(
                              lat: position.latitude,
                              lon: position.longitude,
                            ),
                          );
                        }
                      : null,
                ),
                children: [
                  TileLayer(
                    urlTemplate: MapUtils.getUrl(state.selectedStyle.style),
                    userAgentPackageName: AppDefinitions.appID,
                    additionalOptions: {
                      'accessToken': _controller.getMapKey(),
                    },
                  ),
                  MarkerLayer(
                    markers: (state as CustomMapStateWithMarkers)
                        .getFilteredOrAllMarkers
                        .map(
                          (e) => Marker(
                            point: e.latLngModel.getIntoLatLongPackage,
                            height: 20,
                            width: 20,
                            builder: (_) => InkWell(
                              onTap: () {
                                Modular.to.pushNamed(
                                  ModulesRoute.homeMapMarkerNavigate,
                                  arguments: e,
                                );
                              },
                              child: MapMarkerWidget(
                                marker: e,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  if (state is CustomMapAddingMarkerState)
                    MarkerLayer(
                      markers: state.temporaryMarkers
                          .map(
                            (e) => Marker(
                              point: e.latLngModel.getIntoLatLongPackage,
                              height: 40,
                              width: 40,
                              builder: (_) => Container(
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.informationItemBackgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: const [
                                    Text(
                                      'novo',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: MapMarkerWidget(
                                          color: AppColors.purpleShadow,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
              ...MapStylesEnum.values
                  .asMap()
                  .map(
                    (index, currentEnum) => MapEntry(
                      index,
                      Positioned(
                        right: 20,
                        top: 60.0 * (index + 1),
                        child: FloatingActionButton(
                          heroTag: index,
                          mini: true,
                          onPressed: () {
                            _controller.changeMapStyle(currentEnum);
                          },
                          child: Icon(currentEnum.iconData),
                        ),
                      ),
                    ),
                  )
                  .values,
              Positioned(
                left: 20,
                top: 60.0,
                child: FloatingActionButton(
                  heroTag: 'map-1',
                  mini: true,
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: const Icon(Icons.more_vert),
                ),
              ),
              Positioned(
                left: 20,
                top: 120.0,
                child: FloatingActionButton(
                  heroTag: 'map-2',
                  mini: true,
                  onPressed: () {
                    _controller.goToUserLocation(_mapController);
                  },
                  child: const Icon(Icons.pin_drop),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 60.0,
                child: FloatingActionButton(
                  heroTag: 'map-3',
                  onPressed: () {
                    if (state is CustomMapAddingMarkerState) {
                      _controller.goToMarkerPage();
                    } else {
                      _controller.addTemporaryMarker(_mapController);
                    }
                  },
                  child: Icon(
                    state is CustomMapAddingMarkerState
                        ? Icons.check
                        : Icons.add,
                  ),
                ),
              ),
              if (state is CustomMapAddingMarkerState)
                Positioned(
                  left: 20,
                  bottom: 120.0,
                  child: FloatingActionButton(
                    heroTag: 'map-4',
                    onPressed: () {
                      _controller.removeTemporaryMarker();
                    },
                    child: const Icon(Icons.cancel_outlined),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
