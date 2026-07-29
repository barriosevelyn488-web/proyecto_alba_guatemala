# 🛠️ GUÍA DE TRABAJO PASO A PASO ACTUALIZADA Y OPTIMIZADA (MVP PROYECTO ALBA)

Esta guía detalla de forma clara y directa exactamente qué debe hacer cada desarrollador en su código, incorporando la mejora clave para las pruebas de los evaluadores: el sistema de códigos de acceso rápido y texto alternativo al escaneo.

---

## 🟢 GRUPO 1: NÚCLEO, RUTA Y PERFIL ADULTO MAYOR (SENIOR)

### **Dev 1: Core de Autenticación, Rutas y Main**
*   **Archivos exclusivos tuyos:** `lib/main.dart`, `lib/providers/auth_provider.dart`, `lib/models/user_model.dart`, `lib/screens/auth/login_screen.dart`, `lib/screens/auth/role_selection_screen.dart`.
*   **Paso a paso exacto:**
    1.  En `lib/main.dart`, configura el MultiProvider para que envuelva toda la app y define el sistema de rutas (routes) nombrando cada pantalla para que tus compañeros puedan navegar hacia ellas sin problemas.
    2.  En `login_screen.dart`, maquetar un formulario visual limpio con dos cajas de texto (correo y contraseña) y un botón principal de "Entrar".
    3.  Abajo del formulario, coloca un panel con 3 botones grandes de acceso rápido: "Entrar como Doctor", "Entrar como Cuidador" y "Entrar como Abuelito".
    4.  En `auth_provider.dart`, programa la lógica para que al pulsar cualquiera de esos 3 botones, la app guarde temporalmente el rol activo y mueva al usuario directamente al dashboard correspondiente usando `Navigator.pushReplacementNamed`. Añade también un botón simulado de "Cerrar sesión" para volver al login.

### **Dev 2: Sensores & Botón SOS de Emergencia**
*   **Archivos exclusivos tuyos:** `lib/services/fall_detection_service.dart`, `lib/services/sos_service.dart`, `lib/providers/sos_provider.dart`, `lib/screens/senior/sos_activo_screen.dart`.
*   **Paso a paso exacto:**
    1.  Entra a `sos_activo_screen.dart` y diseña una pantalla de alerta crítica. Llena el fondo con un color rojo llamativo y coloca un botón central gigante que diga "¡EMERGENCIA!".
    2.  En `sos_service.dart`, programa la acción que debe ocurrir cuando se presione ese botón: simular el envío de una alerta urgente o activar el marcador telefónico hacia el cuidador vinculado.

### **Dev 3: Interfaz Senior Accesible (WCAG 2.1 AAA) & Componentes Base**
*   **Archivos exclusivos tuyos:** `lib/constants/app_colors.dart`, `lib/constants/app_typography.dart`, `lib/widgets/custom_button.dart`, `lib/widgets/emergency_sos_banner.dart`, `lib/screens/senior/inicio_senior_screen.dart`.
*   **Paso a paso exacto:**
    1.  En las constantes, define colores de alto contraste (letras muy oscuras sobre fondos claros para que se lean perfectamente) y tamaños de letra grandes (mínimo 24px para títulos).
    2.  Construye componentes reutilizables (`custom_button.dart` y `emergency_sos_banner.dart`) con botones altos (más de 64px) para que una persona mayor no falle al tocar la pantalla.
    3.  Arma `inicio_senior_screen.dart` usando estos componentes, mostrando el saludo de bienvenida y accesos directos gigantes.

### **Dev 4: Vistas del Abuelito (Medicamentos, Guías y Red de Apoyo)**
*   **Archivos exclusivos tuyos:** `lib/screens/senior/agenda_medicamentos_screen.dart`, `lib/screens/senior/ficha_medica_senior_screen.dart`, `lib/screens/senior/guias_salud_screen.dart`, `lib/screens/senior/red_ayuda_screen.dart`.
*   **Paso a paso exacto:**
    1.  En `agenda_medicamentos_screen.dart`, arma tarjetas visuales grandes que muestren qué pastilla le toca tomar al abuelito y a qué hora. Añade un botón enorme y verde que diga textualmente "YA ME LA TOMÉ".
    2.  En `guias_salud_screen.dart` y `red_ayuda_screen.dart`, haz listas limpias donde el abuelito pueda ver las recomendaciones de su doctor y la foto o nombre de su cuidador con un botón para llamarlo de inmediato.

---

## 🔵 GRUPO 2: PERFIL CUIDADOR (CAREGIVER)

### **Dev 5: Modelos de Datos Centrales y Dashboard del Cuidador**
*   **Archivos exclusivos tuyos:** `lib/models/patient_model.dart`, `lib/models/medication_model.dart`, `lib/models/health_record_model.dart`, `lib/screens/caregiver/dashboard_cuidador_screen.dart`.
*   **Paso a paso exacto:**
    1.  Crea el modelo `patient_model.dart` para estandarizar los datos del abuelito (nombre, edad, foto, estado general) que usarán tanto los cuidadores como los doctores.
    2.  En `dashboard_cuidador_screen.dart`, maquetar el panel principal del cuidador agregando un semáforo visual (Verde si el abuelito tomó sus pastillas, Rojo si se retrasó) y un resumen de las alertas del día.

