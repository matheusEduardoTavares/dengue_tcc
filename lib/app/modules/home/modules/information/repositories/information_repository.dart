import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/denunciation/denunciations_model.dart';
import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaign_model.dart';
import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaigns_model.dart';

abstract class InformationRepository {
  InformationRepository._();

  Future<Either<String, DenunciationsModel>> getDenunciations(String endpoint);
  Future<Either<String, NextCampaignsModel>> getNextCampaigns(String endpoint);
  Future<Either<String, NextCampaignModel>> addNextCampaigns({
    required NextCampaignModel nextCampaignModel,
  });
}
