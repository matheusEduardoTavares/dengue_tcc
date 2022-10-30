import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/map_marker/map_marker_model.dart';

abstract class MapRepository {
  Future<Either<String, void>> addMarker(MapMarkerModel model);
  Future<Either<String, void>> updateMarker({
    required MapMarkerModel model,
    required bool isSendMarkersQuantity,
  });
  Future<Either<String, List<MapMarkerModel>>> getMarkers();
}
