import 'package:flutter/material.dart';

class InventarioBotiquinScreen extends StatelessWidget {
  const InventarioBotiquinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario del Botiquín'),
      ),
      body: const Center(
        child: Text('Control de stock de fármacos'),
      ),
    );
  }
}
