import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/repositories/information_repository.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_exception.dart';

class InformationRepositoryImpl implements InformationRepository {
  InformationRepositoryImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<Either<String, InformationModel>> getInformations(
      String endpoint) async {
    const genericErrorMessage = 'Ocorreu um erro ao baixar os dados';
    try {
      //TODO!: QUANDO TIVER OS ENDPOINTS DESCOMENTAR AS LINHAS COMENTADAS ABAIXO E REMOVER O RESTO
      // final response = await _client.auth().get(
      //       endpoint,
      //     );

      // return Right(InformationModel.fromMap(response.data));

      return Right(InformationModel(
        informations: [
          '01/07/22 - Campanha vacinação conta covid, e gripe, mais informações em: https://pt-br.facebook.com/PrefeituradeBarraBonita',
          '01/07/22 - Campanha vacinação conta dengue, mais informações em: https://www.barrabonita.sp.gov.br/public/noticias/campanhas/nebulizacao-contra-a-dengue',
          '01/07/22 - Campanha cidade limpa, mais informações em: https://www.barrabonita.sp.gov.br/noticias/campanhas/projeto-cidade-limpa-continua'
        ],
      ));
    } on RestClientException catch (e) {
      return Left(e.message ?? genericErrorMessage);
    } catch (e) {
      return const Left(genericErrorMessage);
    }
  }
}
