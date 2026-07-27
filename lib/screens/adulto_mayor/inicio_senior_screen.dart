import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/screens/adulto_mayor/sos_activo_screen.dart';
import 'package:proyecto_alba_guatemala/widgets/emergency_sos_banner.dart';

class InicioSeniorScreen extends StatelessWidget {
  const InicioSeniorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Día - Inicio'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text('Dashboard diario del Adulto Mayor'),
      ),
      bottomNavigationBar: EmergencySosBanner(
        onSosPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SosActivoScreen()),
          );
        },
      ),
    );
  }
}
