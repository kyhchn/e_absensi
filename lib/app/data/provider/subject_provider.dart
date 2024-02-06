import 'package:e_absensi/app/core/constant.dart';
import 'package:e_absensi/app/data/models/subject.dart';

class SubjectProvider {
  Future<List<Subject>> getSubjects() async {
    final subjects = await firestore.collection('subjects').get();
    return subjects.docs
        .map((e) => Subject.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }
}
