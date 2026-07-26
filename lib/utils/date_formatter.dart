import 'package:intl/intl.dart';

/// Clase de utilidad con métodos estáticos para formatear fechas.
class DateFormatter {
  /// Formatea un DateTime a un formato amigable como "15 de julio, 2026".
  /// Asegúrate de inicializar los locales en tu main.dart si necesitas otros idiomas.
  static String toFriendlyDate(DateTime date) {
    // 'es' para español.
    final format = DateFormat('dd \'de\' MMMM, yyyy', 'es');
    return format.format(date);
  }

  /// Formatea un DateTime a un formato de hora como "08:30 AM".
  static String toFriendlyTime(DateTime time) {
    final format = DateFormat('hh:mm a');
    return format.format(time);
  }
}
