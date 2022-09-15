import 'package:dengue_tcc/app/utils/app_theme/app_shadows/app_shadows.dart';
import 'package:flutter/material.dart';

class CustomDrawerText extends StatelessWidget {
  const CustomDrawerText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        shadows: [
          AppShadows.drawerShador,
        ],
      ),
    );
  }
}
