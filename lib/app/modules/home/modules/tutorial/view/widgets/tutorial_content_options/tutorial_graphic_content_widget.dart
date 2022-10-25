import 'package:dengue_tcc/app/modules/home/modules/tutorial/view/widgets/tutorial_content_widget.dart';
import 'package:dengue_tcc/app/utils/images_path/images_path.dart';
import 'package:flutter/material.dart';

class TutorialGraphicContentWidget extends StatelessWidget {
  const TutorialGraphicContentWidget(
      {required this.onTap,
      required this.selectedBottomNavigatorBarIndex,
      Key? key})
      : super(key: key);

  final ValueChanged<int>? onTap;
  final int selectedBottomNavigatorBarIndex;

  @override
  Widget build(BuildContext context) {
    return TutorialContentWidget(
      title: 'Gráfico',
      imagePath: ImagesPath.dengueGraphic,
      contentText:
          'De acordo com a Prefeitura da Estância Turística de Barra Bonita (2021), foram registrados 2 casos em 2021; 1 caso em 2020; 12 casos em 2019 e nenhum caso em 2018. Com base nestes números,  verifica-se que a cidade vêm registrando poucos casos da doença nos últimos anos, indicativo de que os órgãos públicos podem estar executando bem sua função de monitoramento e conscientização da população. No entanto, deve-se fazer uma ressalva: a pandemia de covid-19 levou as pessoas a passarem maior tempo em casa, podendo se dedicar mais a cuidar do ambiente doméstico e assim eliminar, com maior eficiência, possíveis focos de proliferação.'
          ' Outra consideração corresponde a questão dos baixos índices de casos não representarem, necessariamente, a eficiência da atuação das equipes gestoras dos municípios na eliminação de focos do mosquito, isto porque a alteração das taxas de infecção é uma característica intrínseca à doença, uma vez que depende-se de muitos parâmetros sociais e, principalmente, do envolvimento e consciência de muitas pessoas em prol de realizar ações com o objetivo de eliminar o vetor desta doença.'
          ' Portanto, os dados fornecidos pela prefeitura não nos levam a muitas conclusões sobre a real situação no município.',
      onTap: onTap,
      selectedBottomNavigatorBarIndex: selectedBottomNavigatorBarIndex,
    );
  }
}
