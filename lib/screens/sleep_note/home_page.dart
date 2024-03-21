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
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
      cancelText: 'Cancel',
      confirmText: 'OK',
      helpText: 'Select date',
    );
    if (picked != null && picked != today) {
      setState(() {
        today = picked;
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
                      text: "Tanggal : ${today.toString().split(" ")[0]}",
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
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hallo Argya!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
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

  AspectRatio _card() {
    return AspectRatio(
      aspectRatio: 336 / 110,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(38, 38, 66, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              alignment: Alignment.topLeft,
              child: const Row(
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(
                    width: 10,
                    height: 30,
                  ),
                  Text(
                    "15 Maret 2024",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  // Text(
                  //   today.toString().split(" ")[0],
                  //   style: const TextStyle(color: Colors.white),
                  // ),
                ],
              ),
            ),
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
