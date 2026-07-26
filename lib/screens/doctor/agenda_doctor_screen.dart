import 'package:flutter/material.dart';

class AgendaDoctorScreen extends StatelessWidget {
  const AgendaDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Agenda de Citas'),
      ),
      body: const Center(
        child: Text('Listado de citas programadas para el día'),
      ),
    );
  }
}
