export '../../extensions/custom_lat_lng_model_extension.dart';

class CustomLatLngModel {
  CustomLatLngModel({
    required this.lat,
    required this.lon,
    this.accurracy,
    this.altitude,
    this.zoom,
  });

  final double lat;
  final double lon;
  final double? accurracy;
  final double? altitude;
  final double? zoom;
}
