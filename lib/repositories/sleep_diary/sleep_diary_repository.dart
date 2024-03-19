import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sleep_diary_mobile/pages/home_page.dart';

class SleepDiaryRepository {
  // Variabel-variabel yang harus di dapatkan saat ingin mengakses class ini
  final String sleepDate;
  final String hour1;
  final String minute1;
  final String hour2;
  final String minute2;
  final int scale;
  final String description;
  final List<int> factors;

  // Proses mendapatkan variabel dari halaman lain
  const SleepDiaryRepository({
    required this.sleepDate,
    required this.hour1,
    required this.minute1,
    required this.hour2,
    required this.minute2,
    required this.scale,
    required this.description,
    required this.factors
  });
  
  // Fungsi untuk menyimpan SleepDiary dan SleepFactor
  Future<void> createSleepDiary(BuildContext context) async {
    
    // Parsing waktu tidur dan waktu bangun
    String sleepTime = "$hour1:$minute1";
    String wakeupTime= "$hour2:$minute2";

    // Model yang akan di-insert ke firebase
    final newSleepDiary = SleepDiaryModel(
      userId: FirebaseAuth.instance.currentUser!.uid,
      sleepDate: sleepDate, 
      sleepTime: sleepTime, 
      wakeupTime: wakeupTime, 
      scale: scale, 
      description: description
    );

    try {
      // Insert SleepDiary ke Firebase
      // Kita simpan ke variabel supaya bisa kita ambil ID nya
      final response = await FirebaseFirestore.instance.collection("sleepDiaries").add(newSleepDiary.toJson());
      
      // Mengambil ID sleep diary yang baru di-insert
      String newId = response.id;

      // Insert faktor-faktor
      for(var factor in factors){
        
        // Pembuatan model sleep factor yang akan di-insert
        Map<String, dynamic> sleepFactors = {
          'sleepDiaryId': newId,
          'factorId': factor
        };

        // Insert sleep factor ke firebase
        await FirebaseFirestore.instance.collection('sleepFactors').add(sleepFactors);

      }

      // Redirect ke Home Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage()
        )
      );
    } 
    catch (error) {
      throw 'Error $error';
    }
  }
}
