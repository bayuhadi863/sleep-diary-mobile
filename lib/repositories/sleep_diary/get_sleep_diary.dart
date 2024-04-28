import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:intl/intl.dart';

class GetSleepDiaryRepository extends GetxController {
  static GetSleepDiaryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<SleepDiaryModel> fetchSleepDiary(date) async {
    try {
      final user = AuthenticationRepository.instance.authUser;
      final now = DateTime.now();
      final String formattedDate = DateFormat.yMMMMEEEEd().format(date);

      final snapshot = await _db
          .collection('sleepDiaries')
          .where('userId', isEqualTo: user!.uid)
          .where('sleepDate', isEqualTo: formattedDate)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        // print('Data fetched: $data');
        return SleepDiaryModel(
          userId: data['userId'],
          sleepDate: data['sleepDate'],
          sleepTime: data['sleepTime'],
          wakeupTime: data['wakeupTime'],
          scale: data['scale'],
          factors:
              data['factors'] != null ? List<String>.from(data['factors']) : [],
          description: data['description'],
        );
      }
      // print('No data fetched');
      return SleepDiaryModel.empty();
    } on PlatformException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
      // print('Error fetching data: $e');
      return SleepDiaryModel.empty();
    }
  }
}