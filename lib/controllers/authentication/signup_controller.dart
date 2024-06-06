import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/repositories/user/user_repository.dart';
import 'package:sleep_diary_mobile/models/user_model.dart';
import 'package:sleep_diary_mobile/screens/authentication/verify_email.dart';
import 'package:sleep_diary_mobile/tracker_service.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // form key for form validation
  final isLoading = false.obs;
  final disabled = false.obs;

  /// Signup
  signup() async {
    try {
      // start Loading
      isLoading.value = true;

      // Check Internet Connectivity

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // wait 5 seconds
      // await Future.delayed(const Duration(seconds: 5));

      // Register user in the Firebase Authentication & Save user data in the firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        name: name.text.trim(),
        email: email.text.trim(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Akun berhasil dibuat!',
          message: 'Catat tidurmu sekarang juga!');

      // Move to Verify Email Screen
      // Get.to(() => VerifyEmailScreen(email: email.text.trim()));
      await (TrackerService()).track("click-register", withDeviceInfo: true);

      AuthenticationRepository.instance.screenRedirect();

      // Stop Loading
      isLoading.value = false;
      // Clear Text Fields
      name.clear();
      email.clear();
      password.clear();
    } catch (e) {
      // Show some Generic error to the user
      TLoaders.errorSnackBar(
          title: 'Registrasi gagal!', message: getErrorMessage(e.toString()));

      // Stop Loading
      isLoading.value = false;
    }
  }

  getErrorMessage(String error) {
    switch (error) {
      case 'email-already-in-use':
        return 'Email sudah terdaftar. Silahkan login.';
      case 'weak-password':
        return 'Password terlalu lemah.';
      case 'invalid-email':
        return 'Email tidak valid.';
      default:
        return error.toString();
    }
  }
}
