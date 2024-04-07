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
  final isLoading = false.obs;

  /// Email and password sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      isLoading.value = true;

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        // Stop Loading
        isLoading.value = false;

        return;
      }

      // Login user using email & password
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      TLoaders.successSnackBar(
          title: "Login success", message: 'Mari catat tidurmu!');

      // redirect
      AuthenticationRepository.instance.screenRedirect();

      // Stop Loading
      isLoading.value = false;
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: e.toString(),
      );

      // Stop Loading
      isLoading.value = false;
    }
  }
}
