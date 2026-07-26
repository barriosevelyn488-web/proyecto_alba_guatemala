# 🚀 Guía de Inicio Rápido por Desarrollador — Proyecto ALBA

Este documento proporciona una guía paso a paso personalizada para cada uno de los 12 desarrolladores del equipo. El objetivo es que cada integrante sepa exactamente por dónde empezar, cuáles son sus responsabilidades y cómo colaborar eficazmente.

## ⚙️ Guía de Configuración y Ejecución Local (Para todos los desarrolladores)

Sigue estos pasos en orden. **Cada desarrollador debe completar esta guía** para poder trabajar en el proyecto.

### Paso 1: Verificar Herramientas (Requisitos Previos)

Abre tu terminal y ejecuta estos comandos para asegurarte de que tienes las versiones correctas. Si alguno falla o la versión es inferior, instala o actualiza la herramienta correspondiente.

```bash
# Verifica Flutter y Dart
flutter --version

# Verifica Git
git --version

# Verifica Firebase CLI (si falla, instálalo en el siguiente paso)
firebase --version
```

### Paso 2: Clonar el Repositorio y Obtener Dependencias

1.  **Clona el proyecto** desde el repositorio central de la organización.
    ```bash
    git clone https://github.com/tu-organizacion/alba_health_app.git
    ```

2.  **Navega a la carpeta** del proyecto.
    ```bash
    cd alba_health_app
    ```

3.  **Instala todas las dependencias** de Flutter definidas en `pubspec.yaml`.
    ```bash
    flutter pub get
    ```

### Paso 3: Conectar tu Entorno Local con Firebase

Este paso es crucial para que la app pueda comunicarse con la base de datos y la autenticación.

1.  **Instala Firebase CLI** globalmente a través de npm (Node.js).
    ```bash
    npm install -g firebase-tools
    ```

2.  **Inicia sesión en Firebase** con tu cuenta de Google. Se abrirá una ventana en tu navegador.
    ```bash
    firebase login
    ```

3.  **Configura el proyecto de Flutter** para que se conecte con el proyecto de Firebase de ALBA. Este comando leerá la configuración del proyecto central y generará tu archivo local `lib/firebase_options.dart`.
    ```bash
    flutterfire configure
    ```
    *El sistema te pedirá que selecciones el proyecto de Firebase `alba-health-app` de una lista.*

### Paso 4: Ejecutar la Aplicación

1.  Asegúrate de tener un **emulador abierto** o un **dispositivo físico conectado**.

2.  **Ejecuta la aplicación** en modo de depuración. Flutter detectará automáticamente el dispositivo disponible.
    ```bash
    flutter run
    ```
    ¡Listo! Ahora deberías ver la aplicación ALBA corriendo en tu dispositivo/emulador.

### Paso 5: Flujo de Trabajo Diario (Git)

1.  **Antes de empezar a programar**, asegúrate de tener la última versión de la rama `develop` y crea tu propia rama de funcionalidad.
    ```bash
    git checkout develop
    git pull origin develop
    git checkout -b feature/grupo-X-[tu-funcionalidad]
    ```
    *Reemplaza `X` con tu número de grupo y `[tu-funcionalidad]` con una descripción breve (ej: `feature/grupo-1-auth-logic`).*

2.  **Al finalizar tu trabajo**, y antes de crear una Pull Request, asegúrate de que tu código cumple con los estándares de calidad.
    ```bash
    # Revisa que no haya errores de análisis estático
    flutter analyze

    # Ejecuta todas las pruebas unitarias y de widgets
    flutter test
    ```
    Si ambos comandos pasan sin errores, estás listo para hacer `commit`, `push` y crear tu Pull Request hacia la rama `develop`.

---

## 🟢 GRUPO 1: PERFIL ADULTO MAYOR (SENIOR)

### **Dev 1: Group Lead 1 & Auth Core**

*   **Tu Misión:** Eres el responsable de toda la lógica de autenticación y la gestión de la sesión del usuario. Como líder de grupo, también coordinas las tareas del Grupo 1.
*   **Archivos Exclusivos:**
    *   `lib/providers/auth_provider.dart`
    *   `lib/models/user_model.dart`
    *   `lib/screens/auth/login_screen.dart`
    *   `lib/screens/auth/role_selection_screen.dart`
