// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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

    return Obx(() {
      final loading = editProfileController.isLoading.value;
      return WillPopScope(
        onWillPop: () async {
          setState(() {
            editProfileController.name.text =
                editProfileController.oldName.value;
          });
          return true;
        },
        child: Scaffold(
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
                setState(() {
                  editProfileController.name.text =
                      editProfileController.oldName.value;
                });
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
                      onChanged: (value) {
                        setState(() {
                          editProfileController.name.text = value;
                        });
                      },
                      controller: editProfileController.name,
                      style: GoogleFonts.poppins(color: Colors.white),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9\s]')),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(38, 38, 66, 1),
                        labelText: 'Nama',
                        labelStyle: GoogleFonts.poppins(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide:
                              const BorderSide(color: Color(0xFF080A23)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print("currentName ${editProfileController.name.text}");
                      print("oldName ${editProfileController.oldName.value}");

                      if (editProfileController.name.text ==
                          editProfileController.oldName.value) {
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
                      await editProfileController
                          .editProfile(editProfileController.name.text);

                      userController.fetchUserRecord();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.all(8.0),
                      height: 60,
                      decoration: BoxDecoration(
                        color: loading
                            // 1 == 1
                            ? Colors.grey[400]!
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: loading
                            // 1 == 1
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text("Simpan",
                                style: GoogleFonts.poppins(
                                  color: editProfileController.name.text ==
                                              editProfileController
                                                  .oldName.value ||
                                          editProfileController
                                                  .disabled.value ==
                                              true
                                      ? Colors.grey[400]
                                      : Colors.black,
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
