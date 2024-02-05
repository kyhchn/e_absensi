import 'package:e_absensi/app/core/constant.dart';
import 'package:e_absensi/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  static get i => Get.find<AuthController>();
  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setScreen);
  }

  @override
  void onClose() {
    super.onClose();
  }

  _setScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed(Routes.SIGNIN);
    } else {
      final userDb = await firestore.collection('users').doc(user.uid).get();
      if (userDb.exists) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.REGISTER);
      }
    }
  }
}
