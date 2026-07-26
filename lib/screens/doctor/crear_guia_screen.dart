import 'package:flutter/material.dart';

class CrearGuiaScreen extends StatelessWidget {
  const CrearGuiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Guía de Salud'),
      ),
      body: const Center(
        child: Text('Formulario para crear guías de alimentación/ejercicios'),
      ),
    );
  }
}
