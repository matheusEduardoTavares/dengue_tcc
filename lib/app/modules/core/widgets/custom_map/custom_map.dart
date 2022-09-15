import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/utils/app_definitions/app_definitions.dart';
import 'package:dengue_tcc/app/utils/enums/map_styles_enum.dart';
import 'package:dengue_tcc/app/utils/map_utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
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

  @override
  void initState() {
    super.initState();

    _controller = context.read();
    _mapController = MapControllerImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomMapControllerInterface, CustomMapState>(
      bloc: _controller,
      builder: (context, state) {
        return Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(-22.47662684956675, -48.56361525904357),
                zoom: 16,
                maxZoom: 18,
                minZoom: 13,
              ),
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate: MapUtils.getUrl(state.selectedStyle.style),
                  userAgentPackageName: AppDefinitions.appID,
                  additionalOptions: {
                    'accessToken': _controller.getMapKey(),
                  },
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
                mini: true,
                onPressed: () {
                  _controller.goToUserLocation(_mapController);
                },
                child: const Icon(Icons.pin_drop),
              ),
            ),
          ],
        );
      },
    );
  }
}
