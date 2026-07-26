# 🏗️ Arquitectura Técnica y Modelo de Datos — Proyecto ALBA

Este documento detalla la estructura técnica, patrones de diseño, flujos de datos y servicios de hardware implementados en la aplicación **ALBA**.

---

## 1. 📐 Patrón de Arquitectura

El proyecto utiliza una **Arquitectura en Capas orientada a Servicios (Layered Architecture)** con el patrón **Provider (ChangeNotifier)** para la gestión de estado global y reactivo:

```text
┌──────────────────────────────────────────────────────────┐
│                   CAPA DE VISTAS (UI)                    │
│      screens/ (Senior, Caregiver, Doctor) & widgets/     │
└────────────────────────────┬─────────────────────────────┘
                             │ Consume / Notifica
                             ▼
┌──────────────────────────────────────────────────────────┐
│              CAPA DE ESTADO (PROVIDERS)                  │
│   AuthProvider, MedicationProvider, DoctorProvider, etc. │
└────────────────────────────┬─────────────────────────────┘
                             │ Delega lógica
                             ▼
┌──────────────────────────────────────────────────────────┐
│             CAPA DE SERVICIOS (SERVICES)                 │
│  FirestoreService, NotificationService, FallDetection... │
└────────────────────────────┬─────────────────────────────┘
                             │ Persistencia / Hardware
                             ▼
┌──────────────────────────────────────────────────────────┐
│           BACKEND & RECURSOS DEL DISPOSITIVO             │
│    Firebase Firestore, Sensors (Acelerómetro), GPS, SMS  │
└──────────────────────────────────────────────────────────┘