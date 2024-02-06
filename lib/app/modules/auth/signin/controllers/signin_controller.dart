import 'package:e_absensi/app/data/services/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final authRepo = Get.find<AuthRepository>();

  final count = 0.obs;
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

  void increment() => count.value++;

  void login() async {
    isLoading.value = true;
    try {
      if (!key.currentState!.validate()) return;
      final email = emailController.text;
      final password = passwordController.text;
      await authRepo.loginWithEmailPassword(email, password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Error',
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }

  void loginWithGoogle() async {
    isLoading.value = true;
    try {
      await authRepo.loginWithGoogleSSO();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Error',
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }

  void registerWithEmailAndPassword() async {
    isLoading.value = true;
    try {
      if (!key.currentState!.validate()) return;
      final email = emailController.text;
      final password = passwordController.text;
      await authRepo.registerWithEmailPassword(email, password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Error',
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }
}
