import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/profile/user_controller.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary/get_sleep_diary.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/sleep_diary_repository.dart';
import 'package:sleep_diary_mobile/tracker_service.dart';
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
  // DateTime selectedDate = DateTime.now();
  DateTime selectedDate = DateTime(2023, 1, 1);
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
      firstDate: DateTime(2023, 1, 1),
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
      // set calendar changed to selected date

      HomePage.today = picked;
      // selectedDate = picked;
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
            Text(
              'Catat Tidurmu!',
              style: GoogleFonts.poppins(
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
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Catatan Tidur',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
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
      constraints: const BoxConstraints(maxHeight: 392),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(38, 38, 66, 1),
        // color: Colors.white,
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

            // selectedDate = date;
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
          String formattedDay = DateFormat('EEEE, MMMM d, y').format(day);

          if (sleepDiaryDates.contains(formattedDay.toString())) {
            return Center(
              child: Text(
                day.day.toString(),
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFD670),
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
        // onCalendarChanged: (DateTime date) {
        //   this.setState(() {
        //     selectedDate = date;
        //     _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        //   });
        // },
        onDayLongPressed: (DateTime date) {
          print('long pressed date $date');
        },
        // onDayLongPressed: (day) {
        //   print('long pressed $day');
        // },
        pageSnapping: true,
        shouldShowTransform: true,
        targetDateTime: HomePage.today,
        // markedDatesMap: _markedDateMap,
        height: 352.0,
        selectedDateTime: HomePage.today,
        // selectedDateTime: DateTime(2023, 1, 1),
        daysHaveCircularBorder: true,
        thisMonthDayBorderColor: Colors.transparent,
        headerMargin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        daysTextStyle: GoogleFonts.poppins(color: Colors.white),

        weekdayTextStyle: GoogleFonts.poppins(color: Colors.white),
        todayButtonColor: Colors.transparent,
        todayTextStyle: GoogleFonts.poppins(color: Colors.white),
        todayBorderColor: const Color(0xFF5C6AC0),
        nextDaysTextStyle: GoogleFonts.poppins(color: Colors.grey[600]),
        prevDaysTextStyle: GoogleFonts.poppins(color: Colors.grey[600]),
        weekendTextStyle: GoogleFonts.poppins(color: Colors.white),
        selectedDayButtonColor: const Color(0xFF5C6AC0),
        selectedDayBorderColor: const Color(0xFF5C6AC0),
        headerTitleTouchable: true,
        onHeaderTitlePressed: () => _selectDate(),
        headerTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        // pageScrollPhysics: const NeverScrollableScrollPhysics(),
        iconColor: Colors.white,
        maxSelectedDate: DateTime.now(),
        minSelectedDate: DateTime(2023, 1, 1),
        inactiveDaysTextStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        inactiveWeekendTextStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        // isScrollable: true,
        showOnlyCurrentMonthDate: true,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  Widget _header() {
    final controller = Get.put(UserController());
    return Stack(
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(38, 38, 66, 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        "Halo, ${controller.user.value.name.split(' ')[0]}!",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Optimalkan Waktu Tidurmu",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: Image.asset(
              //     'assets/images/1.png',
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ],
          ),
        ),
        Positioned(
          // left: 260,
          left: MediaQuery.of(context).size.width * 0.59,
          top: 20,
          child: Image.asset(
            'assets/images/1.png',
            width: 138,
            height: 138,
          ),
        ),
      ],
    );
  }

  void _timePicker() {
    showTimePicker(
      context: context,
      cancelText: 'Batal',
      confirmText: 'Simpan',
      helpText: 'Pilih Waktu Reminder',
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(38, 38, 66, 1),
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _timePicker();
                  },
                  child: Text(
                    '${reminderTime.hour.toString().padLeft(2, '0')} : ${reminderTime.minute.toString().padLeft(2, '0')}',
                    style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: active ? Colors.white : Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(38, 38, 66, 1),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      active ? 'Reminder' : 'Aktifkan',
                      style: GoogleFonts.poppins(
                        color: active ? Colors.white : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      active ? 'Aktif' : 'Reminder',
                      style: GoogleFonts.poppins(
                        color: active ? Colors.white : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Switch(
                  value: active,
                  onChanged: ((bool value) async {
                    if(value) {
                      await (TrackerService()).track("enable-reminder", withDeviceInfo: true);
                    }
                    else{
                      await (TrackerService()).track("disable-reminder", withDeviceInfo: true);
                    }
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
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _textReminder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Reminder Waktu Tidur',
            style: GoogleFonts.poppins(
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
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                HomePage.sleepDiaryController.sleepDiary.value.sleepDate != ''
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailCard(
                                    sleepDiaryId: HomePage.sleepDiaryController
                                        .sleepDiary.value.id!,
                                    date: DateFormat.yMMMMEEEEd('id_ID')
                                        .format(HomePage.today),
                                  ),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.remove_red_eye_sharp,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditSleepPage(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          GestureDetector(
                            onTap: () {
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
                                        Text(
                                          "Apakah Anda yakin ingin menghapus data?",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.white),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Batal",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
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
                                                SleepDiaryRepository
                                                    .deleteSleepDiary();
                                              },
                                              child: Text(
                                                "Hapus",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
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
                            child: const Icon(
                              Icons.delete,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 5),
            HomePage.sleepDiaryController.sleepDiary.value.sleepDate == ''
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 40, horizontal: 5),
                    child: Text(
                      'Tidak ada data tidur hari ini',
                      style: GoogleFonts.poppins(
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
                                style: GoogleFonts.poppins(
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
                            horizontal: 12, vertical: 12),
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
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${getSleepScaleText(HomePage.sleepDiaryController.sleepDiary.value.scale)}${getConjunction(calculateTimeDifference(HomePage.sleepDiaryController.sleepDiary.value.wakeupTime, HomePage.sleepDiaryController.sleepDiary.value.sleepTime), HomePage.sleepDiaryController.sleepDiary.value.scale)}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          getDurationText(
                                            calculateTimeDifference(
                                                HomePage
                                                    .sleepDiaryController
                                                    .sleepDiary
                                                    .value
                                                    .wakeupTime,
                                                HomePage
                                                    .sleepDiaryController
                                                    .sleepDiary
                                                    .value
                                                    .sleepTime),
                                          ),
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
  hourMinuteTextStyle: GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  dayPeriodTextStyle: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
  helpTextStyle: GoogleFonts.poppins(
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

String getConjunction(TimeDifference duration, int scale) {
  bool isDurationGood = false;
  bool isScaleGood = false;

  if (duration.hour >= 7 && duration.hour <= 9) {
    isDurationGood = true;
  }

  if (scale >= 3) {
    isScaleGood = true;
  }

  if ((isDurationGood && isScaleGood) || (!isDurationGood && !isScaleGood)) {
    return ' dan';
  }

  if (isDurationGood && !isScaleGood) {
    return ', tetapi';
  }

  if (!isDurationGood && isScaleGood) {
    return ', namun';
  }

  return 'dan';
}

String getDurationText(TimeDifference duration) {
  if (duration.hour < 7 && duration.hour >= 6) {
    return 'Durasi tidurmu masih kurang dari durasi tidur yang disarankan.';
  } else if (duration.hour > 9 && duration.hour <= 10) {
    return 'Durasi tidurmu sedikit melebihi durasi tidur yang disarankan.';
  } else if (duration.hour >= 7 && duration.hour <= 9) {
    return 'Durasi tidurmu sudah sesuai dengan durasi tidur yang disarankan.';
  } else if (duration.hour < 6) {
    return 'Durasi tidurmu sangat kurang dari durasi tidur yang disarankan.';
  } else if (duration.hour > 10) {
    return 'Durasi tidurmu sangat melebihi durasi tidur yang disarankan.';
  } else {
    return 'Durasi tidurmu tidak valid, periksa kembali!';
  }
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

String getSleepScaleText(int scale) {
  if (scale == 1) {
    return 'Kualitas tidurmu sangat buruk';
  } else if (scale == 2) {
    return 'Kualitas tidurmu buruk';
  } else if (scale == 3) {
    return 'Kualitas tidurmu cukup';
  } else if (scale == 4) {
    return 'Kualitas tidurmu baik';
  } else {
    return 'Kualitas tidurmu sempurna';
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
      style: GoogleFonts.poppins(
        fontSize: 11,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
