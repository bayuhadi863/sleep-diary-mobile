import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  var pageIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void updatePageIndicator(int index) {
    pageIndex.value = index;
  }

  void nextPage() {
    if (pageController.page == 3) {
      Get.offAllNamed('/home'); // Change to your home route
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void skipPage() {
    Get.offAllNamed('/home'); // Change to your home route
  }

  void dotNavigationClick(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
