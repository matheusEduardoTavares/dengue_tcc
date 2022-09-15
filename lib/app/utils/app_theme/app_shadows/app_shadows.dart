import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static List<Shadow> getShadows({Color? shadowColor}) => <Shadow>[
        Shadow(
          blurRadius: 60.0,
          color: shadowColor ?? AppColors.selectedIconBlue,
        ),
        Shadow(
          blurRadius: 60.0,
          color: shadowColor ?? AppColors.selectedIconBlue,
        ),
        Shadow(
          blurRadius: 60.0,
          color: shadowColor ?? AppColors.selectedIconBlue,
        ),
      ];

  static const drawerShador = Shadow(
    color: AppColors.purpleShadow,
    offset: Offset(0, 4),
    blurRadius: 20,
  );
}
