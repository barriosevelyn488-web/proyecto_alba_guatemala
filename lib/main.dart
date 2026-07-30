import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_alba_guatemala/providers/auth_provider.dart';
import 'package:proyecto_alba_guatemala/providers/doctor_provider.dart';
import 'package:proyecto_alba_guatemala/providers/health_provider.dart';
import 'package:proyecto_alba_guatemala/providers/medication_provider.dart';
import 'package:proyecto_alba_guatemala/providers/sos_provider.dart';
import 'package:proyecto_alba_guatemala/screens/auth/login_screen.dart';
import 'package:proyecto_alba_guatemala/screens/auth/role_selection_screen.dart';
import 'package:proyecto_alba_guatemala/screens/senior/inicio_senior_screen.dart';
import 'package:proyecto_alba_guatemala/screens/cuidador/dashboard_cuidador_screen.dart';
import 'package:proyecto_alba_guatemala/screens/doctor/dashboard_doctor_screen.dart';
import 'package:proyecto_alba_guatemala/services/fall_detection_service.dart';

// 1. Importa el archivo de opciones generado por FlutterFire
import 'firebase_options.dart';
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  // Inicialización de Firebase utilizando las opciones de la plataforma actual
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  // REGLA TÉCNICA 1: Habilitar la persistencia offline de Firestore
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
 
  // REGLA TÉCNICA 2: Inicializar el servicio en segundo plano
  await initializeFallDetectionService();
 
  runApp(const AlbaApp());
}
 
class AlbaApp extends StatelessWidget {
  const AlbaApp({super.key});
 
  String _homeRouteForRole(UserRole? role) {
    switch (role) {
      case UserRole.caregiver:
        return '/caregiver_dashboard';
      case UserRole.doctor:
        return '/doctor_dashboard';
      case UserRole.senior:
      default:
        return '/senior_home';
    }
  }
 
  @override
  Widget build(BuildContext context) {
    // REGLA TÉCNICA 3: Inyección de dependencias con carga diferida (comportamiento por defecto)
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MedicationProvider()),
        ChangeNotifierProvider(create: (_) => HealthProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
        ChangeNotifierProvider(create: (_) => SosProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return MaterialApp(
            title: 'ALBA App',
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: auth.isAuthenticated ? _homeRouteForRole(auth.activeRole) : '/role_selection',
            routes: {
              '/role_selection': (context) => const RoleSelectionScreen(),
              '/login': (context) {
                final args = ModalRoute.of(context)!.settings.arguments;
                final role = args is UserRole ? args : UserRole.senior;
                return LoginScreen(role: role);
              },
              '/senior_home': (context) => const InicioSeniorScreen(),
              '/caregiver_dashboard': (context) => const DashboardCuidadorScreen(),
              '/doctor_dashboard': (context) => const DashboardDoctorScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/login' || settings.name == '/role_selection') {
                return null;
              }

              if (!auth.isAuthenticated) {
                return MaterialPageRoute(
                  builder: (_) => const RoleSelectionScreen(),
                );
              }

              return null;
            },
          );
        },
      ),
    );
  }
}

