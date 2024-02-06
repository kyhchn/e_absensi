import 'package:e_absensi/app/core/injection.dart';
import 'package:e_absensi/app/core/themes/colors.dart';
import 'package:e_absensi/app/core/themes/typography.dart';
import 'package:e_absensi/app/modules/auth/controllers/auth_controller.dart';
import 'package:e_absensi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await injection();
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: CustomColor.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge: TypographyStyles.h1.bold(),
          titleMedium: TypographyStyles.h2.bold(),
          titleSmall: TypographyStyles.h3.bold(),
          bodyLarge: TypographyStyles.b1,
          bodyMedium: TypographyStyles.b2,
          bodySmall: TypographyStyles.b3,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: CustomColor.primary,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              textStyle:
                  TypographyStyles.b3.semibold(color: CustomColor.primary)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: CustomColor.primary.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: CustomColor.primary.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: const EdgeInsets.all(12),
          prefixIconColor: CustomColor.primary,
          hintStyle: TypographyStyles.b3.semibold(
            color: Colors.grey.shade600,
          ),
        ),
        appBarTheme: AppBarTheme(
          actionsIconTheme: const IconThemeData(
            size: 24,
            color: Colors.white,
          ),
          backgroundColor: CustomColor.primary.shade500,
          foregroundColor: Colors.white,
          titleTextStyle: TypographyStyles.h3.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: false,
          elevation: 0,
          titleSpacing: 0,
        ),
      ),
    ),
  );
}
