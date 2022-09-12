import 'package:flutter/material.dart';

extension TextExtension on BuildContext {
  TextStyle get getPoppins400 =>
      Theme.of(this).textTheme.bodyMedium!.copyWith();

  TextStyle get getTitle => Theme.of(this).textTheme.titleLarge!;
  TextStyle get getDisplaySmall => Theme.of(this).textTheme.displaySmall!;
}
