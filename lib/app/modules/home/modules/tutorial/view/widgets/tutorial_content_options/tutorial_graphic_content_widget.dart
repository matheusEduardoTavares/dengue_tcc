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
      imagePath: ImagesPath.dengueGraphic,
      contentText:
          'Como pode ver, o as colunas do gráfico se encontram menores do que era antes, porém ainda não é um momento oportuno para deixarmos passar, além da saúde publica, já que do mesmo jeito que o gráfico se encontra em baixa, o mesmo pode subir e podendo gerar um novo pico da doença, temos que levar em consideração que é o lugar que nós convivemos, portanto é nossa obrigação deixar de forma organizada e limpa, sendo nossas ruas, casas, etc.',
      onTap: onTap,
      selectedBottomNavigatorBarIndex: selectedBottomNavigatorBarIndex,
    );
  }
}
