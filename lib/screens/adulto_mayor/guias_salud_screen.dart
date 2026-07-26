import 'package:flutter/material.dart';

class GuiasSaludScreen extends StatelessWidget {
  const GuiasSaludScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Guías de Salud'),
      ),
      body: const Center(
        child: Text('Listado de consejos y guías asignadas por el doctor'),
      ),
    );
  }
}
