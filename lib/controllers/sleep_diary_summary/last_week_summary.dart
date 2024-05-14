import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/get_sleep_diary.dart';

class LastWeekSummary {
  DateTime today = DateTime.now();
  late int todayInNum = today.weekday % 7;

  late DateTime lastWeekDates = today.subtract(Duration(days: todayInNum + 7));

  Future<List<int>> getLastWeekScale() async {
    // print("Awal Minggu Lalu adalah ${lastWeekDates}");

    List<int> lastWeekScales = [0, 0, 0, 0, 0, 0, 0];

    for (int i = 0; i < 7; i++) {
      SleepDiaryModel lastWeekSleepDiary = await GetSleepDiaryRepository()
          .fetchSleepDiary(lastWeekDates.add(Duration(days: i)));
      lastWeekScales[i] = lastWeekSleepDiary.scale;
    }

    // print("Skala Minggu Lalu: ${lastWeekScales}");

    return lastWeekScales;
  }

  Future<double> getLastWeekScaleAverage() async {
    List<int> lastWeekScales = await getLastWeekScale();

    double amount = 0;
    double sum = 0;

    for (var i = 0; i < 7; i++) {
      if (lastWeekScales[i] != 0) {
        sum += lastWeekScales[i];
        amount++;
      }
    }

    if (amount == 0) {
      // print("Rata-Rata Skala Minggu Lalu: 0");
      return 0;
    }

    // print("Rata-Rata Skala Minggu Lalu: ${sum / amount}");

    return sum / amount;
  }

  Future<Map<String, int>> getLastWeekFactors() async {
    Map<String, int> lastWeekFactors = {
      "lingkungan": 0,
      "stress": 0,
      "sakit": 0,
      "gelisah": 0,
      "terbangun": 0
    };

    for (var i = 0; i < 7; i++) {
      SleepDiaryModel lastWeekSleepDiary = await GetSleepDiaryRepository()
          .fetchSleepDiary(lastWeekDates.add(Duration(days: i)));
      for (var j = 0; j < lastWeekSleepDiary.factors.length; j++) {
        lastWeekFactors[lastWeekSleepDiary.factors[j]] =
            lastWeekFactors[lastWeekSleepDiary.factors[j]]! + 1;
      }
    }

    // print("Faktor Minggu Lalu: ${lastWeekFactors}");

    return lastWeekFactors;
  }

  Future<String> getLastWeekSleepTimeAverage() async {
    int amount = 0;
    int sumSleepTime = 0;

    for (var i = 0; i < 7; i++) {
      SleepDiaryModel lastWeekSleepDiary = await GetSleepDiaryRepository()
          .fetchSleepDiary(lastWeekDates.add(Duration(days: i)));
      if (lastWeekSleepDiary.scale != 0) {
        amount++;
        TimeDifference sleepTime = calculateTimeDifference(
            lastWeekSleepDiary.wakeupTime, lastWeekSleepDiary.sleepTime);
        sumSleepTime += 60 * sleepTime.hour + sleepTime.minute;
        // print("${sleepTime.hour} :  ${sleepTime.minute}");
      }
    }

    if (amount == 0) {
      // print("0 Jam, 0 Menit");
      return "0 Jam, 0 Menit";
    }

    int averageSleepTime = (sumSleepTime / amount).round();

    // print("Sum sleep time minute: ${sumSleepTime}");

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
