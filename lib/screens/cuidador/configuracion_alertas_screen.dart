
import 'package:flutter/material.dart';

class ConfiguracionAlertasScreen extends StatelessWidget {
  const ConfiguracionAlertasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Alertas'),
      ),
      body: const Center(
        child: Text('Opciones para configurar las alertas del cuidador'),
      ),
    );
  }
}
