//TODO!: QUANDO TIVER OS ENDPOINTS VIM FAZER AQUI
import 'package:dengue_tcc/app/utils/rest_client/api_definitions/api_definitions.dart';

enum InformationEnum {
  nextCampaigns(
    title: 'Campanhas',
    endpoint: ApiDefinitions.getNextCampaigns,
  ),
  denunciation(
    title: 'Denúncias',
    endpoint: '',
  );

  final String title;
  final String endpoint;
  const InformationEnum({
    required this.title,
    required this.endpoint,
  });
}
