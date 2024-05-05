import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary/get_sleep_diary_detail_controller.dart';

class DetailCard extends StatefulWidget {
  final String sleepDiaryId;
  final String date;

  const DetailCard({super.key, required this.sleepDiaryId, required this.date});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  final getSleepDiaryDetail = Get.put(GetSleepDiaryDetailController());

  @override
  void initState() {
    super.initState();
    getSleepDiaryDetail.fetchSleepDiaryDetail(widget.sleepDiaryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            widget.date,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(38, 38, 66, 1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 14),
                          child: Obx(
                            () =>
                                // getSleepDiaryDetail.isLoading.value
                                //     ? CircularProgressIndicator()
                                //     :
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.timer_sharp,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${getSleepDiaryDetail.sleepDiary.value.sleepTime} - ${getSleepDiaryDetail.sleepDiary.value.wakeupTime}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                durationBadge(
                                  calculateTimeDifference(
                                      getSleepDiaryDetail
                                          .sleepDiary.value.wakeupTime,
                                      getSleepDiaryDetail
                                          .sleepDiary.value.sleepTime),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 280,
                                  child: Text(
                                    getDurationText(
                                      calculateTimeDifference(
                                          getSleepDiaryDetail
                                              .sleepDiary.value.wakeupTime,
                                          getSleepDiaryDetail
                                              .sleepDiary.value.sleepTime),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(38, 38, 66, 1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Kualitas Tidur",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            displayImageScale(
                                getSleepDiaryDetail.sleepDiary.value.scale),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 280,
                              child: Text(
                                getSleepScaleText(
                                    getSleepDiaryDetail.sleepDiary.value.scale),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(38, 38, 66, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Faktor yang memengaruhi",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          getSleepDiaryDetail
                                  .sleepDiary.value.factors.isNotEmpty
                              ? factorIcons(
                                  getSleepDiaryDetail.sleepDiary.value.factors)
                              : Text(
                                  'Tidak ada faktor yang memengaruhi',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                    fontStyle: FontStyle
                                        .italic, // Mengatur teks menjadi miring
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(38, 38, 66, 1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        const Text(
                          "Deskripsi Tidur",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Obx(
                            () => Text(
                              getSleepDiaryDetail.sleepDiary.value.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

Widget durationBadge(TimeDifference duration) {
  Color badgeColor;

  if ((duration.hour < 7 && duration.hour >= 6) ||
      (duration.hour > 9 && duration.hour <= 10)) {
    badgeColor = Colors.yellow[600]!.withOpacity(0.7);
  } else if (duration.hour >= 7 && duration.hour <= 9) {
    badgeColor = Colors.green.withOpacity(0.7);
  } else {
    badgeColor = Colors.red.withOpacity(0.7);
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: badgeColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      duration.hour > 0 ? '${duration.hour} Jam' : '${duration.minute} Menit',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

String getDurationText(TimeDifference duration) {
  if (duration.hour < 7 && duration.hour >= 6) {
    return 'Durasi tidurmu masih kurang dari durasi tidur yang disarankan, cobalah tidur sedikit lebih lama!';
  } else if (duration.hour > 9 && duration.hour <= 10) {
    return 'Durasi tidurmu sedikit lebih lama dari durasi tidur yang disarankan, cobalah bangun sedikit lebih awal!';
  } else if (duration.hour >= 7 && duration.hour <= 9) {
    return 'Durasi tidurmu sudah sesuai durasi tidur yang disarankan, pertahankan!';
  } else if (duration.hour < 6) {
    return 'Durasi tidurmu sangat kurang dari durasi tidur yang disarankan, cobalah tidur lebih lama!';
  } else if (duration.hour > 10) {
    return 'Durasi tidurmu sangat melebihi durasi tidur yang disarankan, cobalah bangun lebih awal!';
  } else {
    return 'Durasi tidurmu tidak valid, periksa kembali!';
  }
}

Widget displayImageScale(int scale) {
  if (scale == 1) {
    return Image.asset(
      'assets/images/skalabulan1.png',
      width: 100,
      height: 100,
    );
  } else if (scale == 2) {
    return Image.asset(
      'assets/images/skalabulan2.png',
      width: 100,
      height: 100,
    );
  } else if (scale == 3) {
    return Image.asset(
      'assets/images/skalabulan3.png',
      width: 100,
      height: 100,
    );
  } else if (scale == 4) {
    return Image.asset(
      'assets/images/skalabulan4.png',
      width: 100,
      height: 100,
    );
  } else {
    return Image.asset(
      'assets/images/skalabulan5.png',
      width: 100,
      height: 100,
    );
  }
}

String getSleepScaleText(int scale) {
  if (scale == 1) {
    return 'Kualitas tidurmu sangat buruk, Perbaiki!';
  } else if (scale == 2) {
    return 'Kualitas tidurmu buruk, Perbaiki!';
  } else if (scale == 3) {
    return 'Kualitas tidurmu cukup, Tingkatkan!';
  } else if (scale == 4) {
    return 'Kualitas tidurmu baik, Tingkatkan!';
  } else {
    return 'Kualitas tidurmu sempurna, Pertahankan!';
  }
}

Row factorIcons(List<String> factors) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: factors.map((factor) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/$factor.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              factor,
              style: const TextStyle(color: Colors.white, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }).toList(),
  );
}
