import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/health_record_model.dart';

class HealthProvider with ChangeNotifier {
  HealthRecordModel? _healthRecord;
  bool _isLoading = false;

  HealthRecordModel? get healthRecord => _healthRecord;
  bool get isLoading => _isLoading;

  Future<void> fetchHealthRecord(String patientId) async {
    _isLoading = true;
    notifyListeners();

    // Simula la carga del expediente desde un servicio
    await Future.delayed(const Duration(seconds: 1));
    _healthRecord = HealthRecordModel(
      patientId: patientId,
      allergies: ['Penicilina', 'Mariscos'],
      bloodType: 'O+',
      diagnoses: ['Hipertensión Arterial', 'Diabetes Tipo 2'],
      pastAppointments: ['Consulta General - 15/06/2026'],
    );
    _isLoading = false;
    notifyListeners();
  }
}
