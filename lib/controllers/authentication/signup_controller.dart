import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/repositories/user/user_repository.dart';
import 'package:sleep_diary_mobile/models/user_model.dart';
import 'package:sleep_diary_mobile/screens/authentication/verify_email.dart';
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
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

      // Stop Loading
      isLoading.value = false;

    } catch (e) {
      // Show some Generic error to the user
      TLoaders.errorSnackBar(title: 'Oh, Snap!', message: e.toString());

      // Stop Loading
      isLoading.value = false;
    }
  }
}
