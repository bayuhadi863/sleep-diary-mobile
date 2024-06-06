import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TLoaders {
  static successSnackBar({required title, message = '', duration = 2}) {
    Get.snackbar(
      title,
      message,
      overlayBlur: 0.5,
      overlayColor: Colors.black.withOpacity(0.5),
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  static errorSnackBar({required title, message = '', duration = 2}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      overlayBlur: 0.5,
      overlayColor: Colors.black.withOpacity(0.5),
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }
}
