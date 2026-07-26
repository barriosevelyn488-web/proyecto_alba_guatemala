import 'package:flutter/material.dart';

class RedAyudaScreen extends StatelessWidget {
  const RedAyudaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Red de Ayuda'),
      ),
      body: const Center(
        child: Text('Contactos de emergencia con botón "LLAMAR AHORA"'),
      ),
    );
  }
}
