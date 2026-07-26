import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

/// Servicio para manejar acciones de emergencia (SOS).
/// Responsable de llamadas y envío de SMS con coordenadas GPS.
class SosService {
  /// Realiza una llamada telefónica directa a un número de emergencia.
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'No se pudo llamar a $phoneNumber';
    }
  }

  /// Envía un SMS con un mensaje y la ubicación GPS actual.
  Future<void> sendSmsWithLocation(String phoneNumber, String message) async {
    try {
      Position position = await _determinePosition();
      final String fullMessage =
          '$message. Mi ubicación: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
      final Uri launchUri = Uri(
          scheme: 'sms',
          path: phoneNumber,
          queryParameters: {'body': fullMessage});

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'No se pudo enviar SMS a $phoneNumber';
      }
    } catch (e) {
      print('Error al enviar SMS con ubicación: $e');
      // Considerar enviar el SMS sin ubicación como fallback
    }
  }

  /// Obtiene la posición GPS actual del dispositivo.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están deshabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicación fueron denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Los permisos de ubicación están permanentemente denegados.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