### **Dev 6: Notificaciones, Alarma y Botiquín (Inventario)**
*   **Archivos exclusivos tuyos:** `lib/services/notification_service.dart`, `lib/providers/medication_provider.dart`, `lib/widgets/medication_card.dart`, `lib/screens/caregiver/inventario_botiquin_screen.dart`.
*   **Paso a paso exacto:**
    1.  Conecta el `MedicationProvider` usando listas temporales en memoria para llevar la cuenta de cuántas pastillas quedan en la caja.
    2.  En `inventario_botiquin_screen.dart`, haz una lista visual que muestre las existencias de fármacos y pon un aviso en color naranja o rojo cuando queden pocas pastillas.

### **Dev 7: Sistema de Vinculación, QR y Código de Acceso Rápido (Actualizado)**
*   **Archivos exclusivos tuyos:** `lib/services/patient_linking_service.dart`, `lib/screens/caregiver/generar_qr_screen.dart`, `lib/screens/caregiver/configuracion_alertas_screen.dart`, `lib/screens/senior/vinculacion_abuelito_screen.dart`.
*   **Paso a paso exacto:**
    1.  En `generar_qr_screen.dart`, diseña la pantalla que dibuja el código QR principal para la vinculación con el paciente.
    2.  **Misión clave de pruebas:** Debajo del QR, coloca un código alfanumérico corto o PIN de acceso rápido (por ejemplo: ALBA-911) y un botón que diga "Copiar / Usar Código de Acceso Rápido".
    3.  Programa la lógica para que, si el doctor o el abuelito no pueden o no quieren usar la cámara para escanear durante la presentación, puedan escribir o ingresar directamente este código en sus respectivas pantallas para simular la vinculación o el inicio de sesión instantáneo sin bloqueos.
    4.  Termina la vista rápida `vinculacion_abuelito_screen.dart` para que el abuelito también cuente con un campo o botón donde introducir este código de vinculación de manera sencilla.

### **Dev 8: Navegación del Cuidador e Historial de Recetas**
*   **Archivos exclusivos tuyos:** `lib/screens/caregiver/recetas_historial_screen.dart`, `lib/widgets/bottom_nav_bar.dart`, `lib/widgets/top_role_header.dart`.
*   **Paso a paso exacto:**
    1.  Programa la barra de navegación inferior (`bottom_nav_bar.dart`) para que el cuidador pueda saltar con un toque entre su panel principal, el botiquín y el historial.
    2.  En `recetas_historial_screen.dart`, diseña la bandeja donde se enlistan todas las recetas médicas digitales que el doctor le ha recetado al abuelito.

---

## 🔴 GRUPO 3: PERFIL DOCTOR (MÉDICO) Y UTILIDADES CLÍNICAS

### **Dev 9: Agenda Médica y Estado del Doctor (Provider Clínico)**
*   **Archivos exclusivos tuyos:** `lib/providers/doctor_provider.dart`, `lib/models/appointment_model.dart`, `lib/models/guide_model.dart`, `lib/screens/doctor/dashboard_doctor_screen.dart`.
*   **Paso a paso exacto:**
    1.  Configura el `DoctorProvider` para guardar en memoria la lista de citas médicas y pacientes asignados.
    2.  En `dashboard_doctor_screen.dart`, arma la sección superior con la agenda organizada por horas y un listado de los pacientes que atenderá hoy.

### **Dev 10: Escáner QR Médico, Ingreso por Código Alternativo y Selección de Paciente**
*   **Archivos exclusivos tuyos:** `lib/screens/doctor/escanear_qr_screen.dart`, `lib/screens/doctor/agenda_doctor_screen.dart`.
*   **Paso a paso exacto:**
    1.  En `escanear_qr_screen.dart`, pon la vista de la cámara para leer códigos QR.
    2.  **Soporte de pruebas:** Añade un campo de texto y un botón que permita "Ingresar Código de Vinculación Manualmente" (conectado con el PIN que genera el Dev 7), además de un botón de emergencia que diga "Simular Escaneo Exitoso" para saltar directo al expediente si la computadora no tiene cámara.

### **Dev 11: Expediente Clínico Avanzado, Alertas y Gráficos de Adherencia**
*   **Archivos exclusivos tuyos:** `lib/providers/health_provider.dart`, `lib/widgets/adherence_chart_widget.dart`, `lib/widgets/alert_badge_widget.dart`, `lib/screens/doctor/expediente_paciente_screen.dart`.
*   **Paso a paso exacto:**
    1.  En `expediente_paciente_screen.dart`, coloca hasta arriba un Banner rojo brillante bien visible que alerte sobre alergias graves (ej. "ALERGIA A LA PENICILINA").
    2.  En `adherence_chart_widget.dart`, usa el paquete `fl_chart` para dibujar una gráfica sencilla de barras que muestre el porcentaje de cumplimiento del abuelito en la semana.

### **Dev 12: Emisión de Recetas, Creador de Guías y Utilidades de Fecha**
*   **Archivos exclusivos tuyos:** `lib/screens/doctor/emitir_receta_screen.dart`, `lib/screens/doctor/crear_guia_screen.dart`, `lib/screens/doctor/vista_previa_guia_screen.dart`, `lib/utils/date_formatter.dart`.
*   **Paso a paso exacto:**
    1.  En `emitir_receta_screen.dart`, crea un formulario con cajas de texto para escribir el nombre del medicamento, las dosis y la hora en que debe tomarse.
    2.  En `crear_guia_screen.dart`, diseña un panel con 3 pestañas (Alimentación, Ejercicios, Indicaciones) para que el doctor escriba consejos de salud y los guarde con un botón de "Enviar", haciendo que aparezcan al instante en la pantalla del abuelito.