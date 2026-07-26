import 'package:flutter/material.dart';

class GenerarQrScreen extends StatelessWidget {
  const GenerarQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Paciente'),
      ),
      body: const Center(
        child: Text('Aquí se mostrará el código QR y el PIN de vinculación'),
      ),
    );
  }
}
