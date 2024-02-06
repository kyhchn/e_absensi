import 'package:e_absensi/app/data/models/presence.dart';

class Subject {
  final String name;
  final String code;
  final String imageUrl;
  List<Presence>? presences;

  Subject(
      {required this.name,
      required this.code,
      required this.imageUrl,
      this.presences});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        name: json['name'], code: json['code'], imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'imageUrl': imageUrl,
    };
  }
}
