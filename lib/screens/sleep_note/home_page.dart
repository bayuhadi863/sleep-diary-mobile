import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/profile/user_controller.dart';
import 'package:sleep_diary_mobile/screens/profile/profile.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static DateTime today = DateTime.now();
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      HomePage.today= day;
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
                      text: "Tanggal : ${HomePage.today.toString().split(" ")[0]}",
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
      // aspectRatio: 336 / 100,
      child: Container(
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
                  Text(
                    "Halo, ${controller.user.value.name.split(' ')[0]}!",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
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
      ),
    );
  }

  Container _card() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(38, 38, 66, 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Row(
                  children: [
                    Text(
                      "Jumat 15-03-2024",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Additional Row 1
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.13),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        '9 Jam',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '21.00 - 06.00',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // Menggunakan Expanded di sini
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/lingkungan-fiks.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 6),
                    Image.asset(
                      'assets/images/sakit.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 6),
                    Image.asset(
                      'assets/images/gelisah.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 6),
                    Image.asset(
                      'assets/images/terbangun.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 6),
                    Image.asset(
                      'assets/images/stress.png',
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            // margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.13),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/skala2.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Tidurmu sangat nyenyak, Pertahankan!',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    // softWrap: true,
                  ),
                ),
              ],
            ),
          ),

          // Additional Rows can be added here if needed
        ],
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
