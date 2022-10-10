import 'package:dengue_tcc/app/utils/awesome_dialogs_control/awesome_dialogs_control.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewControl {
  WebviewControl._();

  static Future<void> openWebviewLink({
    required String linkToOpen,
    required BuildContext context,
  }) async {
    final canOpenURL = await launchUrl(Uri.parse(linkToOpen));

    if (!canOpenURL) {
      AwesomeDialogsControl.showAwesomeDialogs(
        message: 'Erro ao abrir o link $linkToOpen',
        context: context,
        isError: true,
        btnOkOnPress: () {},
      );
    }
  }
}
