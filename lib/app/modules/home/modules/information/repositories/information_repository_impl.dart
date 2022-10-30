import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/denunciation/denunciations_model.dart';
import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaign_model.dart';
import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaigns_model.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/repositories/information_repository.dart';
import 'package:dengue_tcc/app/utils/rest_client/api_definitions/api_definitions.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_exception.dart';

class InformationRepositoryImpl implements InformationRepository {
  InformationRepositoryImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<Either<String, DenunciationsModel>> getDenunciations(
    String endpoint,
  ) async {
    const genericErrorMessage = 'Ocorreu um erro ao baixar os dados';
    try {
      final response = await _client.auth().get(
            endpoint,
          );

      return Right(DenunciationsModel.fromMap(response.data));
    } on RestClientException catch (e) {
      return Left(e.message ?? genericErrorMessage);
    } catch (e) {
      return const Left(genericErrorMessage);
    }
  }

  @override
  Future<Either<String, NextCampaignsModel>> getNextCampaigns(
      String endpoint) async {
    const genericErrorMessage = 'Ocorreu um erro ao baixar os dados';
    try {
      final response = await _client.auth().get(
            endpoint,
          );

      return Right(NextCampaignsModel.fromMap(response.data));
    } on RestClientException catch (e) {
      return Left(e.message ?? genericErrorMessage);
    } catch (e) {
      return const Left(genericErrorMessage);
    }
  }

  @override
  Future<Either<String, NextCampaignModel>> addNextCampaigns(
      {required NextCampaignModel nextCampaignModel}) async {
    const genericErrorMessage = 'Ocorreu um erro ao atualizar os dados';
    try {
      final response = await _client.auth().post(
            ApiDefinitions.getNextCampaigns,
            data: nextCampaignModel.toMap(),
          );

      return Right(NextCampaignModel.fromMap(response.data));
    } on RestClientException catch (e) {
      return Left(e.message ?? genericErrorMessage);
    } catch (e) {
      return const Left(genericErrorMessage);
    }
  }
}
