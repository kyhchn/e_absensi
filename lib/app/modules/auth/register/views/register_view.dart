import 'package:e_absensi/app/core/themes/typography.dart';
import 'package:e_absensi/app/widgets/button.dart';
import 'package:e_absensi/app/widgets/form_input.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selangkah lagi untuk bergabung',
                      style: TypographyStyles.h2
                          .copyWith(color: Colors.grey.shade900),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text('Silahkan isi data diri berikut ',
                        style: TypographyStyles.b2
                            .copyWith(color: Colors.grey.shade600)),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                FormInput(
                    validator: FormBuilderValidators.required(),
                    label: 'Nama Lengkap',
                    hint: 'Masukkan nama lengkap',
                    inputType: TextInputType.name,
                    controller: controller.nameController),
                const SizedBox(
                  height: 16,
                ),
                FormInput(
                    validator: FormBuilderValidators.required(),
                    label: 'NIM',
                    hint: 'Masukkan NIM',
                    inputType: TextInputType.number,
                    controller: controller.nimController),
                const SizedBox(
                  height: 16,
                ),
                FormInput(
                    validator: FormBuilderValidators.required(),
                    label: 'PIN',
                    hint: 'Masukkan PIN',
                    inputType: TextInputType.number,
                    controller: controller.pinController),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => DefaultButton(
                        onPressed: controller.register,
                        type: Type.primary,
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Daftar'),
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
