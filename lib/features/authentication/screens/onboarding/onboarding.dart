import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_diary_mobile/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
        body: PageView(
      controller: controller.pageController,
      onPageChanged: controller.updatePageIndicator,
      children: const [
        OnBoardingPage(
            title: 'Selamat Datang',
            subtitle:
                'SleepDiary adalah aplikasi pelacak tidur yang intuitif dan mudah digunakan'),
        OnBoardingPage(
            title: 'Manfaat',
            subtitle:
                'Teman Setia dalam perjalanan menuju tidur yang lebih baik'),
        OnBoardingPage(
            title: 'Tujuan',
            subtitle:
                'Bertujuan untuk membantu Anda memahami dan meningkatkan kualitas tidur Anda'),
      ],
    ));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key, required this.title, required this.subtitle});

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight / 3;
    final controller = OnBoardingController.instance;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: headerHeight,
          decoration: const BoxDecoration(
            color: Color(0xFF0E2431),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app_logo.png', // Ganti dengan path gambar yang sesuai
                width: 96, // Lebar gambar
                height: 120, // Tinggi gambar
              ),
              const SizedBox(
                  width: 10), // Memberikan jarak antara gambar dan teks
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SleepDiary',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5), // Memberikan jarak antara dua teks
                    Text(
                      'Unlock Better Sleep, Unleash Better Days',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 36.0, // Ukuran font 36
                          fontWeight: FontWeight.bold, // Ketebalan teks bold
                        ),
                      ),
                      const SizedBox(
                          height: 63.0), // Jarak antara title dan subtitle
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.0, // Ukuran font 36
                          fontWeight: FontWeight.w400, // Ketebalan teks bold
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 63.0),
                SmoothPageIndicator(
                  controller: controller.pageController,
                  count: 3,
                  onDotClicked: controller.dotNavigationClick,
                ),
                const SizedBox(height: 50.0),
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
                            borderRadius:
                                BorderRadius.circular(10), // Border radius 5
                            side: const BorderSide(
                                color:
                                    Colors.black), // Border dengan warna hitam
                          ),
                          backgroundColor: Colors.white, // Warna latar belakang
                          shadowColor: Colors.transparent, // Tanpa shadow
                        ),
                        child: const Text('Lewati'),
                      ),
                    ),

                    const SizedBox(width: 10), // Jarak antara tombol
                    SizedBox(
                      width: 157,
                      height: 49,
                      child: ElevatedButton(
                        onPressed: () =>
                            OnBoardingController.instance.nextPage(),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Border radius 5
                          ),
                          backgroundColor:
                              const Color(0xFF0E2431), // Warna teks
                          shadowColor: Colors.transparent, // Tanpa shadow
                        ),
                        child: const Text('Selanjutnya'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
