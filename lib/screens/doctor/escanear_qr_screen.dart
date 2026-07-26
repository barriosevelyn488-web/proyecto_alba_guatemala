import 'package:flutter/material.dart';

class EscanearQrScreen extends StatelessWidget {
  const EscanearQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR de Paciente'),
      ),
      body: const Center(
        child: Text('Interfaz de cámara para escanear QR y campo para PIN'),
      ),
    );
  }
}
