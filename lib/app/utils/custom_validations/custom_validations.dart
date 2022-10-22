import 'package:flutter/material.dart';

class CustomValidations {
  CustomValidations._();

  static FormFieldValidator url(String errorText) {
    return (typedText) {
      if (Uri.tryParse(typedText ?? '')?.host.isEmpty ?? true) {
        return errorText;
      }
      return null;
    };
  }
}
