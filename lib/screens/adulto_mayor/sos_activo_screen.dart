import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';
import 'package:proyecto_alba_guatemala/services/sos_service.dart';

class SosActivoScreen extends StatefulWidget {
  const SosActivoScreen({super.key});

  @override
  State<SosActivoScreen> createState() => _SosActivoScreenState();
}

class _SosActivoScreenState extends State<SosActivoScreen> {
  bool _alertaEnviada = false;

  void _triggerSosActions() async {
    setState(() {
      _alertaEnviada = true;
    });

    final sosService = SosService();
    await sosService.makePhoneCall('123');
    await sosService.sendSmsWithLocation('123', '¡ALERTA DE EMERGENCIA!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.criticalRed,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 120),
              const SizedBox(height: 20),
              Text(
                _alertaEnviada
                    ? 'ALERTA ENVIADA AL CUIDADOR'
                    : 'TOCA EL BOTÓN SI NECESITAS AYUDA',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 60),
              SizedBox(
                height: 220,
                child: ElevatedButton(
                  onPressed: _alertaEnviada ? null : _triggerSosActions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.criticalRed,
                    shape: const CircleBorder(),
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
            ],
          ),
        ),
      ),
    );
  }
} 