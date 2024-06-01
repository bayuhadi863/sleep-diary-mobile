// ignore_for_file: deprecated_member_use

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleep_diary_mobile/controllers/authentication/login_controller.dart';
import 'package:sleep_diary_mobile/screens/authentication/signup.dart';
import 'package:sleep_diary_mobile/utils/validators/validation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 80,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/app_logo_fix.png',
                        width: 60,
                        height: 76,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'SleepDiary',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Masuk Untuk Melanjutkan',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.email,
                          validator: (value) => TValidator.validateEmail(value),
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF080A23)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF6F7F9),
                            labelText: 'Email',
                            labelStyle: GoogleFonts.poppins(
                                color: const Color(0xFF080A23)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  const BorderSide(color: Color(0xFF080A23)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: controller.password,
                            validator: (value) =>
                                TValidator.validateEmptyText('Password', value),
                            obscureText: controller.hidePassword.value,
                            style: GoogleFonts.poppins(
                                color: const Color(0xFF080A23)),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF6F7F9),
                              labelStyle: GoogleFonts.poppins(
                                  color: const Color(0xFF080A23)),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () => controller.hidePassword.value =
                                    !controller.hidePassword.value,
                                icon: Icon(
                                  controller.hidePassword.value
                                      ? FeatherIcons.eyeOff
                                      : FeatherIcons.eye,
                                  size: 20,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:
                                    const BorderSide(color: Color(0xFF080A23)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: controller.disabled.value
                                  ? null
                                  : controller.isLoading.isTrue
                                      ? null // Menonaktifkan button saat isLoading bernilai true
                                      : () async {
                                          controller.disabled.value = true;
                                          controller.emailAndPasswordSignIn();
                                          // wait 1 second
                                          await Future.delayed(
                                              const Duration(seconds: 4));
                                          controller.disabled.value = false;
                                        },
                              style: ButtonStyle(
                                backgroundColor: controller.isLoading.isTrue
                                    ? MaterialStateProperty.all(
                                        const Color(0xFF080A23).withOpacity(
                                            0.6)) // Atur opasitas warna latar belakang
                                    : MaterialStateProperty.all(
                                        const Color(0xFF080A23)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      14,
                                    ),
                                  ),
                                ),
                              ),
                              child: controller.isLoading.isTrue
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      'Login',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum memiliki akun?",
                              style: GoogleFonts.poppins(),
                            ),
                            Transform.translate(
                              offset: const Offset(-5.0, 0.0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Daftar',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xFF6465F0),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
