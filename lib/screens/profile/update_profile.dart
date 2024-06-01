import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleep_diary_mobile/controllers/profile/edit_profile_controller.dart';
import 'package:sleep_diary_mobile/controllers/profile/user_controller.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    final EditProfileController editProfileController =
        Get.put(EditProfileController());

    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Profil',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 52),
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/propil.png'),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: editProfileController.name,
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(38, 38, 66, 1),
                    labelText: 'Name',
                    labelStyle: GoogleFonts.poppins(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(color: Color(0xFF080A23)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                final loading = editProfileController.isLoading.value;

                return GestureDetector(
                  onTap: () async {
                    if (loading) return;

                    await editProfileController
                        .editProfile(editProfileController.name.text);

                    Navigator.pop(context);

                    userController.fetchUserRecord();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(8.0),
                    height: 60,
                    decoration: BoxDecoration(
                      color: loading
                          // 1 == 1
                          ? Colors.grey[400]!
                          : Color.fromARGB(255, 100, 163, 214),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: loading
                          // 1 == 1
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Simpan",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
