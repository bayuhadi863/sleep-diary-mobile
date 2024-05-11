// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sleep_diary_mobile/main.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/sleep_diary_repository.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/home_page.dart';

class AddSleepPage extends StatefulWidget {
  const AddSleepPage({super.key});

  @override
  State<AddSleepPage> createState() => _AddSleepPageState();
}

class _AddSleepPageState extends State<AddSleepPage> {
  TimeOfDay? time = const TimeOfDay(hour: 00, minute: 00);
  ValueNotifier<List<int>> time1 = ValueNotifier<List<int>>([0, 0]);
  ValueNotifier<List<int>> time2 = ValueNotifier<List<int>>([0, 0]);
  ValueNotifier<int> scale = ValueNotifier<int>(0);
  List<String> factors = [];
  final ValueNotifier<List<bool>> selectedFactors =
      ValueNotifier<List<bool>>([false, false, false, false, false]);
  TextEditingController description = TextEditingController();

  bool isLoading = false;
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromRGBO(38, 38, 66, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/popupad.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Apakah Anda yakin ingin keluar dari halaman ini? Data yang belum tersimpan akan hilang",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1.0, color: Colors.white),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Batal",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 215, 56, 45),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        onPressed: () {
                          Get.offAll(() => const MainPage());
                        },
                        child: const Text(
                          "Keluar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 52,
              ),
              _date(),
              const SizedBox(
                height: 20,
              ),
              _addTime(),
              const SizedBox(
                height: 15,
              ),
              _scale(),
              const SizedBox(
                height: 20,
              ),
              _factors(),
              const SizedBox(
                height: 20,
              ),
              _desc(),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: isLoading || disabled
                    ? null
                    : () async {
                        // Disable Button
                        setState(() {
                          disabled = true;
                        });

                        // Start Loading
                        setState(() {
                          isLoading = true;
                        });

                        final repository = SleepDiaryRepository(
                            sleepDate: DateFormat.yMMMMEEEEd('en_US')
                                .format(HomePage.today),
                            hour1: (time1.value[0] < 10)
                                ? "0${time1.value[0]}"
                                : time1.value[0].toString(),
                            minute1: (time1.value[1] < 10)
                                ? "0${time1.value[1]}"
                                : time1.value[1].toString(),
                            hour2: (time2.value[0] < 10)
                                ? "0${time2.value[0]}"
                                : time2.value[0].toString(),
                            minute2: (time2.value[1] < 10)
                                ? "0${time2.value[1]}"
                                : time2.value[1].toString(),
                            scale: scale.value,
                            factors: factors,
                            description: description.text);

                        await repository.createSleepDiary(context);

                        // Stop Loading
                        setState(() {
                          isLoading = false;
                        });

                        // wait 3 seconds
                        await Future.delayed(const Duration(seconds: 3));

                        // Enable Button
                        if (mounted) {
                          setState(() {
                            disabled = false;
                          });
                        }
                      },
                child: Container(
                  height: 50,
                  width: 370,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isLoading
                        ? const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.8)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            "Simpan",
                            style: TextStyle(color: Colors.black),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _date() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  DateFormat.yMMMMEEEEd('id_ID').format(HomePage.today),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                const Text(
                  "SleepDiary",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            )
          ],
        ));
  }

  Widget _addTime() {
    return AspectRatio(
      aspectRatio: 336 / 130,
      child: Column(
        children: [
          const Text("Catat Tidurmu",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Tidur',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white24,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: time1.value[0],
                            minute: time1.value[1],
                          ),
                        );
                        if (pickedTime != null) {
                          time1.value = [pickedTime.hour, pickedTime.minute];
                        }
                      },
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: time1,
                            builder: (context, value, child) {
                              return Text(
                                '${value[0].toString().padLeft(2, '0')}:${value[1].toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.arrow_drop_down,
                              color: Color(0xFF71B2BD)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Bangun',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white24,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: time2.value[0],
                            minute: time2.value[1],
                          ),
                        );
                        if (pickedTime != null) {
                          time2.value = [pickedTime.hour, pickedTime.minute];
                        }
                      },
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: time2,
                            builder: (context, value, child) {
                              return Text(
                                '${value[0].toString().padLeft(2, '0')}:${value[1].toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.arrow_drop_down,
                              color: Color(0xFF71B2BD)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _scale() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Bagaimana kualitas tidurmu?",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              GestureDetector(
                onTap: () => _scaleInfo(context),
                child: const Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ValueListenableBuilder(
                    valueListenable: scale,
                    builder: (context, value, child) {
                      return InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          scale.value = 1;
                          print(scale);
                        },
                        child: Ink.image(
                            image: const AssetImage(
                                'assets/images/skalabulan1.png'),
                            height: value == 1
                                ? 57
                                : value == 0
                                    ? 50
                                    : 37,
                            width: value == 1
                                ? 57
                                : value == 0
                                    ? 50
                                    : 37,
                            fit: BoxFit.cover,
                            colorFilter: (value == 1)
                                ? const ColorFilter.mode(
                                    Color.fromRGBO(8, 10, 35, 1),
                                    BlendMode.color)
                                : const ColorFilter.mode(
                                    Colors.transparent, BlendMode.color)),
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: scale,
                    builder: (context, value, child) {
                      return InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          scale.value = 2;
                          print(scale);
                        },
                        child: Ink.image(
                          image:
                              const AssetImage('assets/images/skalabulan2.png'),
                          height: value == 2
                              ? 57
                              : value == 0
                                  ? 50
                                  : 37,
                          width: value == 2
                              ? 57
                              : value == 0
                                  ? 50
                                  : 37,
                          fit: BoxFit.cover,
                          colorFilter: (value == 2)
                              ? const ColorFilter.mode(
                                  Color.fromRGBO(8, 10, 35, 1), BlendMode.color)
                              : const ColorFilter.mode(
                                  Colors.transparent, BlendMode.color),
                        ),
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: scale,
                    builder: (context, value, child) {
                      return InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          scale.value = 3;
                          print(scale);
                        },
                        child: Ink.image(
                          image:
                              const AssetImage('assets/images/skalabulan3.png'),
                          height: value == 3
                              ? 57
                              : value == 0
                                  ? 50
                                  : 37,
                          width: value == 3
                              ? 57
                              : value == 0
                                  ? 50
                                  : 37,
                          fit: BoxFit.cover,
                          colorFilter: (value == 3)
                              ? const ColorFilter.mode(
                                  Color.fromRGBO(8, 10, 35, 1), BlendMode.color)
                              : const ColorFilter.mode(
                                  Colors.transparent, BlendMode.color),
                        ),
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: scale,
                    builder: (context, value, child) {
                      return InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          scale.value = 4;
                          print(scale);
                          selectedFactors.value = [
                            false,
                            false,
                            false,
                            false,
                            false
                          ];
                          factors.clear();
                        },
                        child: Ink.image(
                          image:
                              const AssetImage('assets/images/skalabulan4.png'),
                          height: value == 4
                              ? 57
                              : value == 0
                                  ? 50
                                  : 37,
                          width: value == 4
                              ? 57
                              : value == 0
                                  ? 50
                                  : 37,
                          fit: BoxFit.cover,
                          colorFilter: (value == 4)
                              ? const ColorFilter.mode(
                                  Color.fromRGBO(8, 10, 35, 1), BlendMode.color)
                              : const ColorFilter.mode(
                                  Colors.transparent, BlendMode.color),
                        ),
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: scale,
                    builder: (context, value, child) {
                      return InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          scale.value = 5;
                          print(scale);
                          selectedFactors.value = [
                            false,
                            false,
                            false,
                            false,
                            false
                          ];
                          factors.clear();
                        },
                        child: Ink.image(
                            image: const AssetImage(
                                'assets/images/skalabulan5.png'),
                            height: value == 5
                                ? 57
                                : value == 0
                                    ? 50
                                    : 37,
                            width: value == 5
                                ? 57
                                : value == 0
                                    ? 50
                                    : 37,
                            fit: BoxFit.cover,
                            colorFilter: (value == 5)
                                ? const ColorFilter.mode(
                                    Color.fromRGBO(8, 10, 35, 1),
                                    BlendMode.color)
                                : const ColorFilter.mode(
                                    Colors.transparent, BlendMode.color)),
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  ValueListenableBuilder _factors() {
    return ValueListenableBuilder(
        valueListenable: scale,
        builder: (context, selectedScale, child) {
          if (selectedScale == 0 ||
              selectedScale == 1 ||
              selectedScale == 2 ||
              selectedScale == 3) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white24),
                child: Column(children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Faktor",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: selectedFactors,
                            builder: (context, value, child) {
                              return InkWell(
                                  splashColor: Colors.black26,
                                  onTap: () {
                                    if (!selectedFactors.value[0]) {
                                      factors.add("lingkungan");
                                      selectedFactors.value[0] = true;
                                    } else {
                                      factors.remove("lingkungan");
                                      selectedFactors.value[0] = false;
                                    }
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();
                                  },
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Ink.image(
                                          image: const AssetImage(
                                              'assets/images/lingkungan.png'),
                                          height: 50,
                                          width: 50,
                                          colorFilter: (value[0] == false)
                                              ? const ColorFilter.mode(
                                                  Color.fromRGBO(8, 10, 35, 1),
                                                  BlendMode.color)
                                              : const ColorFilter.mode(
                                                  Colors.transparent,
                                                  BlendMode.color)),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Lingkungan",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )));
                            }),
                        ValueListenableBuilder(
                            valueListenable: selectedFactors,
                            builder: (context, value, child) {
                              return InkWell(
                                  splashColor: Colors.black26,
                                  onTap: () {
                                    if (!selectedFactors.value[1]) {
                                      factors.add("stress");
                                      selectedFactors.value[1] = true;
                                    } else {
                                      factors.remove("stress");
                                      selectedFactors.value[1] = false;
                                    }
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();
                                  },
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Ink.image(
                                          image: const AssetImage(
                                              'assets/images/stress.png'),
                                          height: 50,
                                          width: 50,
                                          colorFilter: (value[1] == false)
                                              ? const ColorFilter.mode(
                                                  Color.fromRGBO(8, 10, 35, 1),
                                                  BlendMode.color)
                                              : const ColorFilter.mode(
                                                  Colors.transparent,
                                                  BlendMode.color)),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Stress",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )));
                            }),
                        ValueListenableBuilder(
                            valueListenable: selectedFactors,
                            builder: (context, value, child) {
                              return InkWell(
                                  splashColor: Colors.black26,
                                  onTap: () {
                                    if (!selectedFactors.value[2]) {
                                      factors.add("sakit");
                                      selectedFactors.value[2] = true;
                                    } else {
                                      factors.remove("sakit");
                                      selectedFactors.value[2] = false;
                                    }
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();
                                  },
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Ink.image(
                                          image: const AssetImage(
                                              'assets/images/sakit.png'),
                                          height: 50,
                                          width: 50,
                                          colorFilter: (value[2] == false)
                                              ? const ColorFilter.mode(
                                                  Color.fromRGBO(8, 10, 35, 1),
                                                  BlendMode.color)
                                              : const ColorFilter.mode(
                                                  Colors.transparent,
                                                  BlendMode.color)),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Sakit",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  )));
                            }),
                        ValueListenableBuilder(
                            valueListenable: selectedFactors,
                            builder: (context, value, child) {
                              return InkWell(
                                  splashColor: Colors.black26,
                                  onTap: () {
                                    if (!selectedFactors.value[3]) {
                                      factors.add("gelisah");
                                      selectedFactors.value[3] = true;
                                    } else {
                                      factors.remove("gelisah");
                                      selectedFactors.value[3] = false;
                                    }
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();
                                  },
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Ink.image(
                                          image: const AssetImage(
                                              'assets/images/gelisah.png'),
                                          height: 50,
                                          width: 50,
                                          colorFilter: (value[3] == false)
                                              ? const ColorFilter.mode(
                                                  Color.fromRGBO(8, 10, 35, 1),
                                                  BlendMode.color)
                                              : const ColorFilter.mode(
                                                  Colors.transparent,
                                                  BlendMode.color)),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Gelisah",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )));
                            }),
                        ValueListenableBuilder(
                            valueListenable: selectedFactors,
                            builder: (context, value, child) {
                              return InkWell(
                                  splashColor: Colors.black26,
                                  onTap: () {
                                    if (!selectedFactors.value[4]) {
                                      factors.add("terbangun");
                                      selectedFactors.value[4] = true;
                                    } else {
                                      factors.remove("terbangun");
                                      selectedFactors.value[4] = false;
                                    }
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();
                                  },
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Ink.image(
                                        image: const AssetImage(
                                            'assets/images/terbangun.png'),
                                        height: 50,
                                        width: 50,
                                        colorFilter: (value[4] == false)
                                            ? const ColorFilter.mode(
                                                Color.fromRGBO(8, 10, 35, 1),
                                                BlendMode.color)
                                            : const ColorFilter.mode(
                                                Colors.transparent,
                                                BlendMode.color),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Terbangun",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )));
                            }),
                      ],
                    ),
                  ),
                ]));
          } else if (selectedScale == 4) {
            return AspectRatio(
              aspectRatio: 100 / 30,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.white,
                  //   width: 1, // Lebar border
                  // ),
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Good Job!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tingkatkan',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return AspectRatio(
              aspectRatio: 100 / 30,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.white,
                  //   width: 1, // Lebar border
                  // ),
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Perfect!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pertahankan',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  AspectRatio _desc() {
    return AspectRatio(
      aspectRatio: 336 / 150,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white24,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ceritakan tidurmu",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 1),
            Expanded(
              child: TextField(
                controller: description,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scaleInfo(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Detail Informasi"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/skalabulan1.png'),
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Title(
                              color: Colors.black,
                              child: const Text(
                                "Sangat Buruk",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text(
                              'Tidur sangat buruk dan tidak memuaskan. Merasa sangat lelah dan tidak segar saat bangun pagi.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/skalabulan2.png'),
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Title(
                              color: Colors.black,
                              child: const Text(
                                "Buruk",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text(
                              'Tidur kurang baik, tetapi tidak seburuk skala 1. Merasa lelah atau kurang segar saat bangun pagi.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/skalabulan3.png'),
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Title(
                              color: Colors.black,
                              child: const Text(
                                "Cukup",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text(
                              'Tidur relatif stabil tanpa terlalu banyak gangguan. Bangun pagi dengan segar, tetapi masih ada kelelahan.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/skalabulan4.png'),
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Title(
                              color: Colors.black,
                              child: const Text(
                                "Baik",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text(
                              'Tidur sangat baik dan nyenyak sepanjang malam. Bangun pagi dengan perasaan segar dan bertenaga.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/skalabulan5.png'),
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Title(
                              color: Colors.black,
                              child: const Text(
                                "Sangat Baik",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text(
                              'Tidur sangat luar biasa, sangat nyenyak dan puas. Bangun pagi dengan perasaan segar bersemangat dan penuh energi.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(102, 28, 237, 226),
                    ),
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50)),
                  ),
                  child: const Text(
                    "Mengerti",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
