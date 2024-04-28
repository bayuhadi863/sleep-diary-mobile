import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:sleep_diary_mobile/screens/profile/profile.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/faq.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/add_sleep_page.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/home_page.dart';
import 'package:sleep_diary_mobile/firebase_options.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/statistik.dart';
import 'package:sleep_diary_mobile/widgets/loaders.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init();

  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
  int index = 0;
  final pages = [
    const HomePage(),
    const StatistikPage(),
    const AddSleepPage(),
    const FaqPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: pages[index],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color.fromRGBO(38, 38, 66, 1),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: const Color.fromARGB(255, 255, 255, 255),
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          child: NavigationBar(
            elevation: 0.0,
            height: 60,
            backgroundColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            selectedIndex: index,
            onDestinationSelected: (index) {
              if (index == 2) {
                if (HomePage.sleepDiaryController.sleepDiary.value.sleepDate !=
                    '') {
                  TLoaders.errorSnackBar(
                      title: 'Gagal!',
                      message: 'Anda sudah mencatat tidur pada hari tersebut.');
                  return;
                }
              }

              setState(() => this.index = index);
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home,
                    color: index == 0
                        ? const Color.fromRGBO(38, 38, 66, 1)
                        : Colors.white),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.bar_chart_rounded,
                    color: index == 1
                        ? const Color.fromRGBO(38, 38, 66, 1)
                        : Colors.white),
                label: 'Statistik',
              ),
              NavigationDestination(
                icon: Icon(Icons.add,
                    color: index == 2
                        ? const Color.fromRGBO(38, 38, 66, 1)
                        : Colors.white),
                label: 'Add',
              ),
              NavigationDestination(
                icon: Icon(Icons.live_help_rounded,
                    color: index == 3
                        ? const Color.fromRGBO(38, 38, 66, 1)
                        : Colors.white),
                label: 'FAQ',
              ),
              NavigationDestination(
                icon: Icon(Icons.person,
                    color: index == 4
                        ? const Color.fromRGBO(38, 38, 66, 1)
                        : Colors.white),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
