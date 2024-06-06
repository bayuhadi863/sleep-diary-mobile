import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    borderRadius: BorderRadius.circular(14),
                    color: const Color.fromRGBO(38, 38, 66, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 11),
                        child: Text(
                          'FAQs',
                          style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.56,
                  top: 6,
                  child: Image.asset(
                    'assets/images/Group2291.png',
                    width: 160,
                    height: 160,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const CustomExpansionTile(
              title: "Apa itu SleepDiary?",
              content:
                  "Aplikasi SleepDiary adalah teman tidur Anda yang setia, dirancang untuk membantu Anda memantau dan mencatat kualitas tidur Anda dari waktu ke waktu. Aplikasi ini memungkinkan pengguna untuk meningkatkan kualitas tidur mereka.",
            ),
            const SizedBox(height: 20),
            const CustomExpansionTile(
              title: "Apa fitur utama Aplikasi SleepDiary?",
              content:
                  "Fitur-fitur utama dalam Aplikasi SleepDiary mencakup:\n\n"
                  "1. Grafik analisis pola tidur:\n Menampilkan pola tidur pengguna dalam bentuk grafik untuk mempermudah pemantauan dan pemahaman.\n\n"
                  "2. Reminder tidur:\n Memberikan pengingat kepada pengguna untuk tidur sesuai jadwal yang diinginkan.\n\n"
                  "3. Pemantauan kualitas tidur:\n Memungkinkan pengguna untuk mencatat dan melacak kualitas tidur mereka dari waktu ke waktu.",
            ),
            const SizedBox(height: 20),
            const CustomExpansionTile(
              title: "Berapa normalnya waktu tidur?",
              content:
                  "Waktu tidur yang disarankan untuk orang dewasa adalah antara 7-9 jam per hari.",
            ),
            const SizedBox(height: 200),
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
    super.key,
  });

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
        borderRadius: BorderRadius.circular(14),
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
          iconColor: const Color.fromARGB(255, 65, 159, 237),
          collapsedIconColor: const Color.fromARGB(255, 65, 159, 237),
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: isExpanded ? Colors.white : Colors.transparent,
                ),
                width: 5,
                height: 50,
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 26, left: 45, right: 45),
              child: Text(
                widget.content,
                style: GoogleFonts.poppins(
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
