import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/profile/user_controller.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary/get_sleep_diary.dart';
import 'package:sleep_diary_mobile/widgets/timepicker_theme.dart';
import 'package:sleep_diary_mobile/repositories/reminder/reminder_repository.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/get_sleep_diary.dart';
import 'package:sleep_diary_mobile/screens/profile/profile.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/edit_sleep_page.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/detail_card.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

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
  late TimeOfDay reminderTime = const TimeOfDay(hour: 0, minute: 0);
  late bool active = false;
  final reminderRepository = ReminderRepository();
  List<String> sleepDiaryDates = [];

  @override
  void initState() {
    super.initState();

    getAllDates();

    initializeReminderNotification();

    reminderRepository.getReminderTime().then((time) {
      setState(() {
        reminderTime = time;
      });
    });

    reminderRepository.getReminderIsActive().then((isActive) {
      setState(() {
        active = isActive;
        if (isActive) {
          reminderRepository.onReminderNotification(reminderTime);
        } else {
          reminderRepository.offReminderNotification();
        }
      });
    });
  }

  getAllDates() async {
    final getSleepDiaryRepository = Get.put(GetSleepDiaryRepository());
    try {
      final dates = await getSleepDiaryRepository.getSleepDiaryDates();
      setState(() {
        sleepDiaryDates = dates;
      });
      print('sleepDiaryDates: $sleepDiaryDates');
    } catch (e) {
      setState(() {
        sleepDiaryDates = [];
      });
    }
  }

  Future<void> initializeReminderNotification() async {
    await reminderRepository.initializeReminder();
  }

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
      lastDate: DateTime.now(),
      cancelText: 'Cancel',
      confirmText: 'OK',
      helpText: 'Select date',
    );

    if (picked == null) return;
    if (picked == HomePage.today) return;
    if (picked.isAfter(DateTime.now())) {
      TLoaders.errorSnackBar(
          title: 'Gagal!',
          message: 'Anda tidak bisa memilih hari yang belum tiba.');
      return;
    }

    setState(() {
      HomePage.today = picked;
      HomePage.sleepDiaryController.fetchSleepDiaryData(picked);
    });
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

            _header(),
            const Text(
              'Catat Tidurmu!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            calendar(),
            // content(),
            const SizedBox(
              height: 12,
            ),
            _textReminder(),
            const SizedBox(
              height: 8,
            ),
            _reminder(context),
            const SizedBox(
              height: 13,
            ),
            _card(context),
            const SizedBox(
              height: 80,
            ),
          ],
        )));
  }

  Widget calendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      constraints: const BoxConstraints(maxHeight: 360),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(38, 38, 66, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() {
            DateTime today = DateTime.now();
            int stringDay = int.parse(DateFormat('yyyyMMdd').format(date));
            int stringToday = int.parse(DateFormat('yyyyMMdd').format(today));

            if (stringDay > stringToday) {
              TLoaders.errorSnackBar(
                  title: 'Gagal!',
                  message: 'Anda tidak bisa memilih hari yang belum tiba.');
              return;
            }
            HomePage.today = date;
            HomePage.sleepDiaryController.fetchSleepDiaryData(date);
          });
        },
        // thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        customDayBuilder: (
          /// you can provide your own build function to make custom day containers
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.

          // Example: every 15th of month, we have a flight, we can place an icon in the container like that:

          // chech if day have sleep diary data

          // check if day in sleepDiaryDates
          String formattedDay = DateFormat('EEEE, MMMM d, y').format(day);

          if (sleepDiaryDates.contains(formattedDay.toString())) {
            return Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(
                  color: Colors.green[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  //     .bold,
                ),
              ),
            );
          } else {
            return null;
          }
        },
        weekFormat: false,
        // markedDatesMap: _markedDateMap,
        height: 352.0,
        selectedDateTime: HomePage.today,
        daysHaveCircularBorder: true,
        thisMonthDayBorderColor: Colors.transparent,
        headerMargin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        daysTextStyle: const TextStyle(color: Colors.white),
        weekdayTextStyle: const TextStyle(color: Colors.white),
        todayButtonColor: Colors.transparent,
        todayTextStyle: const TextStyle(color: Colors.white),
        todayBorderColor: const Color(0xFF5C6AC0),
        nextDaysTextStyle: TextStyle(color: Colors.grey[600]),
        prevDaysTextStyle: TextStyle(color: Colors.grey[600]),
        weekendTextStyle: const TextStyle(color: Colors.white),
        selectedDayButtonColor: const Color(0xFF5C6AC0),
        selectedDayBorderColor: const Color(0xFF5C6AC0),
        headerTitleTouchable: true,
        onHeaderTitlePressed: () => _selectDate(),
        headerTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        pageScrollPhysics: const NeverScrollableScrollPhysics(),
        iconColor: Colors.white,
        maxSelectedDate: DateTime.now(),
        inactiveDaysTextStyle: TextStyle(color: Colors.grey[700]),
        isScrollable: false,
        showOnlyCurrentMonthDate: true,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  // Widget content() {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Column(
  //       children: [
  //         GestureDetector(
  //           onTap: _selectDate,
  //           child: RichText(
  //             textAlign: TextAlign.center,
  //             text: TextSpan(
  //               children: <TextSpan>[
  //                 const TextSpan(
  //                   text: 'Catat Tidurmu!\n',
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 26,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //                 TextSpan(
  //                   text: DateFormat.yMMMMEEEEd('id_ID').format(HomePage.today),
  //                   style: const TextStyle(color: Colors.white, fontSize: 14),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(15.0),
  //             border: Border.all(),
  //             color: Colors.white,
  //           ),
  //           child: TableCalendar(
  //             locale: "en_US",
  //             rowHeight: 43,
  //             headerStyle: const HeaderStyle(
  //               formatButtonVisible: false,
  //               titleCentered: true,
  //             ),
  //             availableGestures: AvailableGestures.all,
  //             selectedDayPredicate: (day) => isSameDay(day, HomePage.today),
  //             focusedDay: HomePage.today,
  //             firstDay: DateTime.utc(2010, 10, 16),
  //             lastDay: DateTime.utc(2030, 3, 14),
  //             onDaySelected: _onDaySelected,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
              fit: BoxFit.cover,
            ),
          ),
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

  void _timePicker() {
    showTimePicker(
      context: context,
      cancelText: 'Batal',
      confirmText: 'Simpan',
      initialTime:
          TimeOfDay(hour: reminderTime.hour, minute: reminderTime.minute),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            timePickerTheme: _timePickerTheme,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  // backgroundColor: Colors.amber,
                  // iconColor: Colors.white,
                  ),
            ),
          ),
          child: child!,
        );
      },
    ).then((TimeOfDay? value) {
      if (value != null) {
        setState(() {
          reminderTime = value;
          reminderRepository.updateReminderTime(value);
          if (active) {
            reminderRepository.onReminderNotification(value);
          }
        });
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    }).catchError((error) {
      print('Terjadi kesalahan: $error');
    });
  }

  Widget _reminder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(38, 38, 66, 1),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: GestureDetector(
              onTap: () {
                _timePicker();
              },
              child: Text(
                '${reminderTime.hour.toString().padLeft(2, '0')} : ${reminderTime.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(38, 38, 66, 1),
                  borderRadius: BorderRadius.circular(12)),
              // margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Switch(
                value: active,
                onChanged: ((bool value) {
                  setState(() {
                    active = value;
                    reminderRepository.updateReminderIsActive(value);
                    if (value) {
                      reminderRepository.onReminderNotification(reminderTime);
                    } else {
                      reminderRepository.offReminderNotification();
                    }
                  });
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textReminder() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Reminder Waktu Tidur',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Container _card(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMMEEEEd('id_ID').format(HomePage.today),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailCard()));
                      },
                      icon: const Icon(
                        Icons.remove_red_eye_sharp,
                        size: 16,
                      ),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditSleepPage()));
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 16,
                      ),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromRGBO(38, 38, 66, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/deletepopup.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Apakah Anda yakin ingin menghapus data?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 1.0, color: Colors.white),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Batal",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 215, 56, 45),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Hapus",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 16,
                      ),
                      color: Colors.white,
                    ),
                  ],
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
                          Row(
                            children: [
                              durationBadge(calculateTimeDifference(
                                  HomePage.sleepDiaryController.sleepDiary.value
                                      .wakeupTime,
                                  HomePage.sleepDiaryController.sleepDiary.value
                                      .sleepTime)),
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
                          Expanded(
                            child: factorIcons(HomePage
                                .sleepDiaryController.sleepDiary.value.factors),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
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

final _timePickerTheme = TimePickerThemeData(
  //tombol cancel
  cancelButtonStyle: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  //tombol simpan
  confirmButtonStyle: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color(0xFF5C6AC0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  backgroundColor: const Color.fromRGBO(38, 38, 66, 1),
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  dayPeriodBorderSide: const BorderSide(color: Colors.orange, width: 4),
  dayPeriodColor: Colors.blueGrey.shade600,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  dayPeriodTextColor: Colors.grey[100],
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? const Color.fromRGBO(38, 38, 66, 1)
          : const Color.fromRGBO(38, 38, 66, 1)),
  hourMinuteTextColor: MaterialStateColor.resolveWith(
    (states) => states.contains(MaterialState.selected)
        ? Colors.grey.shade200
        : Colors.grey.shade200,
  ),
  dialHandColor: const Color(0xFF5C6AC0),
  dialBackgroundColor: const Color.fromRGBO(38, 38, 66, 1),
  hourMinuteTextStyle: const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  dayPeriodTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
  helpTextStyle: const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? Colors.white : Colors.white),
  entryModeIconColor: const Color(0xFF5C6AC0),
);

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

Widget displayImageScale(int scale) {
  if (scale == 1) {
    return Image.asset(
      'assets/images/skalabulan1.png',
      width: 40,
      height: 40,
    );
  } else if (scale == 2) {
    return Image.asset(
      'assets/images/skalabulan2.png',
      width: 40,
      height: 40,
    );
  } else if (scale == 3) {
    return Image.asset(
      'assets/images/skalabulan3.png',
      width: 40,
      height: 40,
    );
  } else if (scale == 4) {
    return Image.asset(
      'assets/images/skalabulan4.png',
      width: 40,
      height: 40,
    );
  } else {
    return Image.asset(
      'assets/images/skalabulan5.png',
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
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: badgeColor,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Text(
      duration.hour > 0 ? '${duration.hour} Jam' : '${duration.minute} Menit',
      style: const TextStyle(
        fontSize: 11,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
