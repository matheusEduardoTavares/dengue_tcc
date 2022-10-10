import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/denunciation/denunciation_model.dart';
import 'package:dengue_tcc/app/modules/core/models/denunciation/denunciations_model.dart';
import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaign_model.dart';
import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaigns_model.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/repositories/information_repository.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_exception.dart';

class InformationRepositoryImpl implements InformationRepository {
  InformationRepositoryImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<Either<String, DenunciationsModel>> getDenunciations(
      String endpoint) async {
    const genericErrorMessage = 'Ocorreu um erro ao baixar os dados';
    try {
      //TODO!: QUANDO TIVER OS ENDPOINTS DESCOMENTAR AS LINHAS COMENTADAS ABAIXO E REMOVER O RESTO
      // final response = await _client.auth().get(
      //       endpoint,
      //     );

      // return Right(DenunciationsModel.fromMap(response.data));

      return Right(DenunciationsModel(
        denunciations: [
          DenunciationModel(
            information:
                'Campanha vacinação conta covid, e gripe, mais informações em: https://pt-br.facebook.com/PrefeituradeBarraBonita',
            date: '01/07/22',
            isResolved: false,
          ),
          DenunciationModel(
            information:
                'Campanha vacinação conta dengue, mais informações em: https://www.barrabonita.sp.gov.br/public/noticias/campanhas/nebulizacao-contra-a-dengue',
            date: '02/07/22',
            isResolved: false,
          ),
          DenunciationModel(
            information:
                'Campanha cidade limpa, mais informações em: https://www.barrabonita.sp.gov.br/noticias/campanhas/projeto-cidade-limpa-continua',
            date: '03/07/22',
            isResolved: false,
          ),
        ],
      ));
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
      //TODO!: QUANDO TIVER OS ENDPOINTS DESCOMENTAR AS LINHAS COMENTADAS ABAIXO E REMOVER O RESTO
      // final response = await _client.auth().get(
      //       endpoint,
      //     );

      // return Right(NextCampaignsModel.fromMap(response.data));

      return Right(
        NextCampaignsModel(
          campaigns: [
            NextCampaignModel(
              information:
                  'Campanha vacinação conta covid, e gripe, mais informações em: https://pt-br.facebook.com/PrefeituradeBarraBonita',
              date: '01/07/22',
              urlCampaign:
                  'https://www.facebook.com/photo?fbid=475055307993501&set=a.345768764255490',
            ),
            NextCampaignModel(
                information:
                    'Campanha vacinação conta dengue, mais informações em: https://www.barrabonita.sp.gov.br/public/noticias/campanhas/nebulizacao-contra-a-dengue',
                date: '02/07/22',
                urlCampaign:
                    'https://www.facebook.com/photo?fbid=474339601398405&set=a.345768767588823'),
            NextCampaignModel(
                information:
                    'Campanha cidade limpa, mais informações em: https://www.barrabonita.sp.gov.br/noticias/campanhas/projeto-cidade-limpa-continua',
                date: '03/07/22',
                urlCampaign:
                    'https://www.facebook.com/photo/?fbid=473277221504643&set=a.345768767588823'),
          ],
        ),
      );
    } on RestClientException catch (e) {
      return Left(e.message ?? genericErrorMessage);
    } catch (e) {
      return const Left(genericErrorMessage);
    }
  }
}
