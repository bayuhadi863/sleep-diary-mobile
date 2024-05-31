import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleep_diary_mobile/controllers/profile/user_controller.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/screens/profile/update_profile.dart';

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
              radius: 80,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Text(
                controller.user.value.name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Obx(
              () => Text(
                controller.user.value.email,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProfile()));
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 60,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(38, 38, 66, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Edit Profile",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => GestureDetector(
                onTap: AuthenticationRepository.instance.isLoading.isTrue
                    ? null
                    : () async {
                        bool confirmLogout = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromRGBO(38, 38, 66, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/logoutpopup.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Apakah Anda yakin ingin logout?',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 1.0, color: Colors.white),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text(
                                          'Batal',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 215, 56, 45),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text(
                                          'Logout',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                        if (confirmLogout == true) {
                          await AuthenticationRepository.instance.logout();
                        }
                      },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 60,
                  decoration: BoxDecoration(
                    color: AuthenticationRepository.instance.isLoading.isTrue
                        ? const Color.fromARGB(255, 167, 21, 21)
                            .withOpacity(0.6)
                        : const Color.fromARGB(255, 167, 21, 21),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: AuthenticationRepository.instance.isLoading.isTrue
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Logout",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
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
