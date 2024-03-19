import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/authentication/signup_controller.dart';
import 'package:sleep_diary_mobile/utils/validators/validation.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
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
                    const Text(
                      'SleepDiary',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Buat akun baru',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: controller.signupFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.name,
                        validator: (value) => TValidator.validateName(value),
                        style: const TextStyle(color: Color(0xFF080A23)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF6F7F9),
                          labelText: 'Nama Lengkap',
                          labelStyle: const TextStyle(color: Color(0xFF080A23)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
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
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => TValidator.validateEmail(value),
                        style: const TextStyle(color: Color(0xFF080A23)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF6F7F9),
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Color(0xFF080A23)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
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
                              TValidator.validatePassword(value),
                          obscureText: controller.hidePassword.value,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF6F7F9),
                            labelStyle:
                                const TextStyle(color: Color(0xFF080A23)),
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
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
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
                        height: 30.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => controller.signup(),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF080A23)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Buat Akun',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sudah memiliki akun?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Masuk',
                              style: TextStyle(color: Color(0xFF6465F0)),
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
    );
  }
}
