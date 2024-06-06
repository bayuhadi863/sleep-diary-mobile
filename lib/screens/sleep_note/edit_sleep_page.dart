// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sleep_diary_mobile/main.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/sleep_diary_repository.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/home_page.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/get_sleep_diary.dart';

class EditSleepPage extends StatefulWidget {
  const EditSleepPage({super.key});

  @override
  State<EditSleepPage> createState() => _EditSleepPageState();
}

class _EditSleepPageState extends State<EditSleepPage> {
  // TimeOfDay? time = const TimeOfDay(hour: 00, minute: 00);
  SleepDiaryModel? sleepDiary;
  ValueNotifier<List<int>> time1 = ValueNotifier<List<int>>([0, 0]);
  ValueNotifier<List<int>> time2 = ValueNotifier<List<int>>([0, 0]);
  ValueNotifier<int> scale = ValueNotifier<int>(0);
  List<String> factors = [];
  final ValueNotifier<List<bool>> selectedFactors =
      ValueNotifier<List<bool>>([false, false, false, false, false]);
  TextEditingController description = TextEditingController();

  bool isLoading = false;
  bool isChange = false;
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    fetchSleepDiary();
  }

  void fetchSleepDiary() async {
    sleepDiary =
        await GetSleepDiaryRepository().fetchSleepDiary(HomePage.today);
    time1.value = [
      int.parse(sleepDiary!.sleepTime.split(":")[0]),
      int.parse(sleepDiary!.sleepTime.split(":")[1])
    ];
    time2.value = [
      int.parse(sleepDiary!.wakeupTime.split(":")[0]),
      int.parse(sleepDiary!.wakeupTime.split(":")[1])
    ];
    scale.value = sleepDiary!.scale;
    sleepDiary!.factors.sort();
    factors = [...sleepDiary!.factors];
    for (int i = 0; i < sleepDiary!.factors.length; i++) {
      if (sleepDiary!.factors[i] == "lingkungan") {
        selectedFactors.value[0] = true;
      } else if (sleepDiary!.factors[i] == "stress") {
        selectedFactors.value[1] = true;
      } else if (sleepDiary!.factors[i] == "sakit") {
        selectedFactors.value[2] = true;
      } else if (sleepDiary!.factors[i] == "gelisah") {
        selectedFactors.value[3] = true;
      } else if (sleepDiary!.factors[i] == "terbangun") {
        selectedFactors.value[4] = true;
      }
    }
    description.text = sleepDiary!.description;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isChange || description.text.trim() == "") {
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
                      'assets/images/hapusdata22.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Apakah Anda yakin ingin keluar dari halaman ini? Data yang belum tersimpan akan hilang",
                      style: GoogleFonts.poppins(
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
                          child: Text(
                            "Batal",
                            style: GoogleFonts.poppins(color: Colors.white),
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
                          child: Text(
                            "Keluar",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
          title: Text(
            DateFormat.yMMMMEEEEd('id_ID').format(HomePage.today),
            style: GoogleFonts.poppins(
                fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              onPressed: () {
                if (isChange || description.text.trim() == "") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => confirmDialog(
                      context,
                      () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                } else {
                  Get.offAll(() => const MainPage());
                }
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              _date(),
              const SizedBox(
                height: 12,
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
                onTap: !isChange
                    ? null
                    : () async {
                        

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

                        await repository.updateSleepDiary(context);
                      },
                child: Container(
                  height: 50,
                  width: 370,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isChange
                        ? const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.8)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : Text(
                            "Update",
                            style: GoogleFonts.poppins(
                                color: isChange ? Colors.black : Colors.grey),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
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
            Column(children: [
              Text(
                "SleepDiary",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ])
          ],
        ));
  }

  Widget _addTime() {
    return AspectRatio(
      aspectRatio: 336 / 130,
      child: Column(
        children: [
          Text("Edit Data Tidurmu",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Tidur',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white24,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          cancelText: 'Batal',
                          confirmText: 'Simpan',
                          helpText: 'Edit Waktu Tidur',
                          initialTime: TimeOfDay(
                            hour: time1.value[0],
                            minute: time1.value[1],
                          ),
                        );
                        if (pickedTime != null) {
                          time1.value = [pickedTime.hour, pickedTime.minute];
                          setState(() {
                            isChange = (pickedTime.hour !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[0]) ||
                                pickedTime.minute !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[1]) ||
                                time2.value[0] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[0]) ||
                                time2.value[1] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[1]) ||
                                scale.value != sleepDiary!.scale ||
                                !listEquals(factors, sleepDiary!.factors) ||
                                (description.text != sleepDiary!.description));
                          });
                        }
                      },
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: time1,
                            builder: (context, value, child) {
                              return Text(
                                '${value[0].toString().padLeft(2, '0')}:${value[1].toString().padLeft(2, '0')}',
                                style: GoogleFonts.poppins(
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
                  Text(
                    'Bangun',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white24,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          cancelText: 'Batal',
                          confirmText: 'Simpan',
                          helpText: 'Edit Waktu Bangun',
                          initialTime: TimeOfDay(
                            hour: time2.value[0],
                            minute: time2.value[1],
                          ),
                        );
                        if (pickedTime != null) {
                          time2.value = [pickedTime.hour, pickedTime.minute];
                          setState(() {
                            isChange = (time1.value[0] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[0]) ||
                                time1.value[1] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[1]) ||
                                pickedTime.hour !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[0]) ||
                                pickedTime.minute !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[1]) ||
                                scale.value != sleepDiary!.scale ||
                                !listEquals(factors, sleepDiary!.factors) ||
                                (description.text != sleepDiary!.description));
                          });
                        }
                      },
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: time2,
                            builder: (context, value, child) {
                              return Text(
                                '${value[0].toString().padLeft(2, '0')}:${value[1].toString().padLeft(2, '0')}',
                                style: GoogleFonts.poppins(
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
          borderRadius: BorderRadius.circular(14), color: Colors.white24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Bagaimana kualitas tidurmu?",
                  style: GoogleFonts.poppins(
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
                          print(
                              "Faktor: ${listEquals(factors, sleepDiary!.factors)}");
                          print("${factors} : ${sleepDiary!.factors}");
                          setState(() {
                            isChange = (time1.value[0] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[0]) ||
                                time1.value[1] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[1]) ||
                                time2.value[0] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[0]) ||
                                time2.value[1] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[1]) ||
                                1 != sleepDiary!.scale ||
                                !listEquals(factors, sleepDiary!.factors) ||
                                (description.text != sleepDiary!.description));
                          });
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
                          print(
                              "Faktor: ${listEquals(factors, sleepDiary!.factors)}");
                          print("${factors} : ${sleepDiary!.factors}");
                          setState(() {
                            isChange = (time1.value[0] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[0]) ||
                                time1.value[1] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[1]) ||
                                time2.value[0] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[0]) ||
                                time2.value[1] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[1]) ||
                                2 != sleepDiary!.scale ||
                                !listEquals(factors, sleepDiary!.factors) ||
                                (description.text != sleepDiary!.description));
                          });
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
                          print(
                              "Faktor: ${listEquals(factors, sleepDiary!.factors)}");
                          print("${factors} : ${sleepDiary!.factors}");
                          setState(() {
                            isChange = (time1.value[0] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[0]) ||
                                time1.value[1] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[1]) ||
                                time2.value[0] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[0]) ||
                                time2.value[1] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[1]) ||
                                scale.value != sleepDiary!.scale ||
                                !listEquals(factors, sleepDiary!.factors) ||
                                (description.text != sleepDiary!.description));
                          });
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
                          print(
                              "Faktor: ${listEquals(factors, sleepDiary!.factors)}");
                          print("${factors} : ${sleepDiary!.factors}");

                          setState(() {
                            isChange = (time1.value[0] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[0]) ||
                                time1.value[1] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[1]) ||
                                time2.value[0] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[0]) ||
                                time2.value[1] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[1]) ||
                                4 != sleepDiary!.scale ||
                                !listEquals(factors, sleepDiary!.factors) ||
                                (description.text != sleepDiary!.description));
                          });
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
                          print(
                              "Faktor: ${listEquals(factors, sleepDiary!.factors)}");
                          print("${factors} : ${sleepDiary!.factors}");

                          setState(() {
                            isChange = (time1.value[0] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[0]) ||
                                time1.value[1] !=
                                    int.parse(
                                        sleepDiary!.sleepTime.split(":")[1]) ||
                                time2.value[0] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[0]) ||
                                time2.value[1] !=
                                    int.parse(
                                        sleepDiary!.wakeupTime.split(":")[1]) ||
                                5 != sleepDiary!.scale ||
                                !listEquals(factors, sleepDiary!.factors) ||
                                (description.text != sleepDiary!.description));
                          });
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
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white24),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Faktor",
                        style: GoogleFonts.poppins(
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
                                    factors.sort();
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();

                                    setState(() {
                                      isChange = (time1.value[0] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[0]) ||
                                          time1.value[1] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[1]) ||
                                          time2.value[0] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[0]) ||
                                          time2.value[1] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[1]) ||
                                          scale.value != sleepDiary!.scale ||
                                          !listEquals(factors, sleepDiary!.factors) ||
                                          (description.text != sleepDiary!.description));
                                    });
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
                                      Text(
                                        "Lingkungan",
                                        style: GoogleFonts.poppins(
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
                                    factors.sort();
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();

                                    setState(() {
                                      isChange = (time1.value[0] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[0]) ||
                                          time1.value[1] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[1]) ||
                                          time2.value[0] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[0]) ||
                                          time2.value[1] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[1]) ||
                                          scale.value != sleepDiary!.scale ||
                                          !listEquals(factors, sleepDiary!.factors) ||
                                          (description.text != sleepDiary!.description));
                                    });
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
                                      Text(
                                        "Stress",
                                        style: GoogleFonts.poppins(
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
                                    factors.sort();
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();

                                    setState(() {
                                      isChange = (time1.value[0] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[0]) ||
                                          time1.value[1] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[1]) ||
                                          time2.value[0] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[0]) ||
                                          time2.value[1] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[1]) ||
                                          scale.value != sleepDiary!.scale ||
                                          !listEquals(factors, sleepDiary!.factors) ||
                                          (description.text != sleepDiary!.description));
                                    });
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
                                      Text(
                                        "Sakit",
                                        style: GoogleFonts.poppins(
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
                                    factors.sort();
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();

                                    setState(() {
                                      isChange = (time1.value[0] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[0]) ||
                                          time1.value[1] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[1]) ||
                                          time2.value[0] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[0]) ||
                                          time2.value[1] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[1]) ||
                                          scale.value != sleepDiary!.scale ||
                                          !listEquals(factors, sleepDiary!.factors) ||
                                          (description.text != sleepDiary!.description));
                                    });
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
                                      Text(
                                        "Gelisah",
                                        style: GoogleFonts.poppins(
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
                                    factors.sort();
                                    print(factors);
                                    print(selectedFactors);
                                    selectedFactors.notifyListeners();

                                    setState(() {
                                      isChange = (time1.value[0] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[0]) ||
                                          time1.value[1] !=
                                              int.parse(sleepDiary!.sleepTime
                                                  .split(":")[1]) ||
                                          time2.value[0] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[0]) ||
                                          time2.value[1] !=
                                              int.parse(sleepDiary!.wakeupTime
                                                  .split(":")[1]) ||
                                          scale.value != sleepDiary!.scale ||
                                          !listEquals(factors, sleepDiary!.factors) ||
                                          (description.text != sleepDiary!.description));
                                    });
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
                                      Text(
                                        "Terbangun",
                                        style: GoogleFonts.poppins(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Good Job!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tingkatkan',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Perfect!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Pertahankan',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white),
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
          borderRadius: BorderRadius.circular(14),
          color: Colors.white24,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ceritakan tidurmu",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 1),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    isChange = (time1.value[0] !=
                            int.parse(sleepDiary!.sleepTime.split(":")[0]) ||
                        time1.value[1] !=
                            int.parse(sleepDiary!.sleepTime.split(":")[1]) ||
                        time2.value[0] !=
                            int.parse(sleepDiary!.wakeupTime.split(":")[0]) ||
                        time2.value[1] !=
                            int.parse(sleepDiary!.wakeupTime.split(":")[1]) ||
                        scale.value != sleepDiary!.scale ||
                        !listEquals(factors, sleepDiary!.factors) ||
                        (value != sleepDiary!.description));
                  });
                },
                controller: description,
                style: GoogleFonts.poppins(color: Colors.white),
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
                              child: Text(
                                "Sangat Buruk",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Tidur sangat buruk dan tidak memuaskan. Merasa sangat lelah dan tidak segar saat bangun pagi.',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(fontSize: 12),
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
                              child: Text(
                                "Buruk",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Tidur kurang baik, tetapi tidak seburuk skala 1. Merasa lelah atau kurang segar saat bangun pagi.',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(fontSize: 12),
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
                              child: Text(
                                "Cukup",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Tidur relatif stabil tanpa terlalu banyak gangguan. Bangun pagi dengan segar, tetapi masih ada kelelahan.',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(fontSize: 12),
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
                              child: Text(
                                "Baik",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Tidur sangat baik dan nyenyak sepanjang malam. Bangun pagi dengan perasaan segar dan bertenaga.',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(fontSize: 12),
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
                              child: Text(
                                "Sangat Baik",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Tidur sangat luar biasa, sangat nyenyak dan puas. Bangun pagi dengan perasaan segar bersemangat dan penuh energi.',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(fontSize: 12),
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
                  child: Text(
                    "Mengerti",
                    style: GoogleFonts.poppins(
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
