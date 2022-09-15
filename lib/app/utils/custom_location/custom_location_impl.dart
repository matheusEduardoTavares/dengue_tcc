import 'package:dengue_tcc/app/utils/custom_location/custom_location.dart';
import 'package:dengue_tcc/app/utils/custom_location/models/custom_lat_lng_model.dart';
import 'package:geolocator/geolocator.dart';

class CustomLocationImpl implements CustomLocation {
  @override
  Future<CustomLatLngModel> getUserLocation() async {
    final userLocation = await Geolocator.getCurrentPosition();

    return CustomLatLngModel(
      lat: userLocation.latitude,
      lon: userLocation.longitude,
      accurracy: userLocation.accuracy,
      altitude: userLocation.altitude,
    );
  }
}
