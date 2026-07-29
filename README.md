# 🏥 ALBA — Aplicación de Salud y Adherencia Farma-Geriátrica

![Flutter Version](https://img.shields.io/badge/Flutter-3.22.0-02569B?style=for-the-badge&logo=flutter)
![Dart Version](https://img.shields.io/badge/Dart-3.4.0-0175C2?style=for-the-badge&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

**ALBA** es una plataforma móvil ecosistémica diseñada para resolver el problema de la falta de adherencia al tratamiento médico y la vulnerabilidad ante emergencias geriátricas. Integra en tiempo real a tres actores clave dentro de un circuito unificado de datos:

*   **Adulto Mayor (Perfil Senior):** Interfaz ultra-accesible (WCAG 2.1 AAA) centrada en la toma autónoma de medicamentos, recordatorios gigantes de voz/pantalla, ficha clínica simplificada y alertas SOS por caídas o pánico.
*   **Cuidador/a (Perfil Caregiver):** Panel de supervisión remota, monitoreo de adherencia mediante semáforo visual, control de stock del botiquín, digitalización de recetas y recepción instantánea de alertas con coordenadas GPS.
*   **Doctor Tratante (Perfil Doctor):** Expediente clínico digital, visualización gráfica del cumplimiento de tratamientos (últimos 6 meses), prescripción directa de fármacos/guías y vinculación rápida mediante escáner de código QR y PIN.

---

## 📋 Tabla de Contenidos

1.  [Visión General y Arquitectura de Datos](#-visión-general-y-arquitectura-de-datos)
2.  [Estructura del Proyecto](#-estructura-del-proyecto-y-árbol-completo)
3.  [Distribución del Equipo](#-distribución-del-equipo-12-devs--3-grupos)
4.  [Flujo de Trabajo en Git](#-flujo-de-trabajo-en-git-modelo-clon-y-normas)
5.  [Requisitos Previos](#️-requisitos-previos-e-instalación-de-herramientas)
6.  [Configuración de Servicios](#️-configuración-de-servicios-firebase-sensores-y-notificaciones)
7.  [Guía de Ejecución Local](#-guía-de-ejecución-local-y-depuración)
8.  [Matriz de Entregables](#-matriz-de-entregables-por-hito-y-grupo)
9.  [Resolución de Problemas](#-resolución-de-problemas-frecuentes-troubleshooting)

---

## 📐 Visión General y Arquitectura de Datos

ALBA opera bajo un modelo de triangulación de información interactiva:

```text
 ┌────────────────┐       Emisión de Receta       ┌────────────────┐
 │                │ ────────────────────────────> │                │
 │  PERFIL DOCTOR │                               │ PERFIL CUIDADOR│
 │  (Prescripción)│ <──────────────────────────── │ (Gestión Stock)│
 └────────────────┘        Lectura QR / PIN       └────────────────┘
         │                                                │
         │ Asignación Guías                      Notificación / Refresco
         ▼                                                ▼
 ┌─────────────────────────────────────────────────────────────────┐
 │                      PERFIL ADULTO MAYOR                        │
 │         (Confirmación de Tomas + Botón SOS / Caídas)            │
 └─────────────────────────────────────────────────────────────────┘
```

### Principios Fundamentales de la Arquitectura

*   **Resiliencia Offline First:** `FirebaseFirestore` está configurado con `persistenceEnabled: true` para almacenar en caché local todas las lecturas y escrituras. Si el adulto mayor pierde conectividad, la aplicación sigue operando y sincroniza los cambios al recuperar la red.
*   **Servicio en Segundo Plano (Foreground Service):** La detección de caídas se ejecuta a través de `flutter_background_service`, manteniendo activa la escucha del acelerómetro sin importar si la pantalla está bloqueada o la app está minimizada.
*   **Inyección de Dependencias Optimizada:** Los `ChangeNotifierProvider` globales en `main.dart` utilizan carga diferida (comportamiento por defecto) para no consumir recursos de manera preventiva en dispositivos de gama baja.

---

## 🌳 Estructura del Proyecto y Árbol Completo

El proyecto sigue una arquitectura por capas basada en responsabilidad única:

```text

🌳 4. Estructura Detallada de Código Fuente (lib/)
lib/
├── main.dart                               # Configuración de Providers, Firestore Persistence y Rutas
│
├── constants/                              # Constantes del sistema
│   ├── app_colors.dart                     # Paleta WCAG AAA (#059669, #2563EB, #0F172A, #DC2626)
│   ├── app_typography.dart                 # Tipografía Senior (22px-36px) y Clínica
│   └── app_constants.dart                  # Claves API, parámetros de tiempo y PINs por defecto
│
├── models/                                 # Objetos de Datos (Data Models)
│   ├── user_model.dart                     # Perfiles: Senior, Cuidador, Doctor
│   ├── medication_model.dart               # Dosis, frecuencia, stock e indicaciones
│   ├── health_record_model.dart            # Ficha médica (Alergias, O+, diagnósticos, citas)
│   ├── guide_model.dart                    # Guías asignadas por el médico
│   ├── appointment_model.dart              # Citas médica en la agenda del doctor
│   └── sos_alert_model.dart                # Registro de emergencias con coordenadas GPS
│
├── services/                               # Servicios aislados por responsabilidad
│   ├── firestore_service.dart              # Operaciones Firebase + Settings(persistenceEnabled: true)
│   ├── notification_service.dart           # Programación local de alarmas para medicinas
│   ├── sos_service.dart                    # Llamadas telefónicas directas y SMS GPS
│   ├── fall_detection_service.dart         # Acelerómetro + Foreground Service (Background)
│   └── patient_linking_service.dart        # Lógica de emparejamiento QR y PIN
│
├── providers/                              # Estados globales con ChangeNotifier
│   ├── auth_provider.dart                  # Sesión activa y rol
│   ├── medication_provider.dart            # Registro de tomas y estado del botiquín
│   ├── health_provider.dart                # Expediente del paciente y alergias
│   ├── doctor_provider.dart                # Pacientes recientes, agenda y recetas emitidas
│   └── sos_provider.dart                   # Temporizador y gestión de emergencias
│
├── widgets/                                # Componentes Reutilizables Accesibles
│   ├── custom_button.dart                  # Botones táctiles accesibles (min 64px para Senior)
│   ├── emergency_sos_banner.dart           # Botón rojo flotante ("¡PEDIR AYUDA / SOS!")
│   ├── medication_card.dart                # Tarjeta de medicamento con estado de toma
│   ├── adherence_chart_widget.dart         # Gráfico de cumplimiento (fl_chart)
│   ├── alert_badge_widget.dart             # Banner de alerta crítica ("ALERGIA: Penicilina")
│   ├── top_role_header.dart                # Selector superior de perfil de prueba
│   └── bottom_nav_bar.dart                 # Barra de navegación adaptativa por perfil
│
├── screens/                                # Pantallas divididas por Perfil
│   ├── auth/                               # Autenticación y Selección
│   │   ├── role_selection_screen.dart
│   │   └── login_screen.dart
│   │
│   ├── senior/                             # PERFIL ADULTO MAYOR
│   │   ├── inicio_senior_screen.dart       # Dashboard diario
│   │   ├── agenda_medicamentos_screen.dart # Alarma "YA ME LA TOMÉ"
│   │   ├── ficha_medica_senior_screen.dart # Ficha simplificada de salud
│   │   ├── guias_salud_screen.dart         # Guías asignadas por el doctor
│   │   ├── red_ayuda_screen.dart           # Contactos con botón "LLAMAR AHORA"
│   │   └── sos_activo_screen.dart          # Conteo regresivo y cancelación
│   │
│   ├── caregiver/                          # PERFIL CUIDADOR/A
│   │   ├── dashboard_cuidador_screen.dart  # Monitor en tiempo real y semáforo
│   │   ├── inventario_botiquin_screen.dart # Control de stock de fármacos
│   │   ├── recetas_historial_screen.dart   # Historial y digitalización de recetas
│   │   ├── generar_qr_screen.dart          # Código QR y PIN de vinculación
│   │   └── configuracion_alertas_screen.dart
│   │
│   └── doctor/                             # PERFIL DOCTOR
│       ├── dashboard_doctor_screen.dart    # Vista principal y pacientes recientes
│       ├── escanear_qr_screen.dart         # Escáner QR y PIN
│       ├── agenda_doctor_screen.dart       # Citas programadas
│       ├── expediente_paciente_screen.dart # Historial clínico, gráfico y alertas
│       ├── emitir_receta_screen.dart       # Prescripción digital de fármacos
│       ├── crear_guia_screen.dart          # Creación de guías médicas
│       └── vista_previa_guia_screen.dart   # Vista previa accesible
│
└── utils/                                  # Utilidades estáticas
    ├── date_formatter.dart                 # Formato de fechas amigables
    └── phone_launcher_util.dart            # Lanzador de llamadas y SMS



## 👥 Distribución del Equipo (12 Devs / 3 Grupos)

El equipo se subdivide en 3 Grupos de 4 Integrantes, donde cada grupo asume la responsabilidad total de una interfaz.

#### 🟢 GRUPO 1: PERFIL ADULTO MAYOR - SENIOR (4 DEVS)
*   **Dev 1 (Lead Group 1 + Auth Core):** Firebase Auth, `user_model`, `login_screen` & `role_selection_screen`.
*   **Dev 2 (Hardware & SOS Lead):** `FallDetectionService` (Background), `SOS Service` & `sos_activo_screen`.
*   **Dev 3 (Senior UI Accessibility):** Estilos WCAG AAA, `custom_button`, `emergency_sos_banner` & `inicio_senior_screen`.
*   **Dev 4 (Senior Flow Dev):** `agenda_medicamentos_screen`, `ficha_medica_senior_screen`, `guias_salud_screen` & `red_ayuda_screen`.

#### 🔵 GRUPO 2: PERFIL CUIDADOR / CAREGIVER (4 DEVS)
*   **Dev 5 (Lead Group 2 + Firestore Persistence):** Firestore Offline Settings, `medication_model`, `health_record_model` & `dashboard_cuidador_screen`.
*   **Dev 6 (Notifications & Alarms Lead):** `NotificationService` (Alarmas locales) & `inventario_botiquin_screen`.
*   **Dev 7 (Linking QR & Generation):** `patient_linking_service`, `qr_flutter`, `generar_qr_screen` & `configuracion_alertas_screen`.
*   **Dev 8 (Caregiver UI & Recetas):** `recetas_historial_screen`, `bottom_nav_bar` & `top_role_header`.

#### 🔴 GRUPO 3: PERFIL DOCTOR (4 DEVS)
*   **Dev 9 (Lead Group 3 + Doctor Data):** `DoctorProvider`, `appointment_model`, `guide_model` & `dashboard_doctor_screen`.
*   **Dev 10 (QR Scanner & Linking):** `mobile_scanner`, `escanear_qr_screen` & `agenda_doctor_screen`.
*   **Dev 11 (Expediente & Charts):** `fl_chart`, `adherence_chart_widget` & `expediente_paciente_screen`.
*   **Dev 12 (Prescription & Guides Flow):** `emitir_receta_screen`, `crear_guia_screen`, `vista_previa_guia_screen` & Provider Lazy Loading.

---

## 🌿 Flujo de Trabajo en Git (Modelo Clon) y Normas

### 1. Estructura de Ramas Principales
*   `main`: Código estable de producción. Solo se actualiza mediante PR aprobada al finalizar cada hito.
*   `develop`: Rama principal de integración diaria. Todos los subgrupos unen sus avances aquí.
*   `feature/grupo-[1|2|3]-[funcionalidad]`: Ramas individuales de desarrollo (Ej: `feature/grupo-1-fall-detection`).

### 2. Convención de Commits (Conventional Commits)
Todo commit debe seguir el formato `tipo(módulo): descripción`.
```
feat(senior): agregar boton gigante de confirmacion de toma
fix(caregiver): corregir calculo del semaforo de adherencia
docs(readme): actualizar instrucciones de instalacion local
refactor(services): optimizar escucha del acelerometro en segundo plano
```
**Tipos válidos:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.

### 3. Flujo Paso a Paso para Desarrolladores
1.  **Clonar el Repositorio Central** (Única vez):
    ```bash
    git clone https://github.com/tu-organizacion/alba_health_app.git
    cd alba_health_app
    ```
2.  **Crear tu Rama Funcional** desde `develop`:
    ```bash
    git checkout develop
    git pull origin develop
    git checkout -b feature/grupo-1-boton-sos
    ```
3.  **Sincronizar Cambios** de `develop` antes de enviar tu trabajo:
    ```bash
    git checkout develop
    git pull origin develop
    git checkout feature/grupo-1-boton-sos
    git merge develop
    ```
4.  **Publicar Rama y Crear Pull Request (PR)**:
    ```bash
    git push origin feature/grupo-1-boton-sos
    ```
    Luego, abre la Pull Request en GitHub desde tu rama hacia `develop`.

### 4. Reglas de Validación de PR e Integración
*   **Verificación Local Obligatoria:** Linter y pruebas deben pasar sin errores.
    ```bash
    flutter analyze
    flutter test
    ```
*   **Aprobación de un Lead:** Todo PR requiere al menos 1 aprobación de un Lead de Grupo.
*   **Protección de Ramas:** Se prohíbe estrictamente `git push --force` o hacer pushes directos sobre `main` o `develop`.

---

## 🛠️ Requisitos Previos e Instalación de Herramientas

| Herramienta             | Versión Mínima Requerida      | Comando de Verificación         |
| ----------------------- | ----------------------------- | ------------------------------- |
| **Flutter SDK**         | `>=3.22.0`                    | `flutter --version`             |
| **Dart SDK**            | `>=3.4.0`                     | `dart --version`                |
| **Git**                 | `>=2.30.0`                    | `git --version`                 |
| **Android Studio**      | Android API 34                | `Abrir Android Studio SDK Manager` |
| **Xcode** (Solo macOS)  | `15.0+` / CocoaPods `1.15+`   | `pod --version`                 |
| **Node.js & Firebase CLI** | Node `18+` / Firebase CLI `13+` | `firebase --version`            |

---

## ⚙️ Configuración de Servicios (Firebase, Sensores y Notificaciones)

### A. Configuración de Firebase
1.  Instala y activa las herramientas CLI:
    ```bash
    npm install -g firebase-tools
    firebase login
    dart pub global activate flutterfire_cli
    ```
2.  Vincula el proyecto en la raíz del repositorio:
    ```bash
    flutterfire configure --project=alba-health-app
    ```
    Esto generará automáticamente el archivo `lib/firebase_options.dart`.

3.  Configura las **reglas de seguridad** en Cloud Firestore:
    ```
    rules_version = '2';
    service cloud.firestore {
      match /databases/{database}/documents {
        match /{document=**} {
          allow read, write: if request.auth != null;
        }
      }
    }
    ```

### B. Configuración de Permisos Nativos de Hardware

#### 🤖 Android (`android/app/src/main/AndroidManifest.xml`)
Verifica que los permisos estén declarados antes de la etiqueta `<application>`:
```xml
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_HEALTH" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.HIGH_SAMPLING_RATE_SENSORS" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

#### 🍎 iOS (`ios/Runner/Info.plist`)
Asegúrate de tener las siguientes claves dentro del bloque `<dict>`:
```xml
<key>NSCameraUsageDescription</key>
<string>ALBA requiere acceso a la cámara para escanear los códigos QR de vinculación médica.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>ALBA necesita tu ubicación para enviarla a tus contactos de emergencia en caso de presionar el botón SOS.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>ALBA requiere la ubicación en segundo plano para enviar las coordenadas precisas ante una detección de caída.</string>
<key>NSMotionUsageDescription</key>
<string>ALBA utiliza los sensores de movimiento para la detección de caídas accidentales en adultos mayores.</string>
```

---

## 🚀 Guía de Ejecución Local y Depuración

1.  **Clonar** el repositorio:
    ```bash
    git clone https://github.com/tu-organizacion/alba_health_app.git
    cd alba_health_app
    ```
2.  Crear archivo de **entorno local**:
    ```bash
    cp .env.example .env
    ```
3.  Instalar **dependencias**:
    ```bash
    flutter pub get
    ```
4.  Instalar **Pods** para iOS (Solo macOS):
    ```bash
    cd ios && pod install && cd ..
    ```
5.  Verificar el **entorno**:
    ```bash
    flutter doctor
    ```
6.  **Ejecutar** la aplicación:
    ```bash
    flutter run
    ```

---

## 📊 Matriz de Entregables por Hito y Grupo

### Hito 1: Fundamentos, UI Base y Modelos (Semanas 1-2)
*   **Grupo 1 (Senior):** `role_selection_screen.dart`, `login_screen.dart`, componentes de accesibilidad (`custom_button.dart`).
*   **Grupo 2 (Caregiver):** Configuración de `firestore_service.dart` con persistencia, `medication_model.dart`, `health_record_model.dart`.
*   **Grupo 3 (Doctor):** Configuración de `doctor_provider.dart`, `appointment_model.dart`, `guide_model.dart` y maquetación de `dashboard_doctor_screen.dart`.

### Hito 2: Funcionalidades Core e Integración Hardware (Semanas 3-4)
*   **Grupo 1 (Senior):** `inicio_senior_screen.dart`, `agenda_medicamentos_screen.dart`, `FallDetectionService` y `sos_activo_screen.dart`.
*   **Grupo 2 (Caregiver):** `dashboard_cuidador_screen.dart` (Semáforo), `inventario_botiquin_screen.dart`, `NotificationService` y `generar_qr_screen.dart`.
*   **Grupo 3 (Doctor):** `escanear_qr_screen.dart` con `mobile_scanner`, `expediente_paciente_screen.dart` con `fl_chart`, `emitir_receta_screen.dart`.

### Hito 3: Pruebas Cruzadas, Pulido y Cierre (Semanas 5-6)
*   **Todos los Grupos:** Pruebas de integración del circuito cerrado completo.
*   **Entregable Final:** Aplicación empaquetada (`.apk` / `.ipa`), suite de pruebas al 100% y documentación validada.

---

## ❓ Resolución de Problemas Frecuentes (Troubleshooting)

### 1. Error de `minSdkVersion` en Android
*   **Síntoma:** `Manifest merger failed: apps attribute minSdk (21) is lower than library...`
*   **Solución:** Abre `android/app/build.gradle` y asegúrate de que `minSdkVersion` sea 21 o superior.
    ```groovy
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
    ```

### 2. Pérdida del servicio en segundo plano al bloquear la pantalla en Android
*   **Síntoma:** El acelerómetro deja de escuchar cuando el teléfono entra en *deep sleep*.
*   **Solución:** Verifica que `FOREGROUND_SERVICE` y `FOREGROUND_SERVICE_HEALTH` estén en `AndroidManifest.xml` y desactiva la optimización de batería para ALBA en los ajustes del teléfono.

### 3. Falla al compilar CocoaPods en iOS
*   **Síntoma:** `Podfile.lock is out of date` o errores de símbolos no encontrados.
*   **Solución:** Ejecuta una limpieza completa desde la carpeta `ios`.
    ```bash
    cd ios
    rm -rf Pods Podfile.lock
    pod cache clean --all
    pod install --repo-update
    cd ..
    flutter clean
    flutter pub get
    ```

---

**ALBA Health Tech © 2026 — Todos los derechos reservados.**