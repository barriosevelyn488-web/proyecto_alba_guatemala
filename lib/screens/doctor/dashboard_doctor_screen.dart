import 'package:flutter/material.dart';

class DashboardDoctorScreen extends StatelessWidget {
  const DashboardDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard del Doctor'),
      ),
      body: const Center(
        child: Text('Vista principal y listado de pacientes recientes'),
      ),
    );
  }
}
