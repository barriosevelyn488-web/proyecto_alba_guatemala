class HealthRecordModel {
  final String patientId;
  final List<String> allergies;
  final String bloodType; // E.g., "O+"
  final List<String> diagnoses;
  final List<String> pastAppointments; // IDs o resúmenes

  HealthRecordModel({
    required this.patientId,
    required this.allergies,
    required this.bloodType,
    required this.diagnoses,
    required this.pastAppointments,
  });

  factory HealthRecordModel.fromMap(Map<String, dynamic> map) {
    return HealthRecordModel(
      patientId: map['patientId'] as String,
      allergies: List<String>.from(map['allergies']),
      bloodType: map['bloodType'] as String,
      diagnoses: List<String>.from(map['diagnoses']),
      pastAppointments: List<String>.from(map['pastAppointments']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'allergies': allergies,
      'bloodType': bloodType,
      'diagnoses': diagnoses,
      'pastAppointments': pastAppointments,
    };
  }
}
