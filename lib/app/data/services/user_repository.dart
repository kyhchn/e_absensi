import 'package:e_absensi/app/data/models/eabsensi_user.dart';
import 'package:e_absensi/app/data/models/presence.dart';
import 'package:e_absensi/app/data/models/subject.dart';
import 'package:e_absensi/app/data/provider/presence_provider.dart';
import 'package:e_absensi/app/data/provider/subject_provider.dart';
import 'package:e_absensi/app/data/provider/user_provider.dart';
import 'package:get/get.dart';

class UserRepository {
  final userProvider = Get.find<UserProvider>();
  final subjectProvider = Get.find<SubjectProvider>();
  final presenceProvider = Get.find<PresenceProvider>();

  Future<void> deleteUser(String id) async {
    await userProvider.deleteUser(id);
  }

  Future<EabsensiUser?> registerToDB(EabsensiUser user) async {
    await userProvider.register(user);
    final registeredUser = await userProvider.getUser();
    return registeredUser;
  }

  Future<EabsensiUser?> getUser() async {
    final user = await userProvider.getUser();
    return user;
  }

  Future<void> updatePin(String pin, String id) async {
    await userProvider.updatePin(pin, id);
  }

  Future<bool> addSubject(String pin) async {
    final subjects = await subjectProvider.getSubjects();
    bool isExist = false;
    for (var subject in subjects) {
      if (subject.code == pin) {
        isExist = true;
        break;
      }
    }

    if (isExist) {
      final user = await getUser();
      if (user == null) return false;
      user.subjects.add(pin);
      await userProvider.addSubject(pin);
    }
    return isExist;
  }

  Future<List<Subject>?> getUserSubjects() async {
    final user = await userProvider.getUser();

    if (user == null) return null;

    final subjects = await subjectProvider.getSubjects();

    final userSubjects = subjects
        .where((subject) => user.subjects.contains(subject.code))
        .toList();

    return userSubjects;
  }

  Future<List<Presence>?> getUserPresence() async {
    final user = await userProvider.getUser();
    if (user == null) return null;
    final userSubjects = await getUserSubjects();

    if (userSubjects == null) return null;

    final List<Presence> presenceList = [];

    await Future.forEach(userSubjects, (element) async {
      print(element.code);
      final presences = await presenceProvider.getPresences(element.code);
      print(presences.length);
      presences.forEach((presence) {
        print(presence.students);
        if (!presence.students.contains(user.id)) {
          presenceList.add(presence);
        }
      });
    });

    return presenceList;
  }

  Future<bool> attend(Presence presence) async {
    final user = await userProvider.getUser();
    if (user == null) return false;
    final isAttend = await presenceProvider.attend(presence, user.id);
    return isAttend;
  }

}
