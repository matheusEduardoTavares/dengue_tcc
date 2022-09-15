//TODO!: QUANDO TIVER OS ENDPOINTS VIM FAZER AQUI
enum InformationEnum {
  nextCampaigns(
    title: 'Próximas campanhas',
    endpoint: '',
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
