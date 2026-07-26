import 'package:flutter/material.dart';

class MedicationModel {
  final String id;
  final String name;
  final String dosage; // E.g., "500 mg"
  final String frequency; // E.g., "Cada 8 horas"
  final int stock; // Unidades restantes
  final String instructions; // E.g., "Tomar con comida"
  final TimeOfDay time;

  MedicationModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.stock,
    required this.instructions,
    required this.time,
  });

  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    return MedicationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      dosage: map['dosage'] as String,
      frequency: map['frequency'] as String,
      stock: map['stock'] as int,
      instructions: map['instructions'] as String,
      time: TimeOfDay(hour: map['hour'], minute: map['minute']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'stock': stock,
      'instructions': instructions,
      'hour': time.hour,
      'minute': time.minute,
    };
  }
}
