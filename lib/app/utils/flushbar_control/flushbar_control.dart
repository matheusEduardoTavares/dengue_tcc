import 'package:another_flushbar/flushbar.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:dengue_tcc/app/utils/app_theme/app_shadows/app_shadows.dart';
import 'package:dengue_tcc/app/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class FlushbarControl {
  FlushbarControl._();

  static Future<T?> showFlushbar<T>({
    required String message,
    required BuildContext context,
    String? title,
    bool? isError,
  }) {
    final color = (isError ?? true) ? Colors.red : Colors.blue;
    return Flushbar<T?>(
      title: title,
      padding: const EdgeInsets.all(10),
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                shadows: AppShadows.getShadows(
                  shadowColor: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: AppColors.bottomBarBlack,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      maxWidth: context.w(80),
      borderRadius: BorderRadius.circular(18.0),
    ).show(context);
  }
}
