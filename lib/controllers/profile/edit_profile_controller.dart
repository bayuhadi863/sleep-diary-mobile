import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/repositories/user/user_repository.dart';
import 'package:sleep_diary_mobile/screens/profile/profile.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';

class EditProfileController extends GetxController {
  static EditProfileController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxBool fetchLoading = false.obs;

  final name = TextEditingController();
  final RxString oldName = "".obs;
  final RxBool disabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  void getUserProfile() async {
    try {
      fetchLoading(true);

      final UserRepository userRepository = Get.put(UserRepository());
      final user = await userRepository.fetchUserDetails();
      name.text = user.name;
      oldName.value = user.name;

      fetchLoading(false);
    } catch (e) {
      fetchLoading(false);
      TLoaders.errorSnackBar(title: "Gagal fetch data!", message: e.toString());
    }
  }

  Future<void> editProfile(String name, BuildContext context) async {
    try {
      isLoading(true);

     

      final UserRepository userRepository = Get.put(UserRepository());
      await userRepository.editUserName(name);

      isLoading(false);
      TLoaders.successSnackBar(
          title: "Berhasil!", message: "Nama berhasil diubah!");

      getUserProfile();

      //clear
      // this.name.clear();
    } catch (e) {
      Navigator.of(context).pop();
      isLoading(false);
      TLoaders.errorSnackBar(title: "Gagal edit nama!", message: e.toString());
    }
  }
}
