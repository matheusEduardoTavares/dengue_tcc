import 'package:dengue_tcc/app/utils/input_formatter/input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatterImpl implements InputFormatter {
  @override
  TextInputFormatter getInputFormatterPhone() => MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );

  @override
  String getPhoneUnmask(String phone) {
    return getNumbersOnly(phone);
  }

  @override
  String getPhoneMask(String phone) {
    final formatter = getInputFormatterPhone() as MaskTextInputFormatter;
    return formatter.maskText(phone).replaceAll('-', '');
  }

  @override
  String getNumbersOnly(String text) => text.replaceAll(RegExp(r'[^0-9]'), '');
}
