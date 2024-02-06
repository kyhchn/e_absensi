import 'package:e_absensi/app/core/themes/typography.dart';
import 'package:e_absensi/app/widgets/button.dart';
import 'package:e_absensi/app/widgets/form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: controller.key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/login.jpg',
                    height: Get.height * 0.3,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: TypographyStyles.h2
                          .copyWith(color: Colors.grey.shade900),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text('Silahkan masukkan email dan password Anda ',
                        style: TypographyStyles.b2
                            .copyWith(color: Colors.grey.shade600)),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                FormInput(
                    validator: FormBuilderValidators.email(),
                    label: 'Alamat Email',
                    hint: 'Masukkan alamat email',
                    inputType: TextInputType.emailAddress,
                    controller: controller.emailController),
                const SizedBox(
                  height: 16,
                ),
                FormInput(
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(8),
                    ]),
                    label: 'Kata Sandi',
                    hint: '****',
                    inputType: TextInputType.visiblePassword,
                    controller: controller.passwordController),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => DefaultButton(
                        onPressed: controller.login,
                        type: Type.primary,
                        child: controller.isLoginLoading.value
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Masuk'),
                      ),
                    )),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    'Atau',
                    style: TypographyStyles.b3
                        .semibold(color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: double.infinity,
                    child: DefaultButton(
                      onPressed: controller.loginWithGoogle,
                      type: Type.secondary,
                      child: Obx(
                        () => controller.isGoogleLoading.value
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/google.svg',
                                      height: 16, width: 16),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  const Text('Masuk dengan Google')
                                ],
                              ),
                      ),
                    )),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => DefaultButton(
                        onPressed: controller.registerWithEmailAndPassword,
                        type: Type.primary,
                        child: controller.isRegisterLoading.value
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Register'),
                      ),
                    )),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
