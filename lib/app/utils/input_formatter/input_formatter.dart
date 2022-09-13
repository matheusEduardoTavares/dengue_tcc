import 'package:flutter/services.dart';

abstract class InputFormatter {
  TextInputFormatter getInputFormatterPhone();
  String getPhoneUnmask(String phone);
  String getPhoneMask(String phone);
  String getNumbersOnly(String text);
}
