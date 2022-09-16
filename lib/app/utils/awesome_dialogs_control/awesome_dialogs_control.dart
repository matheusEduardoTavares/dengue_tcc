import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
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
            title: title ?? ((isError ?? false) ? 'ERRO' : 'SUCESSO'),
            desc: message,
            context: context,
            dialogType: (isError ?? false) ? DialogType.error : dialogType,
            btnOkOnPress: btnOkOnPress ??
                () {
                  Navigator.of(context).pop();
                },
            btnOkColor:
                (isError ?? false) ? Colors.red : AppColors.selectedIconBlue)
        .show();
  }
}
