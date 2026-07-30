import 'dart:async';
import 'dart:math';

/// Servicio para manejar la vinculación entre pacientes,
/// cuidadores y doctores.
class PatientLinkingService {
  static const String _prefijo = "ALBA";

  /// Genera un QR y un PIN para vincular un paciente.
  Future<Map<String, dynamic>> generateLinkingCode(
    String patientId,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final pin = _generatePin();

    return {
      "patientId": patientId,
      "qrData": "alba://link/$patientId/$pin",
      "pin": pin,
      "createdAt": DateTime.now(),
      "expiresAt": DateTime.now().add(
        const Duration(minutes: 10),
      ),
    };
  }

  /// Valida un código manual.
  Future<bool> validateAccessCode(
    String accessCode,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return accessCode.startsWith("$_prefijo-");
  }

  /// Simula la vinculación.
  Future<bool> validateAndLink({
    required String qrData,
    required String pin,
    required String professionalId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (pin.startsWith("$_prefijo-")) {
      print("Paciente vinculado con éxito");
      print("Profesional: $professionalId");
      print("QR: $qrData");

      return true;
    }

    print("Código inválido");

    return false;
  }

  /// Genera un PIN tipo ALBA-5678
  String _generatePin() {
    final random = Random();

    final numero = 1000 + random.nextInt(9000);

    return "$_prefijo-$numero";
  }
}
),