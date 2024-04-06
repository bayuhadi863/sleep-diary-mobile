import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/profile/user_controller.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary/get_sleep_diary.dart';
import 'package:sleep_diary_mobile/screens/profile/profile.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static DateTime today = DateTime.now();
  static GetSleepDiaryController sleepDiaryController =
      Get.put(GetSleepDiaryController());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  // final sleepDiaryController = Get.put(GetSleepDiaryController());
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      DateTime today = DateTime.now();
      int stringDay = int.parse(DateFormat('yyyyMMdd').format(day));
      int stringToday = int.parse(DateFormat('yyyyMMdd').format(today));

      if (stringDay > stringToday) {
        TLoaders.errorSnackBar(
            title: 'Gagal!',
            message: 'Anda tidak bisa memilih hari yang belum tiba.');
        return;
      }
      HomePage.today = day;
      HomePage.sleepDiaryController.fetchSleepDiaryData(day);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: HomePage.today,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
      cancelText: 'Cancel',
      confirmText: 'OK',
      helpText: 'Select date',
    );
    if (picked != null && picked != HomePage.today) {
      setState(() {
        HomePage.today = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // _greetings(),
            const SizedBox(
              height: 10,
            ),
            _header(),
            content(),
            _card(),
          ],
        )));
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: _selectDate,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Catat Tidurmu!\n',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: DateFormat.yMMMMEEEEd().format(HomePage.today),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(),
              color: Colors.white,
            ),
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, HomePage.today),
              focusedDay: HomePage.today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ),
          // const SizedBox(
          //   height: 20,
          //   child: const Text('Pilih'),
          // ),
        ],
      ),
    );
  }

  Widget _header() {
    final controller = Get.put(UserController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(8, 10, 35, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/ikon.png',
              // width: 300,
              // height: 300,
              fit: BoxFit.cover,
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: const Text(
          //     "Unlock Better Sleep",
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    "Halo, ${controller.user.value.name.split(' ')[0]}!",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Tentukan Prioritas Tidurmu",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _card() {
    // final controller = Get.put(GetSleepDiaryController());
    // controller.date = HomePage.today;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(38, 38, 66, 1),
      ),
      child: Obx(
        () => Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        DateFormat.yMMMMEEEEd().format(HomePage.today),
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            HomePage.sleepDiaryController.sleepDiary.value.sleepDate == ''
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 5),
                    child: Text(
                      'Tidak ada data tidur hari ini',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                durationBadge(calculateTimeDifference(
                                    HomePage.sleepDiaryController.sleepDiary
                                        .value.wakeupTime,
                                    HomePage.sleepDiaryController.sleepDiary
                                        .value.sleepTime)),
                                const SizedBox(width: 4),
                                Text(
                                  '${HomePage.sleepDiaryController.sleepDiary.value.sleepTime} - ${HomePage.sleepDiaryController.sleepDiary.value.wakeupTime}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: factorIcons(HomePage
                                .sleepDiaryController.sleepDiary.value.factors),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.13),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            displayImageScale(HomePage
                                .sleepDiaryController.sleepDiary.value.scale),
                            const SizedBox(width: 10),
                            Expanded(
                              child: displaySleepText(HomePage
                                  .sleepDiaryController.sleepDiary.value.scale),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Padding _greetings() {
    final controller = Get.put(UserController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Halo, ${controller.user.value.name.split(' ')[0]}!",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
          // IconButton(
          //   onPressed: () {},
          //   icon: PopUpMenu(
          //     menuList: [
          //       PopupMenuItem(
          //         child: const ListTile(
          //           leading: Icon(
          //             CupertinoIcons.person,
          //           ),
          //           title: Text("My Profile"),
          //         ),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const ProfilePage()),
          //           );
          //         },
          //       ),
          //       const PopupMenuDivider(),
          //       PopupMenuItem(
          //         child: ListTile(
          //           leading: const Icon(Icons.logout),
          //           title: TextButton(
          //             onPressed: () =>
          //                 AuthenticationRepository.instance.logout(),
          //             child: const Text(
          //               'Logout',
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class PopUpMenu extends StatelessWidget {
  final List<PopupMenuEntry<dynamic>> menuList;
  final Widget? icon;
  const PopUpMenu({super.key, required this.menuList, this.icon});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: const Icon(
        CupertinoIcons.person,
        color: Colors.white,
      ),
    );
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

  return hours;
}

Widget displayImageScale(int scale) {
  if (scale == 1) {
    return Image.asset(
      'assets/images/skala1.png',
      width: 40,
      height: 40,
    );
  } else if (scale == 2) {
    return Image.asset(
      'assets/images/skala2.png',
      width: 40,
      height: 40,
    );
  } else if (scale == 3) {
    return Image.asset(
      'assets/images/skala3.png',
      width: 40,
      height: 40,
    );
  } else if (scale == 4) {
    return Image.asset(
      'assets/images/skala4.png',
      width: 40,
      height: 40,
    );
  } else {
    return Image.asset(
      'assets/images/skala5.png',
      width: 40,
      height: 40,
    );
  }
}

Widget displaySleepText(int scale) {
  if (scale == 1) {
    return const Text(
      'Tidurmu sangat buruk, Perbaiki!',
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  } else if (scale == 2) {
    return const Text(
      'Tidurmu buruk, Perbaiki!',
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  } else if (scale == 3) {
    return const Text(
      'Tidurmu cukup, Tingkatkan!',
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  } else if (scale == 4) {
    return const Text(
      'Tidurmu baik, Tingkatkan!',
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  } else {
    return const Text(
      'Tidurmu sempurna, Pertahankan!',
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

Widget factorIcons(List<String> factors) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: factors.map((factor) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Image.asset(
          'assets/images/$factor.png',
          width: 25,
          height: 25,
        ),
      );
    }).toList(),
  );
}

Widget durationBadge(int duration) {
  Color badgeColor;

  if ((duration < 7 && duration >= 6) || (duration > 9 && duration <= 10)) {
    badgeColor = Colors.yellow[600]!.withOpacity(0.7);
  } else if (duration >= 7 && duration <= 9) {
    badgeColor = Colors.green.withOpacity(0.7);
  } else {
    badgeColor = Colors.red.withOpacity(0.7);
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: badgeColor,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Text(
      '$duration Jam',
      style: const TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
