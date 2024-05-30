import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/repositories/user/user_repository.dart';
import 'package:sleep_diary_mobile/screens/profile/profile.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';

class EditProfileController extends GetxController {
  static EditProfileController get instance => Get.find();

  final RxBool isLoading = false.obs;

  final name = TextEditingController();

  Future<void> editProfile(String name) async {
    try {
      isLoading(true);

      final UserRepository userRepository = Get.put(UserRepository());
      await userRepository.editUserName(name);

      isLoading(false);
      TLoaders.successSnackBar(
          title: "Berhasil!", message: "Nama berhasil diubah!");

    } catch (e) {
      isLoading(false);
      TLoaders.errorSnackBar(title: "Gagal edit nama!", message: e.toString());
    }
  }
}
