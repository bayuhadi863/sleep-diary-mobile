import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';

class LoginController extends GetxController {
  /// Variables
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Email and password sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        return;
      }

      // Login user using email & password
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: e.toString(),
      );
    }
  }
}
