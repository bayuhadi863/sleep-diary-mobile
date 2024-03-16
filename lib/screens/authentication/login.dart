import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sleep_diary_mobile/controllers/authentication/login_controller.dart';
import 'package:sleep_diary_mobile/screens/authentication/signup.dart';
import 'package:sleep_diary_mobile/utils/validators/validation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login Form"),
            Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      validator: (value) => TValidator.validateEmail(value),
                      decoration:
                          const InputDecoration(labelText: 'Masukkan email'),
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
                        decoration: InputDecoration(
                          labelText: 'Masukkan password',
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: Icon(controller.hidePassword.value
                                ? FeatherIcons.eyeOff
                                : FeatherIcons.eye),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.emailAndPasswordSignIn(),
                        child: const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text('Create Account'),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
