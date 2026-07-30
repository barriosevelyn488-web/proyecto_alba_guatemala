import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_alba_guatemala/models/user_model.dart';
import 'package:proyecto_alba_guatemala/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  final UserRole role;
  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.login(
        _emailController.text,
        _passwordController.text,
        widget.role,
      );

      if (mounted && authProvider.isAuthenticated) {
        // Navegar a la pantalla principal correspondiente al rol
        final homeRoute = _homeRouteForRole(widget.role);
        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
      }
    }
  }

  Future<void> _loginAs(UserRole role) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loginAsRole(role);
    if (mounted && authProvider.isAuthenticated) {
      final homeRoute = _homeRouteForRole(role);
      Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
    }
  }

  String _homeRouteForRole(UserRole role) {
    switch (role) {
      case UserRole.caregiver:
        return '/caregiver_home';
      case UserRole.doctor:
        return '/doctor_home';
      case UserRole.senior:
      default:
        return '/senior_home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión como ${widget.role.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    (value == null || !value.contains('@'))
                        ? 'Email inválido'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) =>
                    (value == null || value.length < 6)
                        ? 'La contraseña debe tener al menos 6 caracteres'
                        : null,
              ),
              const SizedBox(height: 32),
              Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  return auth.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _login,
                          child: const Text('Ingresar'),
                        );
                },
              ),
              const SizedBox(height: 24),
              // Accesos rápidos para pruebas locales
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () => _loginAs(UserRole.doctor),
                    child: const Text('Entrar como Doctor'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _loginAs(UserRole.caregiver),
                    child: const Text('Entrar como Cuidador/a'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _loginAs(UserRole.senior),
                    child: const Text('Entrar como Abuelito'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
