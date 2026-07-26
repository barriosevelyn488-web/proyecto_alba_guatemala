class AppointmentModel {
  final String id;
  final String doctorId;
  final String patientId;
  final DateTime dateTime;
  final String reason;
  final String? notes;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.dateTime,
    required this.reason,
    this.notes,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] as String,
      doctorId: map['doctorId'] as String,
      patientId: map['patientId'] as String,
      dateTime: (map['dateTime']).toDate(),
      reason: map['reason'] as String,
      notes: map['notes'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'dateTime': dateTime,
      'reason': reason,
      'notes': notes,
    };
  }
}
