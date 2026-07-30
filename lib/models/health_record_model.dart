


import 'package:cloud_firestore/cloud_firestore.dart';

class HealthRecordModel {
  final String id;
  final String patientId;
  final DateTime date;
  final String diagnosis;
  final String notes;
  final List<String> prescriptionUrls;
  final List<String> alerts;
  final Map<String, dynamic> metadata;

  const HealthRecordModel({
    required this.id,
    required this.patientId,
    required this.date,
    required this.diagnosis,
    required this.notes,
    required this.prescriptionUrls,
    required this.alerts,
    required this.metadata,
  });

  factory HealthRecordModel.fromMap(Map<String, dynamic> map) {
    final rawDate = map['date'];
    final date = rawDate is Timestamp
        ? rawDate.toDate()
        : rawDate is String
            ? DateTime.tryParse(rawDate) ?? DateTime.now()
            : DateTime.now();

    return HealthRecordModel(
      id: map['id'] as String? ?? '',
      patientId: map['patientId'] as String? ?? '',
      date: date,
      diagnosis: map['diagnosis'] as String? ?? '',
      notes: map['notes'] as String? ?? '',
      prescriptionUrls: map['prescriptionUrls'] is Iterable
          ? List<String>.from(map['prescriptionUrls'])
          : <String>[],
      alerts: map['alerts'] is Iterable
          ? List<String>.from(map['alerts'])
          : <String>[],
      metadata: map['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  factory HealthRecordModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final map = snapshot.data() ?? <String, dynamic>{};
    return HealthRecordModel.fromMap({
      'id': snapshot.id,
      ...map,
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'date': Timestamp.fromDate(date),
      'diagnosis': diagnosis,
      'notes': notes,
      'prescriptionUrls': prescriptionUrls,
      'alerts': alerts,
      'metadata': metadata,
    };
  }

  HealthRecordModel copyWith({
    String? id,
    String? patientId,
    DateTime? date,
    String? diagnosis,
    String? notes,
    List<String>? prescriptionUrls,
    List<String>? alerts,
    Map<String, dynamic>? metadata,
  }) {
    return HealthRecordModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      date: date ?? this.date,
      diagnosis: diagnosis ?? this.diagnosis,
      notes: notes ?? this.notes,
      prescriptionUrls: prescriptionUrls ?? this.prescriptionUrls,
      alerts: alerts ?? this.alerts,
      metadata: metadata ?? this.metadata,
    );
  }
}