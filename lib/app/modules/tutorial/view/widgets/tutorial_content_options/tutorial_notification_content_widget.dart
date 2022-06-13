import 'package:dengue_tcc/app/modules/tutorial/view/widgets/tutorial_content_widget.dart';
import 'package:dengue_tcc/app/utils/extensions/text_extension.dart';
import 'package:dengue_tcc/app/utils/images_path/images_path.dart';
import 'package:flutter/material.dart';

class TutorialNotificationContentWidget extends StatelessWidget {
  const TutorialNotificationContentWidget({
    required this.onTap,
    required this.selectedBottomNavigatorBarIndex,
    Key? key
  }) : super(key: key);

  final ValueChanged<int>? onTap;
  final int selectedBottomNavigatorBarIndex;

  @override
  Widget build(BuildContext context) {
    return TutorialContentWidget(
      imagePath: ImagesPath.dengueFight,
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Diga não a falta de empatia, pense no próximo e comece por ',
          style: context.getPoppins400,
          children: [
            TextSpan(
              text: 'você!\n',
              style: context.getPoppins400.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                  text: 'O primeiro passo sempre vem de nós mesmos,'
                    'e para começarmos a se proteger contra a dengue, '
                    'por incrível que pareça é bem simples!\n\n'
                    'Com o simples ato de:\n'
                    'Retirar folhas de calhas para deixar a água livre, evitando acumulo de água parada, remover poças de água, '
                    'fazer o descarte corretamente de pneus e garrafas pet, fechando totalmente piscinas e caixas d’gua, etc.',
                  style: context.getPoppins400,
                ),
              ],
            ),
          ] 
        ),
      ),
      onTap: onTap,
      selectedBottomNavigatorBarIndex: selectedBottomNavigatorBarIndex,
    );
  }
}