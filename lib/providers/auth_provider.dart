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

    // Simula una llamada a la API de autenticación
    await Future.delayed(const Duration(seconds: 2));
    _currentUser = UserModel(
      id: 'user-123',
      name: 'Usuario de Prueba',
      email: email,
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
}
