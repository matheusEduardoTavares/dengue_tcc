import 'package:dengue_tcc/app/modules/home/modules/tutorial/view/widgets/tutorial_bottom_bar_widget.dart';
import 'package:dengue_tcc/app/utils/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class TutorialContentWidget extends StatelessWidget {
  const TutorialContentWidget(
      {required this.imagePath,
      required this.selectedBottomNavigatorBarIndex,
      required this.onTap,
      required this.title,
      this.contentText,
      this.content,
      Key? key})
      : super(key: key);

  final String imagePath;
  final String title;
  final String? contentText;
  final Widget? content;
  final int selectedBottomNavigatorBarIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  title,
                  style: context.getTitle,
                ),
                Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    7,
                  ),
                  child: content ??
                      Text(
                        contentText ?? '',
                        textAlign: TextAlign.center,
                        style: context.getPoppins400,
                      ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 60, 20),
          child: TutorialBottomBarWidget(
            onTap: onTap,
            selectedBottomNavigatorBarIndex: selectedBottomNavigatorBarIndex,
          ),
        )
      ],
    );
  }
}
