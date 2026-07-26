import 'package:flutter/material.dart';

class FichaMedicaSeniorScreen extends StatelessWidget {
  const FichaMedicaSeniorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Ficha Médica'),
      ),
      body: const Center(
        child: Text('Vista simplificada de la ficha de salud'),
      ),
    );
  }
}
