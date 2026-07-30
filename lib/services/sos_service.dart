import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Servicio para manejar la acción de emergencia (SOS).
class SosService {
  // TODO(equipo): reemplazar por el número real del cuidador vinculado
  // una vez que patient_linking_service esté conectado a Firestore.
  static const String numeroCuidadorVinculado = '12345678';

  /// Acción que se ejecuta al presionar el botón "¡EMERGENCIA!":
  /// 1. Simula el envío de una alerta urgente (log + aviso visible en pantalla).
  /// 2. Activa el marcador telefónico hacia el cuidador vinculado.
  Future<void> activarAlertaEmergencia(BuildContext context) async {
    // 1. Simular el envío de la alerta urgente
    debugPrint(
        'SosService: Alerta de emergencia enviada al cuidador vinculado.');

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Alerta enviada. Abriendo llamada al cuidador...'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    // 2. Activar el marcador telefónico hacia el cuidador vinculado
    await _llamarCuidador(numeroCuidadorVinculado);
  }

  /// Abre la app de teléfono con el número del cuidador ya marcado.
  Future<void> _llamarCuidador(String numeroTelefono) async {
    final Uri uriLlamada = Uri(scheme: 'tel', path: numeroTelefono);
    try {
      if (await canLaunchUrl(uriLlamada)) {
        await launchUrl(uriLlamada);
      } else {
        debugPrint(
            'SosService: No se pudo abrir el marcador para $numeroTelefono');
      }
    } catch (e) {
      debugPrint('SosService: Error al intentar llamar -> $e');
    }
  }
}