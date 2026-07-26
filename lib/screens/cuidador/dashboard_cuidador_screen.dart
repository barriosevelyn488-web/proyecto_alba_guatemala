import 'package:flutter/material.dart';

class DashboardCuidadorScreen extends StatelessWidget {
  const DashboardCuidadorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor de Cuidador'),
      ),
      body: const Center(
        child: Text('Monitor en tiempo real y semáforo de estado del paciente'),
      ),
    );
  }
}
