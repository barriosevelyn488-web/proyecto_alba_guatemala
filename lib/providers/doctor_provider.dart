import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/user_model.dart';
import 'package:proyecto_alba_guatemala/models/appointment_model.dart';

class DoctorProvider with ChangeNotifier {
  List<UserModel> _recentPatients = [];
  List<AppointmentModel> _todaysAppointments = [];
  bool _isLoading = false;

  List<UserModel> get recentPatients => _recentPatients;
  List<AppointmentModel> get todaysAppointments => _todaysAppointments;
  bool get isLoading => _isLoading;

  Future<void> fetchDashboardData(String doctorId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    _recentPatients = [
      UserModel(id: 'patient-01', name: 'Juan Pérez', email: 'juan@example.com', role: UserRole.senior),
      UserModel(id: 'patient-02', name: 'Ana Gómez', email: 'ana@example.com', role: UserRole.senior),
    ];
    _todaysAppointments = [
      AppointmentModel(id: 'appt-01', doctorId: doctorId, patientId: 'patient-01', dateTime: DateTime.now().add(const Duration(hours: 2)), reason: 'Control de presión'),
    ];
    _isLoading = false;
    notifyListeners();
  }

  Future<void> issuePrescription(String patientId, /* PrescriptionModel */ dynamic prescription) async {
    // Lógica para emitir y guardar una nueva receta
    print('Issuing prescription for patient $patientId');
    notifyListeners();
  }
}
