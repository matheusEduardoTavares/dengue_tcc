import 'package:dengue_tcc/app/modules/core/models/map_marker/map_marker_model.dart';
import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';
import 'package:geolocator/geolocator.dart';

class MapUtils {
  MapUtils._();

  static String getUrl(String mapStyle) {
    return 'https://api.mapbox.com/styles/v1/mapbox/$mapStyle/tiles/{z}/{x}/{y}?access_token={accessToken}';
  }

  static const barraBonitaCityCenterLat = -22.47662684956675;
  static const barraBonitaCityCenterLon = -48.56361525904357;
  static const phone = '+5514981677393';

  static MapMarkerModel? getMarkerIntoLessFiftyMeters({
    required List<MapMarkerModel> markers,
    required MapMarkerModel markerBase,
  }) {
    final lat1 = markerBase.latLngModel.lat;
    final lon1 = markerBase.latLngModel.lon;
    for (final currentMarker in markers) {
      //TODO!: VALIDAR SE DEVE DESCONSIDERAR O FINALIZADO MESMO
      if (markerBase == currentMarker ||
          currentMarker.status == MapMarkerEnum.finished) {
        continue;
      }

      final lat2 = currentMarker.latLngModel.lat;
      final lon2 = currentMarker.latLngModel.lon;

      final distanceBetweenMarkersInMeters =
          Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
      if (distanceBetweenMarkersInMeters < 150.0) {
        return currentMarker;
      }
    }

    return null;
  }
}
