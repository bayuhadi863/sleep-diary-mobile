import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Signup Form"),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Masukkan nama lengkap'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Login'),
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
