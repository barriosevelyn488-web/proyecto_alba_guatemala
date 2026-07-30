import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';
import 'package:proyecto_alba_guatemala/services/sos_service.dart';

/// Pantalla de alerta crítica de emergencia para el Adulto Mayor.
/// Fondo rojo llamativo con un botón central gigante que activa la alerta.
class SosActivoScreen extends StatelessWidget {
  const SosActivoScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.criticalRed,
      body: SafeArea(

                  ),
                  child: const Text(
                    '¡EMERGENCIA!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              if (!_alertaEnviada)
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Volver', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
