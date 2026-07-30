import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_alba_guatemala/providers/auth_provider.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Doctor'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Dashboard del Doctor (placeholder)'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/role_selection');
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
