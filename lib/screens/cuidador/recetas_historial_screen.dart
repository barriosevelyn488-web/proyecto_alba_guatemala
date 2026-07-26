import 'package:flutter/material.dart';

class RecetasHistorialScreen extends StatelessWidget {
  const RecetasHistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Recetas'),
      ),
      body: const Center(
        child: Text('Historial y opción para digitalizar recetas físicas'),
      ),
    );
  }
}
