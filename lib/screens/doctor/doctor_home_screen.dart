import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_alba_guatemala/providers/auth_provider.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Doctor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
              Navigator.pushReplacementNamed(context, '/role_selection');
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Bienvenido, Doctor'),
      ),
    );
  }
}
