import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/profile/user_controller.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 52,
            ),
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/bulan.png'),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF262642),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: const Text(
                  "Nama Lengkap",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Obx(
                  () => Text(controller.user.value.name,
                      style: const TextStyle(color: Colors.white)),
                ),
                leading: const Icon(CupertinoIcons.person, color: Colors.white),
                tileColor: Colors.transparent,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF262642),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: const Text(
                  "Email",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Obx(
                  () => Text(controller.user.value.email,
                      style: const TextStyle(color: Colors.white)),
                ),
                leading: const Icon(CupertinoIcons.mail, color: Colors.white),
                tileColor: Colors.transparent,
              ),
            ),
            const SizedBox(
              height: 350,
            ),
            GestureDetector(
              onTap: () async {
                await AuthenticationRepository.instance.logout();
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 167, 21, 21),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
