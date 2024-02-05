class EabsensiUser {
  final String id;
  final String name;
  final Gender gender;
  final String nim;
  final String email;
  String pin;
  final String dateOfBirth;

  EabsensiUser({
    required this.id,
    required this.name,
    required this.nim,
    required this.email,
    required this.gender,
    required this.pin,
    required this.dateOfBirth,
  });

  factory EabsensiUser.fromJson(Map<String, dynamic> json) {
    return EabsensiUser(
        id: json['id'],
        name: json['name'],
        nim: json['nim'],
        email: json['email'],
        pin: json['pin'],
        dateOfBirth: json['dateOfBirth'],
        gender: json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nim': nim,
      'email': email,
      'pin': pin,
      'dateOfBirth': dateOfBirth,
      'gender': gender
    };
  }
}

enum Gender { male, female }
