# 👥 Distribución Detallada del Equipo (12 Desarrolladores) — Proyecto ALBA

Para garantizar la colaboración fluida en paralelo y prevenir conflictos en Git, el proyecto se divide en **3 Grupos de 4 Integrantes**. Cada integrante tiene asignada la responsabilidad exclusiva de archivos y componentes específicos.

---

## 🟢 GRUPO 1: PERFIL ADULTO MAYOR (SENIOR) — 4 DEVS

**Líder de Grupo:** Dev 1

| Dev | Rol / Responsabilidad | Archivos a Cargo (Exclusivos) |
|---|---|---|
| **Dev 1** | **Group Lead 1 & Auth Core** | • `lib/providers/auth_provider.dart`<br>• `lib/models/user_model.dart`<br>• `lib/screens/auth/login_screen.dart`<br>• `lib/screens/auth/role_selection_screen.dart` |
| **Dev 2** | **Hardware, Sensors & SOS Lead** | • `lib/services/fall_detection_service.dart`<br>• `lib/services/sos_service.dart`<br>• `lib/providers/sos_provider.dart`<br>• `lib/screens/senior/sos_activo_screen.dart` |
| **Dev 3** | **Senior UI Accessibility & Theme** | • `lib/constants/app_colors.dart`<br>• `lib/constants/app_typography.dart`<br>• `lib/widgets/custom_button.dart`<br>• `lib/widgets/emergency_sos_banner.dart`<br>• `lib/screens/senior/inicio_senior_screen.dart` |
| **Dev 4** | **Senior Views Flow** | • `lib/screens/senior/agenda_medicamentos_screen.dart`<br>• `lib/screens/senior/ficha_medica_senior_screen.dart`<br>• `lib/screens/senior/guias_salud_screen.dart`<br>• `lib/screens/senior/red_ayuda_screen.dart` |

---

## 🔵 GRUPO 2: PERFIL CUIDADOR / CAREGIVER — 4 DEVS

**Líder de Grupo:** Dev 5

| Dev | Rol / Responsabilidad | Archivos a Cargo (Exclusivos) |
|---|---|---|
| **Dev 5** | **Group Lead 2 & Firestore Offline** | • `lib/services/firestore_service.dart`<br>• `lib/models/medication_model.dart`<br>• `lib/models/health_record_model.dart`<br>• `lib/screens/caregiver/dashboard_cuidador_screen.dart` |
| **Dev 6** | **Notifications & Alarms Lead** | • `lib/services/notification_service.dart`<br>• `lib/providers/medication_provider.dart`<br>• `lib/widgets/medication_card.dart`<br>• `lib/screens/caregiver/inventario_botiquin_screen.dart` |
| **Dev 7** | **Linking QR & Generation** | • `lib/services/patient_linking_service.dart`<br>• `lib/screens/caregiver/generar_qr_screen.dart`<br>• `lib/screens/caregiver/configuracion_alertas_screen.dart` |
| **Dev 8** | **Caregiver UI & Recetas** | • `lib/screens/caregiver/recetas_historial_screen.dart`<br>• `lib/widgets/bottom_nav_bar.dart`<br>• `lib/widgets/top_role_header.dart` |

---

## 🔴 GRUPO 3: PERFIL DOCTOR — 4 DEVS

**Líder de Grupo:** Dev 9

| Dev | Rol / Responsabilidad | Archivos a Cargo (Exclusivos) |
|---|---|---|
| **Dev 9** | **Group Lead 3 & Doctor Data** | • `lib/providers/doctor_provider.dart`<br>• `lib/models/appointment_model.dart`<br>• `lib/models/guide_model.dart`<br>• `lib/screens/doctor/dashboard_doctor_screen.dart` |
| **Dev 10** | **QR Scanner & Linking** | • `lib/screens/doctor/escanear_qr_screen.dart`<br>• `lib/screens/doctor/agenda_doctor_screen.dart` |
| **Dev 11** | **Expediente & Charts** | • `lib/providers/health_provider.dart`<br>• `lib/widgets/adherence_chart_widget.dart`<br>• `lib/widgets/alert_badge_widget.dart`<br>• `lib/screens/doctor/expediente_paciente_screen.dart` |
| **Dev 12** | **Prescription & Guides Flow** | • `lib/screens/doctor/emitir_receta_screen.dart`<br>• `lib/screens/doctor/crear_guia_screen.dart`<br>• `lib/screens/doctor/vista_previa_guia_screen.dart`<br>• `lib/utils/date_formatter.dart` |

---

## 📌 Reglas Generales de Colaboración

1. **Edición Restringida:** Un desarrollador **solo** puede modificar los archivos asignados en su tabla. Si requiere cambios en un archivo asignado a otro integrante (por ejemplo, agregar una propiedad a un Modelo), debe coordinarlo con el responsable del archivo.
2. **Archivos Compartidos Globales:**
   * `lib/main.dart` y `lib/constants/app_constants.dart`: Modificados únicamente con aprobación de los Leads de Grupo (Dev 1, Dev 5 o Dev 9).
3. **Flujo de Trabajo:** Toda funcionalidad se desarrolla en una rama `feature/grupo-[1|2|3]-[nombre]` y requiere PR hacia `develop`.