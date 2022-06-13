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
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}