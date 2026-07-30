import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  UserRole? _activeRole;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  UserRole? get activeRole => _activeRole;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<void> login(String email, String password, UserRole role) async {
    _isLoading = true;
    notifyListeners();

    // Simula una llamada a la API de autenticación (local, en memoria)
    await Future.delayed(const Duration(milliseconds: 700));
    _currentUser = UserModel(
      id: 'user-${role.name}',
      name: _displayNameForRole(role),
      email: email,
      role: role,
    );
    _activeRole = _currentUser!.role;
    _isLoading = false;
    notifyListeners();
  }

  /// Login rápido por rol (sin email/contraseña) — usado para pruebas locales
  Future<void> loginAsRole(UserRole role) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = UserModel(
      id: 'user-${role.name}',
      name: _displayNameForRole(role),
      email: '${role.name}@local',
      role: role,
    );
    _activeRole = _currentUser!.role;

    _isLoading = false;
    notifyListeners();
  }

  void setActiveRole(UserRole role) {
    if (_currentUser != null) {
      _activeRole = role;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _activeRole = null;
    notifyListeners();
  }

  String _displayNameForRole(UserRole role) {
    switch (role) {
      case UserRole.doctor:
        return 'Dr. de Prueba';
      case UserRole.caregiver:
        return 'Cuidador/a de Prueba';
      case UserRole.senior:
      default:
        return 'Usuario Senior';
    }
  }
}
