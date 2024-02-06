import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_absensi/app/data/models/eabsensi_user.dart';
import 'package:e_absensi/app/data/models/presence.dart';
import 'package:e_absensi/app/data/models/subject.dart';
import 'package:e_absensi/app/data/services/auth_repository.dart';
import 'package:e_absensi/app/data/services/presence_repository.dart';
import 'package:e_absensi/app/data/services/user_repository.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final index = 0.obs;
  final isLoading = false.obs;
  late final LocalAuthentication auth;
  bool isBiometricSupported = false;

  final userRepo = Get.find<UserRepository>();
  final presenceRepo = Get.find<PresenceRepository>();
  final authRepo = Get.find<AuthRepository>();

  final RxList<Presence> presences = <Presence>[].obs;
  final RxList<Subject> subjects = <Subject>[].obs;
  final RxList<List<int>> attendance = <List<int>>[].obs;
  final Rxn<EabsensiUser> user = Rxn<EabsensiUser>();

  String getSubjectName(String code) {
    final subject =
        subjects.firstWhereOrNull((element) => element.code == code);
    return subject?.name ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((value) => isBiometricSupported = value);
  }

  @override
  void onReady() {
    super.onReady();
    fetchUser();
    fetchSubject();
    fetchPresence();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() async {
    await authRepo.signOut();
  }

  void fetchUser() async {
    final user = await userRepo.getUser();
    if (user != null) {
      this.user.value = user;
    }
  }

  void addSubject(String code) async {
    try {
      bool isSuccess = await userRepo.addSubject(code);
      if (isSuccess) {
        Get.snackbar('Success', 'Subject added',
            snackPosition: SnackPosition.BOTTOM);
        refetch();
      } else {
        Get.snackbar('Error', 'Subject not found',
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseException catch (e) {
      Get.snackbar('Error', e.message ?? 'Error',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void fetchSubject() async {
    isLoading.value = true;
    attendance.clear();
    final user = await userRepo.getUser();
    if (user == null) return;
    final subjects = await userRepo.getUserSubjects();
    if (subjects != null) {
      await Future.forEach(subjects, (element) async {
        final presences = await presenceRepo.getPresences(element.code);
        int atttendance = 0;
        int total = presences.length;
        presences.forEach(
          (presence) {
            if (presence.students.contains(user.id)) {
              atttendance++;
            }
          },
        );
        attendance.add([atttendance, total]);
      });
      this.subjects.assignAll(subjects);
    }

    isLoading.value = false;
  }

  void fetchPresence() async {
    isLoading.value = true;
    final data = await userRepo.getUserPresence();
    if (data != null) {
      presences.assignAll(data);
    }
    isLoading.value = false;
  }

  void attendWithPin(Presence presence, String pin) async {
    try {
      if (user.value?.pin != pin) {
        Get.snackbar('Error', 'Pin is incorrect',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      bool isSuccess = await userRepo.attend(presence);
      if (isSuccess) {
        Get.snackbar('Success', 'Attendance success',
            snackPosition: SnackPosition.BOTTOM);
        refetch();
      } else {
        Get.snackbar('Error', 'Attendance failed',
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseException catch (e) {
      Get.snackbar('Error', e.message ?? 'Error',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void attendWithBiometric(Presence presence) async {
    bool authenticated = await authenticateBiometric();
    if (authenticated) {
      bool isSuccess = await userRepo.attend(presence);
      if (isSuccess) {
        Get.snackbar('Success', 'Attendance success',
            snackPosition: SnackPosition.BOTTOM);
        refetch();
      } else {
        Get.snackbar('Error', 'Attendance failed',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Error', 'Biometric authentication failed',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void refetch() async {
    fetchSubject();
    fetchPresence();
  }

  Future<bool> authenticateBiometric() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to Presence',
        options: const AuthenticationOptions(
            stickyAuth: true, biometricOnly: true, useErrorDialogs: true),
      );
      return authenticated;
    } catch (e) {
      return false;
    }
  }
}
