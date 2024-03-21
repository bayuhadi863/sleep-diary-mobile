import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/controllers/profile/user_controller.dart';
import 'package:sleep_diary_mobile/screens/profile/profile.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              height: 42,
            ),
            _greetings(),
            const SizedBox(
              height: 17,
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
          Text(
            today.toString().split(" ")[0],
            style: const TextStyle(color: Colors.white),
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
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: _selectDate,
            color: Colors.white,
            textColor: Colors.black,
            child: const Text('Pilih'),
          ),
        ],
      ),
    );
  }

  AspectRatio _header() {
    return AspectRatio(
      aspectRatio: 336 / 100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(8, 10, 35, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/app_logo.png'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Unlock Better Sleep",
                style: TextStyle(color: Colors.white),
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
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Jumat 15-03-2024",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
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
          IconButton(
            onPressed: () {},
            icon: PopUpMenu(
              menuList: [
                PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(
                      CupertinoIcons.person,
                    ),
                    title: Text("My Profile"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  },
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: TextButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
