import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final themeData = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    fontFamily: 'Poppins',
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      fillColor: AppColors.inputDecorationBackground,
      filled: true,
      hintStyle: const TextStyle(
        color: AppColors.inputDecorationForeground,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: AppColors.selectedIconBlue,
      ),
      displaySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.inputDecorationForeground,
        fontStyle: FontStyle.italic,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
