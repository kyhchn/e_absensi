import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_absensi/app/core/themes/colors.dart';
import 'package:e_absensi/app/core/themes/typography.dart';
import 'package:e_absensi/app/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.index.value,
            onTap: (index) {
              controller.index.value = index;
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.checklist),
                label: 'Presensi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.subject),
                label: 'Mata Kuliah',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => !controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IndexedStack(
                      index: controller.index.value,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Presensi Berlangsung',
                                style: TypographyStyles.h2.copyWith(
                                  color: CustomColor.primary,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                shrinkWrap: true,
                                itemCount: controller.presences.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: CustomColor.primary.shade600),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    title: Column(
                                      children: [
                                        Text(
                                            controller.getSubjectName(
                                              controller.presences[index].code,
                                            ),
                                            textAlign: TextAlign.center,
                                            style: TypographyStyles.h3.copyWith(
                                              color: CustomColor.primary,
                                            )),
                                        Text(
                                          controller.presences[index].title,
                                          textAlign: TextAlign.center,
                                          style: TypographyStyles.b2.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: DefaultButton(
                                              onPressed: () {
                                                //show dialog with button presensi and use biometric with one textfield for pin
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      String pin = '';
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Enter Pin'),
                                                        content: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                'Enter pin',
                                                          ),
                                                          onChanged: (value) {
                                                            pin = value;
                                                          },
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                controller.attendWithBiometric(
                                                                    controller
                                                                            .presences[
                                                                        index]);
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  'Fingerprint')),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              controller
                                                                  .attendWithPin(
                                                                      controller
                                                                              .presences[
                                                                          index],
                                                                      pin);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Konfirmasi'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              type: Type.primary,
                                              child: const Text('Hadir')),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Rekap Presensi',
                              style: TypographyStyles.h2.copyWith(
                                color: CustomColor.primary,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: controller.subjects.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: CustomColor.primary.shade600),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    title:
                                        Text(controller.subjects[index].name),
                                    subtitle: Text(
                                        'Hadir ${controller.attendance[index].first} dari ${controller.attendance[index].last} pertemuan'),
                                    leading: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(
                                        controller.subjects[index].imageUrl,
                                        height: 100,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Center(child: const CircularProgressIndicator()),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'add',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String code = ''; // Initialize the input value
                    return AlertDialog(
                      title: const Text('Tambah Mata Kuliah'),
                      content: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter code',
                        ),
                        onChanged: (value) {
                          code =
                              value; // Update the code variable when the input changes
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back(); // Close the dialog
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back(); // Close the dialog
                            controller.addSubject(code);
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              heroTag: 'logout',
              backgroundColor: Colors.red,
              onPressed: controller.logout,
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}
