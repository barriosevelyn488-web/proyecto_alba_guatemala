import 'package:flutter/material.dart';

class EmitirRecetaScreen extends StatelessWidget {
  const EmitirRecetaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emitir Nueva Receta'),
      ),
      body: const Center(
        child: Text('Formulario para prescripción digital'),
      ),
    );
  }
}
