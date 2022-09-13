import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AwesomeDialogsControl {
  AwesomeDialogsControl._();

  static Future showAwesomeDialogs({
    required String message,
    required BuildContext context,
    String? title,
    bool? isError,
    DialogType dialogType = DialogType.success,
    VoidCallback? btnOkOnPress,
  }) {
    return AwesomeDialog(
      title: title ?? 'SUCESSO',
      desc: message,
      context: context,
      dialogType: dialogType,
      btnOkOnPress: btnOkOnPress ??
          () {
            Navigator.of(context).pop();
          },
    ).show();
  }
}
