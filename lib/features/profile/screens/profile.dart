import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_diary_mobile/features/sleep_note/screens/home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 52,
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/bulan.png'),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.purple.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 10)
                  ]),
              child: ListTile(
                title: Text("Nama Lengkap"),
                subtitle: Text("Argya Dwi Ferdinand Putra"),
                leading: Icon(CupertinoIcons.person),
                tileColor: Colors.transparent,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.purple.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 10)
                  ]),
              child: ListTile(
                title: Text("Email"),
                subtitle: Text("argyawoles@gmail.com"),
                leading: Icon(CupertinoIcons.mail),
                tileColor: Colors.transparent,
              ),
            ),
            SizedBox(
              height: 350,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 128, 123, 215),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      color: Colors.purple.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Beranda",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
