import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/medication_model.dart';

class MedicationProvider with ChangeNotifier {
  List<MedicationModel> _medications = [];
  final Map<String, bool> _takenStatus = {}; // medicationId -> isTaken
  bool _isLoading = false;

  List<MedicationModel> get medications => _medications;
  Map<String, bool> get takenStatus => _takenStatus;
  bool get isLoading => _isLoading;

  Future<void> fetchMedications(String userId) async {
    _isLoading = true;
    notifyListeners();

    // Simula la carga de medicamentos desde un servicio
    await Future.delayed(const Duration(seconds: 1));
    _medications = [
      MedicationModel(id: 'med-01', name: 'Paracetamol', dosage: '500 mg', frequency: 'Cada 8h', stock: 20, instructions: 'Con comida', time: const TimeOfDay(hour: 8, minute: 0)),
      MedicationModel(id: 'med-02', name: 'Losartán', dosage: '50 mg', frequency: 'Cada 24h', stock: 30, instructions: 'En ayunas', time: const TimeOfDay(hour: 9, minute: 0)),
    ];
    _isLoading = false;
    notifyListeners();
  }

  void markAsTaken(String medicationId, bool taken) {
    _takenStatus[medicationId] = taken;
    notifyListeners();
    // Aquí se podría llamar a un servicio para persistir el estado
    print('Medication $medicationId marked as ${taken ? "taken" : "not taken"}');
  }
}
