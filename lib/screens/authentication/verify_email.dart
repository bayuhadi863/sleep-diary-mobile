import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/authentication/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/verification_email.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 80.0,
            ),
            const Text(
              'Verifikasi email Anda!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(email ?? ''),
            const SizedBox(
              height: 40.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => controller.checkEmailVerificationStatus(),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF080A23)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () => controller.sendEmailVerification(),
              child: const Text(
                'Resend email',
                style: TextStyle(color: Color(0xFF080A23)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
