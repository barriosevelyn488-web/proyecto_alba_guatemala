import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';

/// Clase abstracta para la escala tipográfica de la aplicación ALBA.
/// Diseñada para alta legibilidad y una interfaz clínica clara.
abstract class AppTypography {
  /// Estilo para títulos grandes y encabezados de pantalla.
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: -0.5,
  );

  /// Estilo para subtítulos y secciones importantes.
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  );

  /// Estilo para el cuerpo de texto principal, claro y legible.
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
    height: 1.5, // Altura de línea para facilitar la lectura
  );

  /// Estilo para texto secundario, etiquetas e información de apoyo.
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
  );

  /// Estilo para botones y otros elementos interactivos.
  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Estilo para alertas y textos que requieren atención especial.
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );
}
