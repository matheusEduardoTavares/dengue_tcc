export '../../extensions/custom_lat_lng_model_extension.dart';

class CustomLatLngModel {
  CustomLatLngModel({
    required this.lat,
    required this.lon,
    required this.accurracy,
    required this.altitude,
  });

  final double lat;
  final double lon;
  final double accurracy;
  final double altitude;
}
