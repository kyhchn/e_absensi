class EabsensiUser {
  final String id;
  final String name;
  final String nim;
  final String email;
  String pin;
  List<String> subjects;

  EabsensiUser({
    required this.id,
    required this.name,
    required this.nim,
    required this.email,
    required this.pin,
    required this.subjects,
  });

  factory EabsensiUser.fromJson(Map<String, dynamic> json) {
    return EabsensiUser(
        id: json['id'],
        name: json['name'],
        nim: json['nim'],
        email: json['email'],
        pin: json['pin'],
        subjects: List<String>.from(json['subjects']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nim': nim,
      'email': email,
      'pin': pin,
      'subjects': subjects,
    };
  }
}
