enum GuideType { nutrition, exercise, general }

class GuideModel {
  final String id;
  final String title;
  final String content;
  final GuideType type;
  final String authorDoctorId;

  GuideModel({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.authorDoctorId,
  });

  factory GuideModel.fromMap(Map<String, dynamic> map) {
    return GuideModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      type: GuideType.values[map['type'] as int],
      authorDoctorId: map['authorDoctorId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'type': type.index,
      'authorDoctorId': authorDoctorId,
    };
  }
}
