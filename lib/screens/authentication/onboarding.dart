import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleep_diary_mobile/controllers/authentication/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                title: 'Manfaat',
                subtitle:
                    'Teman Setia dalam perjalanan menuju tidur yang lebih baik',
                imagePath: 'assets/images/2.png',
              ),
              OnBoardingPage(
                title: 'Tujuan',
                subtitle:
                    'Bertujuan untuk membantu Anda memahami dan meningkatkan kualitas tidur Anda',
                imagePath: 'assets/images/3.png',
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
                    count: 3,
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
                          onPressed: () =>
                              OnBoardingController.instance.skipPage(),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text('Lewati', style: GoogleFonts.poppins(),),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 157,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: () =>
                              OnBoardingController.instance.nextPage(),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFF080A23),
                            shadowColor: Colors.transparent,
                          ),
                          child: Text('Selanjutnya', style: GoogleFonts.poppins(),),
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
    final screenHeight = MediaQuery.of(context).size.height;

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
                      color: Color.fromRGBO(8, 10, 35, 1),
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
