import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class AddSleepPage extends StatefulWidget {
  const AddSleepPage({super.key});

  @override
  State<AddSleepPage> createState() => _AddSleepPageState();
}

class _AddSleepPageState extends State<AddSleepPage> {
  TimeOfDay? time = const TimeOfDay(hour: 00, minute: 00);
  var hour1 = 0;
  var minutes1 = 0;
  var hour2 = 0;
  var minutes2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // const SizedBox(
            //   height: 20,
            // ),
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
              // onTap: () async {
              //   await AuthenticationRepository.instance.logout();
              // },
              child: Container(
                height: 50,
                width: 370,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Simpan",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
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
                  DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                const Text(
                  "SleepDiary",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            )
          ],
        ));
  }

  // Widget _addTime() {
  //   return AspectRatio(
  //     aspectRatio: 336 / 130,
  //     child: Column(
  //       children: [
  //         const Text("Pilih jam tidurmu",
  //             style: TextStyle(color: Colors.white)),
  //         SizedBox(height: 35),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Container(
  //               child: Row(
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () async {
  //                       final TimeOfDay? pickedTime = await showTimePicker(
  //                         context: context,
  //                         initialTime: TimeOfDay(hour: hour1, minute: minutes1),
  //                       );
  //                       if (pickedTime != null) {
  //                         setState(() {
  //                           hour1 = pickedTime.hour;
  //                           minutes1 = pickedTime.minute;
  //                         });
  //                       }
  //                     },
  //                     child: Text(
  //                       '${hour1.toString().padLeft(2, '0')}:${minutes1.toString().padLeft(2, '0')}',
  //                       style: const TextStyle(
  //                         fontSize: 30,
  //                         fontWeight: FontWeight.w700,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                   // const Icon(Icons.access_time_outlined, color: Colors.white),
  //                 ],
  //               ),
  //             ),
  //             const Text(
  //               "-",
  //               style: TextStyle(
  //                   fontSize: 30,
  //                   fontWeight: FontWeight.w500,
  //                   color: Colors.white),
  //             ),
  //             Container(
  //               child: Row(
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () async {
  //                       final TimeOfDay? pickedTime = await showTimePicker(
  //                         context: context,
  //                         initialTime: TimeOfDay(hour: hour2, minute: minutes2),
  //                       );
  //                       if (pickedTime != null) {
  //                         setState(() {
  //                           hour2 = pickedTime.hour;
  //                           minutes2 = pickedTime.minute;
  //                         });
  //                       }
  //                     },
  //                     child: Text(
  //                       '${hour2.toString().padLeft(2, '0')}:${minutes2.toString().padLeft(2, '0')}',
  //                       style: const TextStyle(
  //                         fontSize: 30,
  //                         fontWeight: FontWeight.w700,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                   // const Icon(Icons.access_time_outlined, color: Colors.white),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
  Widget _addTime() {
    return AspectRatio(
      aspectRatio: 336 / 130,
      child: Column(
        children: [
          const Text("Pilih jam tidurmu",
              style: TextStyle(color: Colors.white)),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white24,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: hour1, minute: minutes1),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            hour1 = pickedTime.hour;
                            minutes1 = pickedTime.minute;
                          });
                        }
                      },
                      child: Text(
                        '${hour1.toString().padLeft(2, '0')}:${minutes1.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
              const Text(
                "-",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white24,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: hour2, minute: minutes2),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            hour2 = pickedTime.hour;
                            minutes2 = pickedTime.minute;
                          });
                        }
                      },
                      child: Text(
                        '${hour2.toString().padLeft(2, '0')}:${minutes2.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  AspectRatio _scale() {
    return AspectRatio(
      aspectRatio: 336 / 150,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Bagaimana kualitas tidurmu?",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                OutlinedButton(
                    onPressed: () => _scaleInfo(context),
                    child: const Icon(
                      Icons.info,
                      color: Colors.black,
                      size: 30,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/skalabulan1.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/skalabulan2.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/skalabulan3.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/skalabulan4.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/skalabulan5.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AspectRatio _factors() {
    return AspectRatio(
      aspectRatio: 336 / 100,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white24),
          child: Column(children: [
            const Text(
              "Faktor",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.start,
            ),
            // SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    splashColor: Colors.black26,
                    onTap: () {},
                    child: Container(
                        child: Column(
                      children: [
                        Ink.image(
                          image:
                              const AssetImage('assets/images/lingkungan.png'),
                          height: 50,
                          width: 50,
                        ),
                        const Text("Lingkungan",
                            style: TextStyle(color: Colors.white))
                      ],
                    ))),
                InkWell(
                    splashColor: Colors.black26,
                    onTap: () {},
                    child: Container(
                      child: Column(
                        children: [
                          Ink.image(
                            image: const AssetImage('assets/images/stress.png'),
                            height: 50,
                            width: 50,
                          ),
                          const Text("Stress",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )),
                InkWell(
                    splashColor: Colors.black26,
                    onTap: () {},
                    child: Container(
                      child: Column(
                        children: [
                          Ink.image(
                            image: const AssetImage('assets/images/sakit.png'),
                            height: 50,
                            width: 50,
                          ),
                          const Text("Sakit",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )),
                InkWell(
                    splashColor: Colors.black26,
                    onTap: () {},
                    child: Container(
                      child: Column(
                        children: [
                          Ink.image(
                            image:
                                const AssetImage('assets/images/gelisah.png'),
                            height: 50,
                            width: 50,
                          ),
                          const Text("Gelisah",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )),
                InkWell(
                    splashColor: Colors.black26,
                    onTap: () {},
                    child: Container(
                      child: Column(
                        children: [
                          Ink.image(
                            image:
                                const AssetImage('assets/images/terbangun.png'),
                            height: 50,
                            width: 50,
                          ),
                          const Text("Terbangun",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )),
              ],
            ),
          ])),
    );
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
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ceritakan tidurmu",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 1),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Expanded(
                          child: Image(
                            image: AssetImage('assets/images/skalabulan1.png'),
                            height: 30,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
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
                                  "Tidur sangat buruk dan tidak memuaskan",
                                  textAlign: TextAlign.justify),
                              const Text(
                                  "Merasa sangat lelah dan tidak segar saat bangun pagi",
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Image(
                            image: AssetImage('assets/images/skalabulan2.png'),
                            height: 30,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: <Widget>[
                              Title(
                                color: Colors.black,
                                child: const Text("Buruk",
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const Text(
                                  "Tidur kurang baik, tetapi tidak seburuk skala 1",
                                  textAlign: TextAlign.left),
                              const Text(
                                  "Merasa lelah atau kurang segar saat bangun pagi",
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Image(
                            image: AssetImage('assets/images/8.png'),
                            height: 30,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: new Column(
                            children: <Widget>[
                              Title(
                                color: Colors.black,
                                child: const Text("Cukup",
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const Text(
                                  "Tidur relatif stabil tanpa terlalu banyak gangguan",
                                  textAlign: TextAlign.left),
                              const Text(
                                  "Bangun pagi dengan segar, tetapi masih ada kelelahan",
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Image(
                            image: AssetImage('assets/images/9.png'),
                            height: 30,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: new Column(
                            children: <Widget>[
                              Title(
                                color: Colors.black,
                                child: const Text("Baik",
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const Text(
                                  "Tidur sangat baik dan nyenyak sepanjang malam",
                                  textAlign: TextAlign.left),
                              const Text(
                                  "Bangun pagi dengan perasaan segar dan bertenaga",
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Image(
                            image: AssetImage('assets/images/10.png'),
                            height: 30,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: new Column(
                            children: <Widget>[
                              Title(
                                color: Colors.black,
                                child: const Text("Sangat Baik",
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const Text(
                                  "Tidur sangat luar biasa, sangat nyenyak dan puas",
                                  textAlign: TextAlign.left),
                              const Text(
                                  "Bangun pagi dengan perasaan segar bersemangat dan penuh energi",
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        });
  }
}
