import 'package:flutter/material.dart';

class ExpedientePacienteScreen extends StatelessWidget {
  const ExpedientePacienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expediente del Paciente'),
      ),
      body: const Center(
        child: Text('Historial clínico completo, gráficos y alertas del paciente'),
      ),
    );
  }
}
