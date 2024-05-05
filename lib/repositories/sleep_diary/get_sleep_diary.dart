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
          id: snapshot.docs.first.id,
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

  // function to check if the date have sleep diary data
  Future<bool> checkSleepDiaryData(date) async {
    final user = AuthenticationRepository.instance.authUser;
    final String formattedDate = DateFormat.yMMMMEEEEd().format(date);

    final snapshot = await _db
        .collection('sleepDiaries')
        .where('userId', isEqualTo: user!.uid)
        .where('sleepDate', isEqualTo: formattedDate)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  // get all date in sleep diary datas
  Future<List<String>> getSleepDiaryDates() async {
    final user = AuthenticationRepository.instance.authUser;
    final snapshot = await _db
        .collection('sleepDiaries')
        .where('userId', isEqualTo: user!.uid)
        .get();

    return snapshot.docs.map((e) => e.data()['sleepDate'].toString()).toList();
  }

  // get sleep diary by id
  Future<SleepDiaryModel> fetchSleepDiaryById(String uid) async {
    try {
      final DocumentSnapshot documentSnapshot =
          await _db.collection('sleepDiaries').doc(uid).get();
      if (documentSnapshot.exists) {
        return SleepDiaryModel.fromSnapshot(documentSnapshot);
      } else {
        throw SleepDiaryModel.empty();
      }
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
