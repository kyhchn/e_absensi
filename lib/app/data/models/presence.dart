class Presence {
  final String id;
  final String title;
  final bool isOpen;
  final String code;
  List<String> students;

  Presence(
      {required this.id,
      required this.title,
      required this.code,
      required this.isOpen,
      required this.students});

  factory Presence.fromJson(Map<String, dynamic> json) {
    return Presence(
      title: json['title'],
      isOpen: json['isOpen'],
      code: json['code'],
      id: json['id'],
      students: List<String>.from(json['students']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isOpen': isOpen,
      'students': students,
      'id': id,
      'code': code,
    };
  }
}
