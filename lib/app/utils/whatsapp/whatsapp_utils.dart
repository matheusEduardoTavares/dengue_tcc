import 'package:url_launcher/url_launcher.dart';

class WhatsappUtils {
  WhatsappUtils._();

  static Future<void> openWhatsAppWithNumber({
    String number = '+5514981677393',
    String? text,
  }) {
    final uri = Uri.parse('whatsapp://send?phone=$number&text=${text ?? ''}');
    return launchUrl(uri);
  }
}
