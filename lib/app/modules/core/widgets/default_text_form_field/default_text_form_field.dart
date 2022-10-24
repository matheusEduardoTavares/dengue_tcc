import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.validator,
    this.obscureText,
    this.keyboardType,
    this.inputFormatters,
    this.enabled,
    this.isDescription,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? isDescription;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:
          (isDescription ?? false) ? 3 : ((obscureText ?? false) ? 1 : null),
      enabled: enabled ?? true,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
