import 'package:flutter/material.dart';
import 'package:sleep_diary_mobile/screens/authentication/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login Form"),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Masukkan email'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Masukkan password'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
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
