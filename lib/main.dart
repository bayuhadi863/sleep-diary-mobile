import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_diary_mobile/widgets/timepicker_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/repositories/reminder/reminder_repository.dart';
import 'package:sleep_diary_mobile/screens/profile/profile.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/faq.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/add_sleep_page.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/home_page.dart';
import 'package:sleep_diary_mobile/firebase_options.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/statistik.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init();

  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _timePickerTheme;
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        timePickerTheme: _timePickerTheme,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(38, 38, 66, 1)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int index = 0;
  static const pages = [
    HomePage(),
    StatistikPage(),
    AddSleepPage(),
    FaqPage(),
    ProfilePage(),
  ];

  int selectedIndex = 0;

  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
      body: pages[selectedIndex],
      extendBody: true,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
          onPressed: () async {
            if (disabled) {
              return;
            }
            if (HomePage.sleepDiaryController.sleepDiary.value.sleepDate !=
                '') {
              setState(() {
                disabled = true;
              });

              TLoaders.errorSnackBar(
                  title: 'Gagal',
                  message: 'Anda sudah mencatat tidur hari ini.');

              await Future.delayed(const Duration(seconds: 3));

              setState(() {
                disabled = false;
              });

              return;
            }

            setState(() {
              selectedIndex = 2;
            });
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          backgroundColor: const Color(0xFF5C6AC0),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 60,
        color: const Color.fromRGBO(38, 38, 66, 1),
        // shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home_filled,
                    color: selectedIndex == 0
                        ? const Color(0xFF5C6AC0)
                        : Colors.white,
                  ),
                  onPressed: () {
                    if (selectedIndex == 2) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => confirmDialog(
                          context,
                          () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                        ),
                      );

                      return;
                    }
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.chart_bar_square_fill,
                    color: selectedIndex == 1
                        ? const Color(0xFF5C6AC0)
                        : Colors.white,
                  ),
                  onPressed: () {
                    if (selectedIndex == 2) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => confirmDialog(
                          context,
                          () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                        ),
                      );

                      return;
                    }
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.question_square_fill,
                    color: selectedIndex == 3
                        ? const Color(0xFF5C6AC0)
                        : Colors.white,
                  ),
                  onPressed: () {
                    if (selectedIndex == 2) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => confirmDialog(
                          context,
                          () {
                            setState(() {
                              selectedIndex = 3;
                            });
                          },
                        ),
                      );

                      return;
                    }
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.person_fill,
                    color: selectedIndex == 4
                        ? const Color(0xFF5C6AC0)
                        : Colors.white,
                  ),
                  onPressed: () {
                    if (selectedIndex == 2) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => confirmDialog(
                          context,
                          () {
                            setState(() {
                              selectedIndex = 4;
                            });
                          },
                        ),
                      );

                      return;
                    }
                    setState(() {
                      selectedIndex = 4;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
      fillColor: Colors.white,
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
}

Widget confirmDialog(BuildContext context, VoidCallback onConfirm) {
  return AlertDialog(
    backgroundColor: const Color.fromRGBO(38, 38, 66, 1),
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
          "Apakah Anda yakin ingin keluar dari halaman ini? Data yang sudah diisi tidak akan tersimpan.",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1.0, color: Colors.white),
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 215, 56, 45),
                borderRadius: BorderRadius.circular(12)),
            child: TextButton(
              onPressed: () {
                // Panggil fungsi onConfirm yang diterima dari luar
                onConfirm();
                // Tutup dialog setelah pemanggilan fungsi onConfirm
                Navigator.of(context).pop();
              },
              child: const Text(
                "Keluar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
