import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';

abstract class CustomLocation {
  Future<CustomLatLngModel> getUserLocation();
}
