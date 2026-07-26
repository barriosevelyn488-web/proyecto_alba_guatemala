import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:sensors_plus/sensors_plus.dart';

// Esta función debe estar fuera de una clase para que el servicio en segundo plano pueda encontrarla.
@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Lógica de detección de caídas
  accelerometerEvents.listen((AccelerometerEvent event) {
    // La lógica de detección de caídas real es compleja.
    // Implica analizar el vector de fuerza (magnitud) y detectar un patrón de
    // caída libre seguido de un impacto fuerte y un período de inactividad.
    // Este es un placeholder muy simplificado.
    double magnitude = (event.x * event.x + event.y * event.y + event.z * event.z) / (9.8 * 9.8);

    if (magnitude > 3.0) { // Umbral de ejemplo para un impacto fuerte
      print('FALL DETECTED (background): High G-force event!');
      // Aquí se podría invocar un método para notificar al usuario o a los contactos.
      // service.invoke('fallDetected', {'timestamp': DateTime.now().toIso8601String()});
    }
  });
}

/// Inicializa y configura el servicio en segundo plano para la detección de caídas.
Future<void> initializeFallDetectionService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: false, // No iniciar automáticamente al arrancar el teléfono
      notificationChannelId: 'fall_detection_channel',
      initialNotificationTitle: 'Protección ALBA Activada',
      initialNotificationContent: 'Monitoreando posibles caídas.',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      autoStart: false, // No iniciar automáticamente
    ),
  );
}

/// Clase de fachada para controlar el servicio de detección de caídas desde la UI.
class FallDetectionService {
  final FlutterBackgroundService _service = FlutterBackgroundService();

  Future<void> startService() async {
    bool isRunning = await _service.isRunning();
    if (!isRunning) {
      _service.startService();
    }
  }

  Future<void> stopService() async {
    bool isRunning = await _service.isRunning();
    if (isRunning) {
      _service.invoke('stopService');
    }
  }
}