*   **Primeros Pasos:**
    1.  **Implementar `AuthProvider`:** Abre `lib/providers/auth_provider.dart` y reemplaza la simulación (`Future.delayed`) con una llamada real a `FirebaseAuth.instance.signInWithEmailAndPassword`.
    2.  **Conectar UI:** Modifica `lib/screens/auth/login_screen.dart` para que el botón "Ingresar" llame al método `login` de tu `AuthProvider`.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(auth): implementar login con firebase auth"
        ```

### **Dev 2: Hardware, Sensors & SOS Lead**

*   **Tu Misión:** Implementar toda la interacción con el hardware del dispositivo, incluyendo la detección de caídas en segundo plano y el sistema de emergencia SOS.
*   **Archivos Exclusivos:**
    *   `lib/services/fall_detection_service.dart`
    *   `lib/services/sos_service.dart`
    *   `lib/providers/sos_provider.dart`
    *   `lib/screens/senior/sos_activo_screen.dart`
*   **Primeros Pasos:**
    1.  **Refinar Detección de Caídas:** Investiga y mejora el algoritmo en `onStart` dentro de `lib/services/fall_detection_service.dart` para que sea más preciso que el placeholder actual.
    2.  **Conectar SOS:** Asegúrate de que el `SosService` utiliza `PhoneLauncherUtil` para realizar las llamadas y enviar los SMS.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(sensors): mejorar algoritmo de deteccion de caidas"
        ```

### **Dev 3: Senior UI Accessibility & Theme**

*   **Tu Misión:** Garantizar que la interfaz del perfil Senior sea ultra accesible (WCAG AAA), con alto contraste, tipografía grande y elementos táctiles fáciles de usar.
*   **Archivos Exclusivos:**
    *   `lib/constants/app_colors.dart`
    *   `lib/constants/app_typography.dart`
    *   `lib/widgets/custom_button.dart`
    *   `lib/widgets/emergency_sos_banner.dart`
    *   `lib/screens/senior/inicio_senior_screen.dart`
*   **Primeros Pasos:**
    1.  **Construir `inicio_senior_screen`:** Maqueta la pantalla principal del adulto mayor, utilizando los componentes de widgets que te pertenecen.
    2.  **Validar Accesibilidad:** Utiliza el `Flutter Inspector` y las herramientas de accesibilidad para asegurar que todos los elementos tengan el tamaño y contraste correctos.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(ui-senior): maquetar dashboard principal con widgets accesibles"
        ```

### **Dev 4: Senior Views Flow**

*   **Tu Misión:** Construir el resto de las pantallas del flujo del adulto mayor, conectándolas con los `providers` correspondientes.
*   **Archivos Exclusivos:**
    *   `lib/screens/senior/agenda_medicamentos_screen.dart`
    *   `lib/screens/senior/ficha_medica_senior_screen.dart`
    *   `lib/screens/senior/guias_salud_screen.dart`
    *   `lib/screens/senior/red_ayuda_screen.dart`
*   **Primeros Pasos:**
    1.  **Implementar `agenda_medicamentos_screen`:** Conéctala con `MedicationProvider` (propiedad de Dev 6) para mostrar una lista de `MedicationCard`. Coordina con Dev 6 si necesitas algún ajuste en el provider.
    2.  **Construir `red_ayuda_screen`:** Crea una lista de contactos de emergencia que, al ser presionados, utilicen `PhoneLauncherUtil` para llamar.
    3.  **Ejemplo de Commit:**
    
        ```bash
        git commit -m "feat(senior): implementar UI de agenda de medicamentos"
        ```

---

## 🔵 GRUPO 2: PERFIL CUIDADOR / CAREGIVER

### **Dev 5: Group Lead 2 & Firestore Offline**

*   **Tu Misión:** Definir la estructura de la base de datos, implementar los modelos principales y asegurar que la persistencia offline funcione correctamente.
*   **Archivos Exclusivos:**
    *   `lib/services/firestore_service.dart`
    *   `lib/models/medication_model.dart`
    *   `lib/models/health_record_model.dart`
    *   `lib/screens/caregiver/dashboard_cuidador_screen.dart`
*   **Primeros Pasos:**
    1.  **Validar Modelos:** Revisa `medication_model.dart` y `health_record_model.dart` para asegurar que coincidan con la estructura que se guardará en Firestore.
    2.  **Implementar Dashboard:** Comienza a maquetar el `dashboard_cuidador_screen.dart`, que mostrará el "semáforo" de adherencia.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(firestore): validar modelos de datos y maquetar dashboard"
        ```

### **Dev 6: Notifications & Alarms Lead**

*   **Tu Misión:** Gestionar todo lo relacionado con las notificaciones locales para los recordatorios de medicamentos y el estado del botiquín.
*   **Archivos Exclusivos:**
    *   `lib/services/notification_service.dart`
    *   `lib/providers/medication_provider.dart`
    *   `lib/widgets/medication_card.dart`
    *   `lib/screens/caregiver/inventario_botiquin_screen.dart`
*   **Primeros Pasos:**
    1.  **Implementar `MedicationProvider`:** Reemplaza los datos de prueba en `fetchMedications` con una llamada real a `FirestoreService` para obtener los medicamentos del paciente.
    2.  **Conectar Notificaciones:** Haz que el `MedicationProvider` utilice el `NotificationService` para programar una alarma por cada medicamento.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(medication): conectar provider con firestore y programar alarmas"
        ```

### **Dev 7: Linking QR & Generation**

*   **Tu Misión:** Desarrollar el sistema de vinculación entre pacientes y profesionales mediante códigos QR y PIN.
*   **Archivos Exclusivos:**
    *   `lib/services/patient_linking_service.dart`
    *   `lib/screens/caregiver/generar_qr_screen.dart`
    *   `lib/screens/caregiver/configuracion_alertas_screen.dart`
*   **Primeros Pasos:**
    1.  **Implementar `PatientLinkingService`:** Desarrolla la lógica para generar un documento temporal en Firestore con un PIN y una fecha de expiración.
    2.  **Generar QR:** En `generar_qr_screen.dart`, utiliza el paquete `qr_flutter` para mostrar el código QR generado por el servicio.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(linking): implementar logica de generacion de codigo QR"
        ```

