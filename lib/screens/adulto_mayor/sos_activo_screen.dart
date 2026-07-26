import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';
import 'package:proyecto_alba_guatemala/providers/sos_provider.dart';
import 'package:proyecto_alba_guatemala/services/sos_service.dart';

class SosActivoScreen extends StatefulWidget {
  const SosActivoScreen({super.key});

  @override
  State<SosActivoScreen> createState() => _SosActivoScreenState();
}

class _SosActivoScreenState extends State<SosActivoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sosProvider = Provider.of<SosProvider>(context, listen: false);
      sosProvider.startSosCountdown(() {
        _triggerSosActions();
      });
    });
  }

  void _triggerSosActions() {
    if (!mounted) return;
    print("¡ACCIÓN SOS! Enviando alertas...");
    final sosService = SosService();
    // Reemplazar con números de emergencia reales de la configuración del usuario
    sosService.makePhoneCall('123');
    sosService.sendSmsWithLocation('123', '¡ALERTA DE EMERGENCIA!');

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _cancel() {
    Provider.of<SosProvider>(context, listen: false).cancelSos();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.criticalRed,
      body: SafeArea(
        child: Consumer<SosProvider>(
          builder: (context, sosProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 120),
                const SizedBox(height: 20),
                const Text(
                  'ALERTA DE EMERGENCIA ACTIVADA',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Enviando alerta en...',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  '${sosProvider.countdown}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 96, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ElevatedButton(
                    onPressed: _cancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.criticalRed,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text('CANCELAR', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
