import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/medication_model.dart';
import 'package:proyecto_alba_guatemala/services/notification_service.dart';

class MedicationProvider with ChangeNotifier {
  List<MedicationModel> _medications = [];
  final Map<String, bool> _takenStatus = {}; // medicationId -> isTaken
  bool _isLoading = false;
  final NotificationService _notificationService = NotificationService();

  List<MedicationModel> get medications => _medications;
  Map<String, bool> get takenStatus => _takenStatus;
  bool get isLoading => _isLoading;

  /// Límite por debajo del cual se considera que quedan pocas pastillas
  static const int lowStockThreshold = 5;

  Future<void> fetchMedications(String userId) async {
    _isLoading = true;
    notifyListeners();

    // Simulación de carga de datos en memoria
    await Future.delayed(const Duration(milliseconds: 500));
    _medications = [
      MedicationModel(
        id: 'med-01',
        name: 'Paracetamol',
        dosage: '500 mg',
        frequency: 'Cada 8h',
        stock: 4, // Stock bajo para prueba visual (Alert)
        instructions: 'Con comida',
        time: const TimeOfDay(hour: 8, minute: 0),
      ),
      MedicationModel(
        id: 'med-02',
        name: 'Losartán',
        dosage: '50 mg',
        frequency: 'Cada 24h',
        stock: 25,
        instructions: 'En ayunas',
        time: const TimeOfDay(hour: 9, minute: 0),
      ),
      MedicationModel(
        id: 'med-03',
        name: 'Aspirina',
        dosage: '100 mg',
        frequency: 'Cada 24h',
        stock: 2, // Stock muy bajo para prueba visual (Critico)
        instructions: 'Después del almuerzo',
        time: const TimeOfDay(hour: 13, minute: 0),
      ),
    ];

    // Programar alarmas de notificaciones iniciales
    _scheduleAllNotifications();

    _isLoading = false;
    notifyListeners();
  }

  void markAsTaken(String medicationId, bool taken) {
    _takenStatus[medicationId] = taken;

    // Si se marca como tomada, descontamos 1 unidad del stock en memoria
    final index = _medications.indexWhere((med) => med.id == medicationId);
    if (index != -1 && taken) {
      if (_medications[index].stock > 0) {
        _medications[index].stock -= 1;
      }
    } else if (index != -1 && !taken) {
      // Si se desmarca, reponemos la unidad consumida
      _medications[index].stock += 1;
    }

    notifyListeners();
  }

  /// Permite reponer o ajustar el stock manualmente desde el botiquín
  void updateStock(String medicationId, int newStock) {
    final index = _medications.indexWhere((med) => med.id == medicationId);
    if (index != -1) {
      _medications[index].stock = newStock;
      notifyListeners();
    }
  }

  void _scheduleAllNotifications() {
    for (int i = 0; i < _medications.length; i++) {
      final med = _medications[i];
      if (med.time != null) {
        _notificationService.scheduleDailyNotification(
          id: i,
          title: '¡Hora de tomar tu medicamento!',
          body: '${med.name} (${med.dosage}) - ${med.instructions}',
          hour: med.time!.hour,
          minute: med.time!.minute,
        );
      }
    }
  }
}
