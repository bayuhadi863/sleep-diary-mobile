import 'package:flutter/material.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/get_sleep_diary.dart';

class MonthlySummary {
  Future<List<int>> getMonthlyScale(int month, int year) async {
    List<int> monthlyScales = [0];

    for (int i = 1; i < DateUtils.getDaysInMonth(year, month); i++) {
      monthlyScales.add(0);
    }

    for (int i = 0; i < DateUtils.getDaysInMonth(year, month); i++) {
      SleepDiaryModel lastWeekSleepDiary = await GetSleepDiaryRepository()
          .fetchSleepDiary(DateTime(year, month, i + 1));
      monthlyScales[i] = lastWeekSleepDiary.scale;
    }

    // print("Jumlah Skala : ${monthlyScales.length}");
    // print("Skala ${month} ${year}: ${monthlyScales}");

    return monthlyScales;
  }

  Future<double> getMonthlyScaleAverage(int month, int year) async {
    List<int> monthlyScales = await getMonthlyScale(month, year);

    double amount = 0;
    double sum = 0;

    for (var i = 0; i < DateUtils.getDaysInMonth(year, month); i++) {
      if (monthlyScales[i] != 0) {
        sum += monthlyScales[i];
        amount++;
      }
    }

    if (amount == 0) {
      // print("Rata-Rata Skala ${month} ${year}: 0");
      return 0;
    }

    // print("Rata-Rata Skala ${month} ${year}: ${sum / amount}");

    return sum / amount;
  }

  Future<Map<String, int>> getMonthlyFactors(int month, int year) async {
    Map<String, int> monthlyFactors = {
      "lingkungan": 0,
      "stress": 0,
      "sakit": 0,
      "gelisah": 0,
      "terbangun": 0
    };

    for (var i = 0; i < DateUtils.getDaysInMonth(year, month); i++) {
      SleepDiaryModel monthlySleepDiary = await GetSleepDiaryRepository()
          .fetchSleepDiary(DateTime(year, month, i + 1));
      for (var j = 0; j < monthlySleepDiary.factors.length; j++) {
        monthlyFactors[monthlySleepDiary.factors[j]] =
            monthlyFactors[monthlySleepDiary.factors[j]]! + 1;
      }
    }

    // print("Faktor $month $year: $monthlyFactors");

    return monthlyFactors;
  }

  Future<String> getMonthlySleepTimeAverage(int month, int year) async {
    int amount = 0;
    int sumSleepTime = 0;

    for (var i = 0; i < DateUtils.getDaysInMonth(year, month); i++) {
      SleepDiaryModel monthlySleepDiary = await GetSleepDiaryRepository()
          .fetchSleepDiary(DateTime(year, month, i + 1));
      if (monthlySleepDiary.scale != 0) {
        amount++;
        TimeDifference sleepTime = calculateTimeDifference(
            monthlySleepDiary.wakeupTime, monthlySleepDiary.sleepTime);
        sumSleepTime += 60 * sleepTime.hour + sleepTime.minute;
      }
    }

    if (amount == 0) {
      // print("0 Jam, 0 Menit");
      return "0 Jam, 0 Menit";
    }

    int averageSleepTime = (sumSleepTime / amount).round();

    // print(
    //     "${(averageSleepTime / 60).round()} Jam, ${averageSleepTime % 60} Menit");

    return "${(averageSleepTime / 60).round()} Jam, ${averageSleepTime % 60} Menit";
  }
}

class TimeDifference {
  final int hour;
  final int minute;

  TimeDifference({required this.hour, required this.minute});
}

TimeDifference calculateTimeDifference(String wakeupTime, String sleepTime) {
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

  return TimeDifference(hour: hours, minute: minutes);
}
