import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 70, bottom: 50, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromRGBO(38, 38, 66, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 11),
                        child: const Text(
                          'FAQs',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 248,
                  top: 10,
                  child: Image.asset(
                    'assets/images/Group2291.png',
                    width: 160,
                    height: 160,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomExpansionTile(
              title: "Apa itu SleepDiary?",
              content:
                  "Aplikasi SleepDiary adalah teman tidur Anda yang setia, dirancang untuk membantu Anda memantau dan mencatat kualitas tidur Anda dari waktu ke waktu. aplikasi ini memungkinkan pengguna untuk meningkatkan kualitas tidur mereka.",
            ),
            SizedBox(height: 20),
            CustomExpansionTile(
              title: "Apa fitur utama Aplikasi SleepDiary?",
              content: "Fitur-fitur utama dalam Aplikasi SleepDiary mencakup:\n"
                  "1. Grafik analisis pola tidur: Menampilkan pola tidur pengguna dalam bentuk grafik untuk mempermudah pemantauan dan pemahaman.\n"
                  "2. Reminder tidur: Memberikan pengingat kepada pengguna untuk tidur sesuai jadwal yang diinginkan.\n"
                  "3. Pemantauan kualitas tidur: Memungkinkan pengguna untuk mencatat dan melacak kualitas tidur mereka dari waktu ke waktu.",
            ),
            SizedBox(height: 20),
            CustomExpansionTile(
              title: "Berapa normalnya waktu tidur?",
              content:
                  "Waktu tidur yang disarankan untuk orang dewasa adalah antara 7-9 jam per hari.",
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String content;

  const CustomExpansionTile({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF262642),
        border: Border.all(
          width: 1.0,
          color: Colors.transparent,
        ),
      ),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: const Color(0xFF262642),
          collapsedBackgroundColor: const Color(0xFF262642),
          shape: Border(),
          title: Row(
            children: [
              Container(
                width: 5,
                height: 50,
                color: isExpanded ? Colors.white : Colors.transparent,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 26, left: 20, right: 12),
              child: Text(
                widget.content,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
          onExpansionChanged: (bool expanded) {
            setState(() {
              isExpanded = expanded;
            });
          },
        ),
      ),
    );
  }
}
