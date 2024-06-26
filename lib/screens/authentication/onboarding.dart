import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleep_diary_mobile/controllers/authentication/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/header_onboarding.png',
              height: 280,
            ),
          ),
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                title: 'Selamat Datang',
                subtitle:
                    'SleepDiary adalah aplikasi pelacak tidur yang intuitif dan mudah digunakan',
                imagePath: 'assets/images/1.png',
              ),
              OnBoardingPage(
                title: 'Pencatat',
                subtitle:
                    'SleepDiary menawarkan fitur pencatatan tidur, di mana Anda dapat merekam detail tidur setiap malam. Pantau pola tidur Anda melalui grafik interaktif untuk pemahaman yang lebih baik dan perbaikan kualitas tidur secara keseluruhan.',
                imagePath: 'assets/images/pencatat.png',
              ),
              OnBoardingPage(
                title: 'Reminder',
                subtitle:
                    'SleepDiary menawarkan fitur pengingat, sehingga Anda tidak akan melewatkan jadwal tidur yang optimal. Tetap teratur dengan pengingat yang disesuaikan untuk membantu Anda memprioritaskan kesehatan tidur setiap hari.',
                imagePath: 'assets/images/reminder.png',
              ),
              OnBoardingPage(
                title: 'Statistik',
                subtitle:
                    'SleepDiary menawarkan grafik dan ringkasan pola tidur mingguan dan bulanan, memungkinkan Anda dengan mudah melacak pola tidur dari waktu ke waktu. Dapatkan wawasan berharga tentang bagaimana pola Anda sepanjang minggu dan bulan.',
                imagePath: 'assets/images/statistik.png',
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: 4,
                    effect: WormEffect(
                      dotHeight: 8.0,
                      dotWidth: 24.0,
                      spacing: 8.0,
                      dotColor: Colors.grey.shade300,
                      activeDotColor: const Color(0xFF080A23),
                    ),
                    onDotClicked: controller.dotNavigationClick,
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 157,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: () => controller.skipPage(),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'Lewati',
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 157,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.pageController.page == 3) {
                              controller.skipPage();
                            } else {
                              controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFF080A23),
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'Selanjutnya',
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  final String title, subtitle, imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    imagePath,
                    height: 200.0, // Adjust height as needed
                  ),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(8, 10, 35, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
