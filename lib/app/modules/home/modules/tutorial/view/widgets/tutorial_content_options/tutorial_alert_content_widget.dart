import 'package:dengue_tcc/app/modules/home/modules/tutorial/view/widgets/tutorial_content_widget.dart';
import 'package:dengue_tcc/app/utils/images_path/images_path.dart';
import 'package:flutter/material.dart';

class TutorialAlertContentWidget extends StatelessWidget {
  const TutorialAlertContentWidget(
      {required this.onTap,
      required this.selectedBottomNavigatorBarIndex,
      Key? key})
      : super(key: key);

  final ValueChanged<int>? onTap;
  final int selectedBottomNavigatorBarIndex;

  @override
  Widget build(BuildContext context) {
    return TutorialContentWidget(
      imagePath: ImagesPath.dengueSymptons,
      contentText:
          'Por esses e outros motivos devemos evitar que a dengue continue se propagando, assim evitando com que outras pessoas, sendo por exemplo, um deles como nossos entes queridos.',
      onTap: onTap,
      selectedBottomNavigatorBarIndex: selectedBottomNavigatorBarIndex,
      title: 'Sintomas',
    );
  }
}
