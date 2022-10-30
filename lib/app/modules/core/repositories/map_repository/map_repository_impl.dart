import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/map_marker/map_marker_model.dart';
import 'package:dengue_tcc/app/modules/core/repositories/map_repository/map_repository.dart';
import 'package:dengue_tcc/app/utils/rest_client/api_definitions/api_definitions.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_exception.dart';

class MapRepositoryImpl implements MapRepository {
  MapRepositoryImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<Either<String, void>> addMarker(MapMarkerModel model) async {
    const genericErrorMessage = 'Ocorreu um erro ao adicionar o alerta';
    try {
      await _client.auth().post(
            ApiDefinitions.addMarker,
            data: model.toMap(),
          );

      return const Right(null);
    } on RestClientException catch (e) {
      return Left(e.message ?? genericErrorMessage);
    } catch (e) {
      return const Left(genericErrorMessage);
    }
  }

  @override
  Future<Either<String, List<MapMarkerModel>>> getMarkers() async {
    const genericErrorMessage = 'Ocorreu um erro ao baixar os alertas';
    try {
      final response = await _client.auth().get(
            ApiDefinitions.marker,
          );

      final markers = List<Map<String, dynamic>>.from(response.data)
          .map(MapMarkerModel.fromMap)
          .toList();

      return Right(markers);
    } on RestClientException catch (e) {
      return Left(e.message ?? genericErrorMessage);
    } catch (e) {
      return const Left(genericErrorMessage);
    }
  }

  @override
  Future<Either<String, void>> updateMarker({
    required MapMarkerModel model,
    required bool isSendMarkersQuantity,
  }) async {
    const genericErrorMessage = 'Ocorreu um erro ao atualizar o alerta';
    try {
      await _client.auth().put(
            ApiDefinitions.updateMarker(
              markerID: model.id!,
            ),
            data: model.toMap(
              isSendMarkersQuantity: isSendMarkersQuantity,
            ),
          );

      return const Right(null);
    } on RestClientException catch (e) {
      return Left(e.message ?? genericErrorMessage);
    } catch (e) {
      return const Left(genericErrorMessage);
    }
  }
}
