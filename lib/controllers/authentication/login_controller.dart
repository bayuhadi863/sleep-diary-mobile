import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/tracker_service.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';

class LoginController extends GetxController {
  /// Variables
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final disabled = false.obs;

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

      // wait 5 seconds
      // await Future.delayed(const Duration(seconds: 5));

      // Login user using email & password
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      await (TrackerService()).track("click-login", withDeviceInfo: true);

      // redirect
      AuthenticationRepository.instance.screenRedirect();

      // Stop Loading
      isLoading.value = false;

      TLoaders.successSnackBar(
          title: "Berhasil login!", message: 'Catat tidurmu sekarang juga!');
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Login gagal!',
        message: getErrorMessage(e.toString()),
      );

      // Stop Loading
      isLoading.value = false;
    }
  }

  getErrorMessage(String error) {
    switch (error) {
      case 'invalid-credential':
        return 'Email atau password salah!';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan login. Coba lagi nanti.';
      default:
    }
    if (error == 'invalid-credential') {
      return 'Email atau password salah!';
    } else {
      return error.toString();
    }
  }
}
