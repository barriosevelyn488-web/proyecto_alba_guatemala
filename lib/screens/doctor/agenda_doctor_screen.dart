import 'package:flutter/material.dart';
import 'escanear_qr_screen.dart';

class AgendaDoctorScreen extends StatelessWidget {
  const AgendaDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Agenda de Citas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EscanearQrScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Listado de citas programadas para el día'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EscanearQrScreen(),
            ),
          );
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
