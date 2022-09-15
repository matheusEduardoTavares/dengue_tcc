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

  static const informationItemShadow = BoxShadow(
    color: AppColors.informationItemShadowColor,
    blurRadius: 5,
    spreadRadius: 5,
  );

  static final informationContentShadow = BoxShadow(
    color: AppColors.informationBackgroundColor,
    blurRadius: 5,
    spreadRadius: 5,
  );
}
