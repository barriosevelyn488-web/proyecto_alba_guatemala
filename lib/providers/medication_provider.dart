import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/medication_model.dart';
import 'package:proyecto_alba_guatemala/services/firestore_service.dart';
import 'package:proyecto_alba_guatemala/services/notification_service.dart';

class MedicationProvider with ChangeNotifier {
  List<MedicationModel> _medications = [];
  final Map<String, bool> _takenStatus = {}; // medicationId -> isTaken
  final FirestoreService _firestoreService = FirestoreService();
  final NotificationService _notificationService = NotificationService();
  final Set<int> _scheduledNotificationIds = {};
  bool _isLoading = false;
  bool _notificationsInitialized = false;

  List<MedicationModel> get medications => _medications;
  Map<String, bool> get takenStatus => _takenStatus;
  bool get isLoading => _isLoading;

  Future<void> fetchMedications(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (!_notificationsInitialized) {
        await _notificationService.initialize();
        _notificationsInitialized = true;
      }

      final snapshot = await _firestoreService.getCollection('medications');
      final filteredDocs = snapshot.docs.where((doc) {
        final data = doc.data();
        if (data.containsKey('patientId')) {
          return data['patientId'] == userId;
        }
        if (data.containsKey('userId')) {
          return data['userId'] == userId;
        }
        if (data.containsKey('ownerId')) {
          return data['ownerId'] == userId;
        }
        return true;
      }).toList();

      _medications = filteredDocs.map((doc) {
        final data = doc.data();
        return MedicationModel.fromMap({
          'id': doc.id,
          'name': data['name'] as String? ?? 'Medicamento',
          'dosage': data['dosage'] as String? ?? '',
          'frequency': data['frequency'] as String? ?? '',
          'stock': data['stock'] as int? ?? 0,
          'instructions': data['instructions'] as String? ?? '',
          'hour': data['hour'] as int? ?? data['timeHour'] as int? ?? 8,
          'minute': data['minute'] as int? ?? data['timeMinute'] as int? ?? 0,
        });
      }).toList();

      await _scheduleMedicationNotifications();
    } catch (e, st) {
      debugPrint('Error fetching medications: $e\n$st');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _scheduleMedicationNotifications() async {
    for (final medication in _medications) {
      final notificationId = _notificationIdFromMedicationId(medication.id);

      await _notificationService.scheduleDailyNotification(
        id: notificationId,
        title: 'Recordatorio de ${medication.name}',
        body: 'Es hora de tomar ${medication.dosage}.',
        hour: medication.time.hour,
        minute: medication.time.minute,
      );

      _scheduledNotificationIds.add(notificationId);
    }
  }

  int _notificationIdFromMedicationId(String medicationId) {
    return medicationId.codeUnits
        .fold(0, (prev, code) => (prev * 31 + code) & 0x7fffffff);
  }

  void markAsTaken(String medicationId, bool taken) {
    _takenStatus[medicationId] = taken;
    notifyListeners();
    debugPrint(
        'Medication $medicationId marked as ${taken ? 'taken' : 'not taken'}');
  }
}
