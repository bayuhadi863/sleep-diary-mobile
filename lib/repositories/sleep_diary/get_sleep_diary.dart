import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:intl/intl.dart';

class GetSleepDiaryRepository extends GetxController {
  static GetSleepDiaryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<SleepDiaryModel> fetchSleepDiary() async {
    try {
      final user = AuthenticationRepository.instance.authUser;
      final now = DateTime.now();
      final String formattedDate = DateFormat.yMMMMEEEEd().format(now);

      final snapshot = await _db
          .collection('sleepDiaries')
          .where('userId', isEqualTo: user!.uid)
          .where('sleepDate', isEqualTo: formattedDate)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        return SleepDiaryModel(
          userId: data['userId'],
          sleepDate: data['sleepDate'],
          sleepTime: data['sleepTime'],
          wakeupTime: data['wakeupTime'],
          scale: data['scale'],
          description: data['description'],
        );
      }
      return SleepDiaryModel.empty();
    } on PlatformException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
      return SleepDiaryModel.empty();
    }
  }

  Future<List<String>> fetchSleepFactorIds(String sleepDiaryId) async {
    try {
      final snapshot = await _db
          .collection('sleepFactors')
          .where('sleepDiaryId', isEqualTo: sleepDiaryId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Extract only factorIds for efficiency and clarity
        return snapshot.docs
            .map((doc) => doc.data()['factorId'] as String)
            .toList();
      }
      return [];
    } on PlatformException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
      return [];
    }
  }
}
