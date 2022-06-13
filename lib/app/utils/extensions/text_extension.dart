import 'package:flutter/material.dart';

extension TextExtension on BuildContext {
  TextStyle get getPoppins400 => Theme.of(this).textTheme.bodyMedium!.copyWith();
}