### **Dev 8: Caregiver UI & Recetas**

*   **Tu Misión:** Construir las interfaces de navegación del cuidador y la pantalla para gestionar recetas.
*   **Archivos Exclusivos:**
    *   `lib/screens/caregiver/recetas_historial_screen.dart`
    *   `lib/widgets/bottom_nav_bar.dart`
    *   `lib/widgets/top_role_header.dart`
*   **Primeros Pasos:**
    1.  **Implementar `BottomNavBar`:** Asegúrate de que la barra de navegación se adapte correctamente según el rol del usuario.
    2.  **Maquetar `recetas_historial_screen`:** Diseña la interfaz que mostrará una lista de recetas y un botón para "digitalizar" una nueva (simulando la apertura de la cámara).
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(ui-caregiver): construir UI para historial de recetas"
        ```

---

## 🔴 GRUPO 3: PERFIL DOCTOR

### **Dev 9: Group Lead 3 & Doctor Data**

*   **Tu Misión:** Estructurar los datos y el estado para el perfil del Doctor, incluyendo su agenda y guías médicas.
*   **Archivos Exclusivos:**
    *   `lib/providers/doctor_provider.dart`
    *   `lib/models/appointment_model.dart`
    *   `lib/models/guide_model.dart`
    *   `lib/screens/doctor/dashboard_doctor_screen.dart`
*   **Primeros Pasos:**
    1.  **Implementar `DoctorProvider`:** Conecta el provider con `FirestoreService` para obtener la lista de pacientes y citas del doctor.
    2.  **Construir Dashboard:** En `dashboard_doctor_screen.dart`, muestra la lista de pacientes recientes obtenida del provider.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(doctor): implementar carga de pacientes en dashboard"
        ```

### **Dev 10: QR Scanner & Linking**

*   **Tu Misión:** Implementar la parte del doctor en el flujo de vinculación: el escaneo del QR del paciente.
*   **Archivos Exclusivos:**
    *   `lib/screens/doctor/escanear_qr_screen.dart`
    *   `lib/screens/doctor/agenda_doctor_screen.dart`
*   **Primeros Pasos:**
    1.  **Integrar `mobile_scanner`:** En `escanear_qr_screen.dart`, implementa el widget de cámara para leer el código QR.
    2.  **Validar Vinculación:** Una vez escaneado, muestra un diálogo para que el doctor ingrese el PIN y llama al método `validateAndLink` de `PatientLinkingService` (propiedad de Dev 7).
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(doctor): implementar escaner QR para vinculacion"
        ```

### **Dev 11: Expediente & Charts**

*   **Tu Misión:** Desarrollar la visualización del expediente clínico del paciente, incluyendo gráficos de adherencia y alertas de alergias.
*   **Archivos Exclusivos:**
    *   `lib/providers/health_provider.dart`
    *   `lib/widgets/adherence_chart_widget.dart`
    *   `lib/widgets/alert_badge_widget.dart`
    *   `lib/screens/doctor/expediente_paciente_screen.dart`
*   **Primeros Pasos:**
    1.  **Implementar `HealthProvider`:** Conecta el provider con `FirestoreService` para cargar los datos del `HealthRecordModel` del paciente.
    2.  **Integrar Gráfico:** En `adherence_chart_widget.dart`, usa el paquete `fl_chart` para visualizar los datos de adherencia.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(charts): implementar grafico de adherencia con datos del provider"
        ```

### **Dev 12: Prescription & Guides Flow**

*   **Tu Misión:** Construir el flujo completo para que un doctor pueda crear y asignar recetas y guías de salud a un paciente.
*   **Archivos Exclusivos:**
    *   `lib/screens/doctor/emitir_receta_screen.dart`
    *   `lib/screens/doctor/crear_guia_screen.dart`
    *   `lib/screens/doctor/vista_previa_guia_screen.dart`
    *   `lib/utils/date_formatter.dart`
*   **Primeros Pasos:**
    1.  **Construir Formulario de Receta:** En `emitir_receta_screen.dart`, crea un formulario para que el doctor prescriba un medicamento. Al guardar, debe crear un nuevo documento en Firestore.
    2.  **Implementar Formulario de Guía:** Haz lo mismo para `crear_guia_screen.dart`, permitiendo crear guías de nutrición o ejercicio.
    3.  **Ejemplo de Commit:**
        ```bash
        git commit -m "feat(doctor): implementar formulario para emision de recetas"
        ```