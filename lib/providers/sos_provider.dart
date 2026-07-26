import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/constants/app_constants.dart';

class SosProvider with ChangeNotifier {
  Timer? _timer;
  int _countdown = AppConstants.sosCountdownSeconds;
  bool _isSosActive = false;

  int get countdown => _countdown;
  bool get isSosActive => _isSosActive;

  void startSosCountdown(VoidCallback onCountdownFinish) {
    if (_isSosActive) return;

    _isSosActive = true;
    _countdown = AppConstants.sosCountdownSeconds;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
      } else {
        timer.cancel();
        _isSosActive = false;
        onCountdownFinish(); // Ejecuta la acción final (llamar, etc.)
      }
      notifyListeners();
    });
  }

  void cancelSos() {
    _timer?.cancel();
    _isSosActive = false;
    _countdown = AppConstants.sosCountdownSeconds;
    print('SOS cancelled by user.');
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
