import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';
import 'package:latlong2/latlong.dart';

extension CustomLatLngModelExtension on CustomLatLngModel {
  LatLng get getIntoLatLongPackage => LatLng(lat, lon);
}
