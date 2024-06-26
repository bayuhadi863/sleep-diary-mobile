import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  signup(BuildContext context) async {
    try {
      // start Loading
      isLoading.value = true;

      // Check Internet Connectivity

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: const Color.fromRGBO(58, 58, 93, 1),
              rightDotColor: const Color(0xFFFFD670),
              size: 80,
            ),
          );
        },
        barrierDismissible: false,
      );

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

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Akun berhasil dibuat!',
          message: 'Catat tidurmu sekarang juga!');
    } catch (e) {
      // Show some Generic error to the user
      // Clear Text Fields
      Navigator.of(context).pop();

      name.clear();
      email.clear();
      password.clear();
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
