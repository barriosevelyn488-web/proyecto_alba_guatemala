/// Clase abstracta para constantes globales de la aplicación.
abstract class AppConstants {
  /// Clave de API para un hipotético servicio de mapas o geolocalización.
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY_HERE';

  /// Duración en segundos para el temporizador de cancelación de la alerta SOS.
  static const int sosCountdownSeconds = 10;

  /// PIN por defecto para la vinculación de pacientes (usar solo para desarrollo).
  static const String defaultLinkingPin = '1234';

  /// Tiempo máximo de espera para respuestas de red en milisegundos.
  static const int networkTimeoutMs = 15000;
}

