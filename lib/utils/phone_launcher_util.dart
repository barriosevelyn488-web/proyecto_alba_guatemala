import 'package:url_launcher/url_launcher.dart';

/// Clase de utilidad para lanzar acciones relacionadas con el teléfono.
class PhoneLauncherUtil {
  /// Inicia una llamada telefónica al número proporcionado.
  static Future<void> makeCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('No se pudo iniciar la llamada a $phoneNumber');
    }
  }

  /// Abre la aplicación de SMS con un destinatario y mensaje predefinidos.
  static Future<void> sendSms(String phoneNumber, String body) async {
    final Uri uri = Uri.parse('sms:$phoneNumber?body=${Uri.encodeComponent(body)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('No se pudo iniciar SMS a $phoneNumber');
    }
  }
}
