import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sleep_diary_mobile/main.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/home_page.dart';
import 'package:sleep_diary_mobile/tracker_service.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';

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
      // Validasi data
      if (newSleepDiary.sleepDate == "") {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Tanggal tidak boleh kosong");

        return;
      }

      if (newSleepDiary.sleepTime == "") {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Waktu tidur tidak boleh kosong");

        return;
      }

      if (newSleepDiary.wakeupTime == "") {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Waktu bangun tidak boleh kosong");

        return;
      }

      if (calculateTimeDifference(wakeupTime, sleepTime) < 15) {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Durasi tidur minimal 15 menit");

        return;
      }

      if (newSleepDiary.scale == 0) {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Skala kualitas tidak boleh kosong");

        return;
      }

      if (newSleepDiary.scale < 4 && newSleepDiary.factors.isEmpty) {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Faktor tidur tidak boleh kosong");

        return;
      }

      if (newSleepDiary.description == "") {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Deskripsi tidur tidak boleh kosong");

        return;
      }

      // Insert SleepDiary ke Firebase
      await FirebaseFirestore.instance
          .collection("sleepDiaries")
          .add(newSleepDiary.toJson());

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Selamat!', message: 'Anda berhasil mencatat tidur Anda.');
      await (TrackerService()).track("create-sleepdiary", withDeviceInfo: true);

      // Fetch data SleepDiary
      HomePage.sleepDiaryController.fetchSleepDiaryData(HomePage.today);

      // Redirect ke Home Page
      Get.offAll(() => const MainPage());
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const MainPage()));
    } catch (error) {
      print('Error: $error');
      throw 'Error $error';
    }
  }

  Future<void> updateSleepDiary(BuildContext context) async {
    String sleepTime = "$hour1:$minute1";
    String wakeupTime = "$hour2:$minute2";

    final editedSleepDiary = SleepDiaryModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        sleepDate: sleepDate,
        sleepTime: sleepTime,
        wakeupTime: wakeupTime,
        scale: scale,
        factors: factors,
        description: description);

    try {
      if (editedSleepDiary.sleepDate == "") {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Tanggal tidak boleh kosong");

        return;
      }

      if (editedSleepDiary.sleepTime == "") {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Waktu tidur tidak boleh kosong");

        return;
      }

      if (editedSleepDiary.wakeupTime == "") {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Waktu bangun tidak boleh kosong");

        return;
      }

      if (calculateTimeDifference(wakeupTime, sleepTime) < 15) {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Durasi tidur minimal 15 menit");

        return;
      }

      if (editedSleepDiary.scale == 0) {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Skala kualitas tidak boleh kosong");

        return;
      }

      if (editedSleepDiary.scale < 4 && editedSleepDiary.factors.isEmpty) {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Faktor tidur tidak boleh kosong");

        return;
      }

      if (editedSleepDiary.description == "") {
        TLoaders.errorSnackBar(
            title: 'Gagal!', message: "Deskripsi tidur tidak boleh kosong");

        return;
      }

      final sleepDiary = await FirebaseFirestore.instance
          .collection('sleepDiaries')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('sleepDate', isEqualTo: sleepDate)
          .get();

      await sleepDiary.docs.first.reference.update(editedSleepDiary.toJson());
      await (TrackerService()).track("update-sleepdiary", withDeviceInfo: true);

      TLoaders.successSnackBar(
          title: 'Selamat!',
          message: 'Anda berhasil memperbarui catatan tidur Anda.');

      HomePage.sleepDiaryController.fetchSleepDiaryData(HomePage.today);

      Get.offAll(() => const MainPage());
    } catch (error) {
      throw 'Error $error';
    }
  }

  static Future<void> deleteSleepDiary() async {
    try {
      final sleepDiary = await FirebaseFirestore.instance
          .collection('sleepDiaries')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('sleepDate',
              isEqualTo: DateFormat.yMMMMEEEEd('en_US').format(HomePage.today))
          .get();

      for (var doc in sleepDiary.docs) {
        await doc.reference.delete();
      }

      TLoaders.successSnackBar(
          title: 'Selamat!',
          message: 'Anda berhasil menghapus catatan tidur Anda.');
      await (TrackerService()).track("delete-sleepdiary", withDeviceInfo: true);

      HomePage.sleepDiaryController.fetchSleepDiaryData(HomePage.today);

      Get.offAll(() => const MainPage());
    } catch (e) {
      throw 'Error: $e';
    }
  }

  int calculateTimeDifference(String wakeupTime, String sleepTime) {
    // Ubah string waktu menjadi objek DateTime
    final wakeupTimeParts = wakeupTime.split(":");
    int wakeupHour = int.tryParse(wakeupTimeParts[0]) ?? 0;
    int wakeupMinute =
        wakeupTimeParts.length > 1 ? int.tryParse(wakeupTimeParts[1]) ?? 0 : 0;

    final sleepTimeParts = sleepTime.split(":");
    int sleepHour = int.tryParse(sleepTimeParts[0]) ?? 0;
    int sleepMinute =
        sleepTimeParts.length > 1 ? int.tryParse(sleepTimeParts[1]) ?? 0 : 0;

    DateTime firstTime = DateTime(2024, 4, 22, sleepHour, sleepMinute);
    DateTime secondTime = DateTime(2024, 5, 22, wakeupHour, wakeupMinute);

    Duration differenceTime = secondTime.difference(firstTime);
    int hours = differenceTime.inHours % 24;
    int minutes = differenceTime.inMinutes % 60;

    return (hours * 60) + minutes;
  }
}
