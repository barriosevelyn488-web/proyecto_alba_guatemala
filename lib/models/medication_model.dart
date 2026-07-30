import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicationModel {
  final String id;
  final String name;
  final String dosage;
  final String schedule;
  final String frequency;
  final int stock;
  final bool isCritical;
  final bool isActive;
  final String instructions;
  final TimeOfDay time;

  const MedicationModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.schedule,
    required this.frequency,
    required this.stock,
    required this.isCritical,
    required this.isActive,
    required this.instructions,
    required this.time,
  });

  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    final int hour = map['hour'] is int ? map['hour'] as int : 0;
    final int minute = map['minute'] is int ? map['minute'] as int : 0;

    return MedicationModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      dosage: map['dosage'] as String? ?? '',
      schedule: map['schedule'] as String? ?? '',
      frequency: map['frequency'] as String? ?? '',
      stock: map['stock'] as int? ?? 0,
      isCritical: map['isCritical'] as bool? ?? false,
      isActive: map['isActive'] as bool? ?? true,
      instructions: map['instructions'] as String? ?? '',
      time: TimeOfDay(hour: hour, minute: minute),
    );
  }

  factory MedicationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final map = snapshot.data() ?? <String, dynamic>{};
    final int hour = map['hour'] is int ? map['hour'] as int : 0;
    final int minute = map['minute'] is int ? map['minute'] as int : 0;

    return MedicationModel(
      id: snapshot.id,
      name: map['name'] as String? ?? '',
      dosage: map['dosage'] as String? ?? '',
      schedule: map['schedule'] as String? ?? '',
      frequency: map['frequency'] as String? ?? '',
      stock: map['stock'] as int? ?? 0,
      isCritical: map['isCritical'] as bool? ?? false,
      isActive: map['isActive'] as bool? ?? true,
      instructions: map['instructions'] as String? ?? '',
      time: TimeOfDay(hour: hour, minute: minute),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'schedule': schedule,
      'frequency': frequency,
      'stock': stock,
      'isCritical': isCritical,
      'isActive': isActive,
      'instructions': instructions,
      'hour': time.hour,
      'minute': time.minute,
    };
  }

  MedicationModel copyWith({
    String? id,
    String? name,
    String? dosage,
    String? schedule,
    String? frequency,
    int? stock,
    bool? isCritical,
    bool? isActive,
    String? instructions,
    TimeOfDay? time,
  }) {
    return MedicationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      schedule: schedule ?? this.schedule,
      frequency: frequency ?? this.frequency,
      stock: stock ?? this.stock,
      isCritical: isCritical ?? this.isCritical,
      isActive: isActive ?? this.isActive,
      instructions: instructions ?? this.instructions,
      time: time ?? this.time,
    );
  }
}