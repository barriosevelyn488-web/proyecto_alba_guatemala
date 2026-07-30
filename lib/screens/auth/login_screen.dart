import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_alba_guatemala/models/user_model.dart';
import 'package:proyecto_alba_guatemala/providers/auth_provider.dart';
import 'package:proyecto_alba_guatemala/widgets/custom_botton.dart';

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


    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión como ${widget.role.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    (value == null || !value.contains('@'))
                        ? 'Email inválido'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) =>
                    (value == null || value.length < 6)
                        ? 'La contraseña debe tener al menos 6 caracteres'
                        : null,
              ),
              const SizedBox(height: 24),
              Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  return auth.isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Ingresar',
                          onPressed: _login,
                        );
                },
              ),
              const SizedBox(height: 20),
              const Text('Accesos rápidos', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Entrar como Doctor',
                onPressed: () => _loginAs(UserRole.doctor),
                backgroundColor: Colors.blueAccent,
                height: 48,
              ),
              const SizedBox(height: 8),
              CustomButton(
                text: 'Entrar como Cuidador/a',
                onPressed: () => _loginAs(UserRole.caregiver),
                backgroundColor: Colors.orangeAccent,
                height: 48,
              ),
              const SizedBox(height: 8),
              CustomButton(
                text: 'Entrar como Abuelito',
                onPressed: () => _loginAs(UserRole.senior),
                backgroundColor: Colors.green,
                height: 48,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
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
