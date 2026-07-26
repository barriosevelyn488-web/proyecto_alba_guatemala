import 'package:flutter/material.dart';

class VistaPreviaGuiaScreen extends StatelessWidget {
  const VistaPreviaGuiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Previa de la Guía'),
      ),
      body: const Center(
        child: Text('Previsualización accesible de la guía creada'),
      ),
    );
  }
}
