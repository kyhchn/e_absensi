import 'package:e_absensi/app/data/provider/auth_provider.dart';
import 'package:e_absensi/app/data/provider/presence_provider.dart';
import 'package:e_absensi/app/data/provider/subject_provider.dart';
import 'package:e_absensi/app/data/provider/user_provider.dart';
import 'package:e_absensi/app/data/services/auth_repository.dart';
import 'package:e_absensi/app/data/services/presence_repository.dart';
import 'package:e_absensi/app/data/services/subject_repository.dart';
import 'package:e_absensi/app/data/services/user_repository.dart';
import 'package:e_absensi/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

injection() async {
  //providers
  Get.put(AuthProvider());
  Get.put(PresenceProvider());
  Get.put(SubjectProvider());
  Get.put(UserProvider());

  //repositories
  Get.put(AuthRepository());
  Get.put(SubjectRepository());
  Get.put(UserRepository());
  Get.put(PresenceRepository());

  //controllers
  Get.put(AuthController());
}
