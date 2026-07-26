import 'package:flutter/material.dart';

class AgendaMedicamentosScreen extends StatelessWidget {
  const AgendaMedicamentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Agenda de Medicamentos'),
      ),
      body: const Center(
        child: Text('Aquí se mostrarán las alarmas y botones "YA ME LA TOMÉ"'),
      ),
    );
  }
}
