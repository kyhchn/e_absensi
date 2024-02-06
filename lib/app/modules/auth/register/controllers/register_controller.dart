import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_absensi/app/data/models/eabsensi_user.dart';
import 'package:e_absensi/app/data/services/auth_repository.dart';
import 'package:e_absensi/app/data/services/user_repository.dart';
import 'package:e_absensi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_absensi/app/core/constant.dart';

class RegisterController extends GetxController {
  final key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nimController = TextEditingController();
  final pinController = TextEditingController();
  final isLoading = false.obs;

  final authRepo = Get.find<AuthRepository>();
  final userRepo = Get.find<UserRepository>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void register() async {
    isLoading.value = true;
    try {
      if (!key.currentState!.validate()) return;
      final currentUser = auth.currentUser!;
      final name = nameController.text;
      final nim = nimController.text;
      final pin = pinController.text;
      final user = EabsensiUser(
          id: currentUser.uid,
          name: name,
          nim: nim,
          email: currentUser.email!,
          pin: pin,
          subjects: []);
      await userRepo.registerToDB(user);
      Get.offAllNamed(Routes.HOME);
    } on FirebaseException catch (e) {
      Get.snackbar('Error', e.message ?? 'Error',
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }
}
