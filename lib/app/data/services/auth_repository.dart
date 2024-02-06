import 'package:e_absensi/app/data/provider/auth_provider.dart';
import 'package:get/get.dart';

class AuthRepository {
  final authProvider = Get.find<AuthProvider>();

  Future<void> loginWithEmailPassword(String email, String password) async {
    await authProvider.loginWithEmailPassword(email, password);
  }

  Future<void> registerWithEmailPassword(String email, String password) async {
    await authProvider.registerWithEmailPassword(email, password);
  }

  Future<void> signOut() async {
    await authProvider.signOut();
  }

  Future<void> loginWithGoogleSSO() async {
    await authProvider.loginWithGoogleSSO();
  }
}
