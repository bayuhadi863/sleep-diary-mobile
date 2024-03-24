import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleep_diary_mobile/main.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/home_page.dart';

class SleepDiaryRepository {
  // Variabel-variabel yang harus di dapatkan saat ingin mengakses class ini
  final String sleepDate;
  final String hour1;
  final String minute1;
  final String hour2;
  final String minute2;
  final int scale;
  final List<String> factors;
  final String description;

  // Proses mendapatkan variabel dari halaman lain
  const SleepDiaryRepository(
      {required this.sleepDate,
      required this.hour1,
      required this.minute1,
      required this.hour2,
      required this.minute2,
      required this.scale,
      required this.factors,
      required this.description});

  // Fungsi untuk menyimpan SleepDiary dan SleepFactor
  Future<void> createSleepDiary(BuildContext context) async {
    // Parsing waktu tidur dan waktu bangun
    String sleepTime = "$hour1:$minute1";
    String wakeupTime = "$hour2:$minute2";

    // Model yang akan di-insert ke firebase
    final newSleepDiary = SleepDiaryModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        sleepDate: sleepDate,
        sleepTime: sleepTime,
        wakeupTime: wakeupTime,
        scale: scale,
        factors: factors,
        description: description);

    try {
      // Insert SleepDiary ke Firebase
      await FirebaseFirestore.instance
          .collection("sleepDiaries")
          .add(newSleepDiary.toJson());

      HomePage.sleepDiaryController.fetchSleepDiaryData(HomePage.today);

      // Redirect ke Home Page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } catch (error) {
      throw 'Error $error';
    }
  }
}
