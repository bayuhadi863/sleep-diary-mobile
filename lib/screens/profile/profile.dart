import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_diary_mobile/main.dart';
import 'package:sleep_diary_mobile/repositories/authentication/authentication_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 52,
            ),
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/bulan.png'),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(38, 38, 66, 1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 5),
                        color: Colors.purple.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 10)
                  ]),
              child: const ListTile(
                title: Text(
                  "Nama Lengkap",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text("Argya Dwi Ferdinand Putra",
                    style: TextStyle(color: Colors.white)),
                leading: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                ),
                tileColor: Colors.transparent,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(38, 38, 66, 1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 5),
                        color: const Color.fromARGB(255, 44, 23, 48)
                            .withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 10)
                  ]),
              child: const ListTile(
                title: Text("Email", style: TextStyle(color: Colors.white)),
                subtitle: Text("argyawoles@gmail.com",
                    style: TextStyle(color: Colors.white)),
                leading: Icon(
                  CupertinoIcons.mail,
                  color: Colors.white,
                ),
                tileColor: Colors.transparent,
              ),
            ),
            const SizedBox(
              height: 350,
            ),
            GestureDetector(
              onTap: () async {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const MainPage()),
                // );
                // Melakukan logout pengguna
                await AuthenticationRepository.instance.logout();

                // Setelah logout, pindahkan pengguna ke halaman login atau halaman lainnya yang sesuai
                // Misalnya, jika ingin memindahkan pengguna ke halaman login
                Navigator.pushReplacementNamed(context,
                    '/login'); // Ganti '/login' dengan rute halaman yang sesuai
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 162, 18, 18),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      color: Colors.purple.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Logout",
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
