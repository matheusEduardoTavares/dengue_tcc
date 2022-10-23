import 'package:dengue_tcc/app/utils/awesome_dialogs_control/awesome_dialogs_control.dart';
import 'package:dengue_tcc/app/utils/remote_config_utils/remote_config_keys.dart';
import 'package:dengue_tcc/app/utils/remote_config_utils/remote_config_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappUtils {
  WhatsappUtils._();

  static Future<void> openWhatsAppWithNumber({
    required BuildContext context,
    String? text = 'Olá, suporte aplicativo dengue de Barra Bonita / SP!',
  }) async {
    try {
      final number =
          RemoteConfigUtils.getStringValue(key: RemoteConfigKeys.phone)!;
      final uri = Uri.parse('whatsapp://send?phone=$number&text=${text ?? ''}');
      await launchUrl(uri);
    } catch (_) {
      AwesomeDialogsControl.showAwesomeDialogs(
        message: 'Erro ao abrir o WhatsApp',
        context: context,
        isError: true,
        btnOkOnPress: () {},
      );
    }
  }
}
