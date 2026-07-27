import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/user_model.dart';
import 'package:proyecto_alba_guatemala/screens/auth/login_screen.dart';
import 'package:proyecto_alba_guatemala/widgets/custom_botton.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _navigateToLogin(BuildContext context, UserRole role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(role: role),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a ALBA'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '¿Cómo usarás la aplicación?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Soy Adulto Mayor',
              onPressed: () => _navigateToLogin(context, UserRole.senior),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Soy Cuidador/a',
              onPressed: () => _navigateToLogin(context, UserRole.caregiver),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Soy Doctor/a',
              onPressed: () => _navigateToLogin(context, UserRole.doctor),
            ),
          ],
        ),
      ),
    );
  }
}
