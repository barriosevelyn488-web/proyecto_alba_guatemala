import 'package:flutter/material.dart';

/// Clase abstracta para la paleta de colores de la aplicación ALBA.
/// Los colores están seleccionados para cumplir con WCAG AAA.
abstract class AppColors {
  /// Color primario para elementos principales y acciones positivas.
  static const Color primaryGreen = Color(0xFF059669);

  /// Color secundario para enlaces, botones informativos y estados activos.
  static const Color secondaryBlue = Color(0xFF2563EB);

  /// Color de texto principal para máxima legibilidad.
  static const Color primaryText = Color(0xFF0F172A);

  /// Color para alertas críticas, errores y botones de emergencia (SOS).
  static const Color criticalRed = Color(0xFFDC2626);

  /// Color de fondo claro para la mayoría de las pantallas.
  static const Color background = Color(0xFFF8FAFC);

  /// Color para bordes, divisores y elementos sutiles.
  static const Color border = Color(0xFFE2E8F0);
}
