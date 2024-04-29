import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  // int index = 0;
  static const pages = [
    HomePage(),
    StatistikPage(),
    AddSleepPage(),
    FaqPage(),
    ProfilePage(),
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    // return Scaffold(
    //   body: pages[selectedIndex],
    //   bottomNavigationBar: PersistentTabView(
    //     context,
    //     controller: controller,
    //     screens: _buildScreens(),
    //     items: _navBarsItems(context),
    //     confineInSafeArea: true,
    //     backgroundColor: const Color.fromRGBO(38, 38, 66, 1),
    //     handleAndroidBackButtonPress: true,
    //     resizeToAvoidBottomInset: true,
    //     stateManagement: true,
    //     hideNavigationBarWhenKeyboardShows: true,
    //     decoration: const NavBarDecoration(
    //       borderRadius: BorderRadius.vertical(
    //         top: Radius.circular(10),
    //       ),
    //       colorBehindNavBar: Colors.white,
    //     ),
    //     popAllScreensOnTapOfSelectedTab: true,
    //     itemAnimationProperties: const ItemAnimationProperties(
    //       duration: Duration(milliseconds: 200),
    //       curve: Curves.ease,
    //     ),
    //     screenTransitionAnimation: const ScreenTransitionAnimation(
    //       animateTabTransition: true,
    //       curve: Curves.ease,
    //       duration: Duration(milliseconds: 200),
    //     ),
    //     navBarStyle: NavBarStyle.style3,
    //     onItemSelected: (final index) {
    //       setState(() {
    //         selectedIndex = index;
    //       });
    //     },
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         setState(() {
    //           selectedIndex = 2;
    //         });
    //       },
    //       child: const Icon(Icons.add),
    //       shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(50),
    //         ),
    //       ),

    //     ),
    //   ),
    // );

    return Scaffold(
      body: pages[selectedIndex],
      extendBody: true,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
          onPressed: () {
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

        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    CupertinoIcons.house_fill,
                    color: selectedIndex == 0
                        ? const Color(0xFF5C6AC0)
                        : Colors.white,
                  ),
                  onPressed: () {
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

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const StatistikPage(),
      // const AddSleepPage(),
      const FaqPage(),
      const ProfilePage(),
      // const AddQuizPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.house_fill),
        activeColorPrimary: const Color(0xFF5C6AC0),
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chart_bar_square_fill),
        activeColorPrimary: const Color(0xFF5C6AC0),
        inactiveColorPrimary: Colors.white,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(
      //     CupertinoIcons.plus,
      //     color: Colors.white,
      //   ),
      //   activeColorPrimary: const Color(0xFF5C6AC0),
      //   inactiveColorPrimary: Colors.white,

      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.question_square_fill),
        activeColorPrimary: const Color(0xFF5C6AC0),
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_fill),
        activeColorPrimary: const Color(0xFF5C6AC0),
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }
}
