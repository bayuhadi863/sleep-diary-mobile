import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sleep_diary_mobile/main.dart';
import 'package:sleep_diary_mobile/screens/authentication/login.dart';
import 'package:sleep_diary_mobile/screens/authentication/onboarding.dart';
import 'package:sleep_diary_mobile/screens/authentication/verify_email.dart';
import 'package:sleep_diary_mobile/tracker_service.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final isLoading = false.obs;

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Called fron main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => const MainPage());
    } else {
      // Local storage
      deviceStorage.writeIfNull('isFirstTime', true);
      // check if it's the firs time launching the app
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  /* --------------------------- Email & Password sign-in ---------------- */

  /// EmailAuthentication - SignIn
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format Exeption Error';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// EmailAuthentication - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format Exeption Error';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// EmailVerification - Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exception error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// ReAuthenticate - ReAuthenticate user
  /// EmailAuthentication - Forget Password

  /* --------------------------- End federated identity ---------------- */

  /// LogoutUser
  Future<void> logout() async {
    // Start loading
    isLoading.value = true;

    try {
      await (TrackerService()).track("click-logout", withDeviceInfo: true);
      await FirebaseAuth.instance.signOut();

      Get.offAll(() => const LoginScreen());

      isLoading.value = false;

    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      throw e.code;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      throw e.code;
    } on FormatException catch (_) {
      isLoading.value = false;
      throw 'Format exception error';
    } on PlatformException catch (e) {
      isLoading.value = false;
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// RemoveUser - Remove user Auth and Firestore Account
}
