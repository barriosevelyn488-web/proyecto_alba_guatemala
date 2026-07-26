class SosAlertModel {
  final String id;
  final String userId;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final bool wasCancelled;

  SosAlertModel({
    required this.id,
    required this.userId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    this.wasCancelled = false,
  });

  factory SosAlertModel.fromMap(Map<String, dynamic> map) {
    return SosAlertModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      timestamp: (map['timestamp']).toDate(),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      wasCancelled: map['wasCancelled'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'timestamp': timestamp,
      'latitude': latitude,
      'longitude': longitude,
      'wasCancelled': wasCancelled,
    };
  }
}
