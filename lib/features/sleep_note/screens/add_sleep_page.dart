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
  var hour1 = 0;
  var minutes1 = 0;
  var hour2 = 0;
  var minutes2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 238, 225, 1),
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
              height: 20,
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
                      fontSize: 25, fontWeight: FontWeight.w800),
                ),
                const Text(
                  "SleepDiary",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                ),
              ],
            )
          ],
        ));
  }

  Widget _addTime() {
    return AspectRatio(
      aspectRatio: 336 / 250,
      child: Column(
        children: [
          const Text("Pilih jam tidurmu"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Row(
                  children: [
                    NumberPicker(
                      minValue: 0,
                      maxValue: 24,
                      value: hour1,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemHeight: 80,
                      itemWidth: 60,
                      onChanged: (value) {
                        setState(
                          () {
                            hour1 = value;
                          },
                        );
                      },
                      selectedTextStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    NumberPicker(
                      minValue: 0,
                      maxValue: 59,
                      value: minutes1,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemHeight: 80,
                      itemWidth: 60,
                      onChanged: (value) {
                        setState(
                          () {
                            minutes1 = value;
                          },
                        );
                      },
                      selectedTextStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const Text(
                "-",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Container(
                child: Row(
                  children: [
                    NumberPicker(
                      minValue: 0,
                      maxValue: 24,
                      value: hour2,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemHeight: 80,
                      itemWidth: 60,
                      onChanged: (value) {
                        setState(
                          () {
                            hour2 = value;
                          },
                        );
                      },
                      selectedTextStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    NumberPicker(
                      minValue: 0,
                      maxValue: 59,
                      value: minutes2,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemHeight: 80,
                      itemWidth: 60,
                      onChanged: (value) {
                        setState(
                          () {
                            minutes2 = value;
                          },
                        );
                      },
                      selectedTextStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700),
                    ),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                OutlinedButton(
                    onPressed: () => _info(context),
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
                    image: const AssetImage('assets/images/18.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/19.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/20.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/2.png'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/1.png'),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
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
                        const Text("Lingkungan")
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
                          Text("Stress")
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
                          Text("Sakit")
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
                          Text("Gelisah")
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
                          Text("Terbangun")
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
        child: const Text(
          "Ceritakan tidurmu",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<void> _info(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Information'),
            content: Container(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: AssetImage('assets/images/18.png'),
                          height: 50,
                          width: 50,
                        ),
                        Column(
                          children: [
                            Container(
                              child: Title(
                                  color: Colors.black,
                                  child: Text(
                                    "Sangat Buruk",
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Flexible(
                              child: Text(
                                "Tidur sangat buruk dan tidak memuaskan",
                                style: TextStyle(fontSize: 2),
                                textAlign: TextAlign.left,
                                maxLines: 3,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "Merasa sangat lelah dan tidak segar saat bangun pagi",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       Image(
                  //         image: AssetImage('assets/images/19.png'),
                  //         height: 50,
                  //         width: 50,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Container(

                  //           ),
                            

                  //           Text(
                  //               "Tidur kurang baik, tetapi tidak seburuk skala 1."),
                  //           Text(
                  //               "Merasa lelah atau kurang segar saat bangun pagi")
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       Image(
                  //         image: AssetImage('assets/images/20.png'),
                  //         height: 50,
                  //         width: 50,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Title(color: Colors.black, child: Text("Cukup")),
                  //           Text(
                  //               "Tidur relatif stabil tanpa terlalu banyak gangguan."),
                  //           Text(
                  //               "Bangun pagi dengan segar, tetapi masih ada kelelahan")
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       Image(
                  //         image: AssetImage('assets/images/2.png'),
                  //         height: 50,
                  //         width: 50,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Title(color: Colors.black, child: Text("Baik")),
                  //           Text(
                  //               "Tidur sangat baik dan nyenyak sepanjang malam"),
                  //           Text(
                  //               "Bangun pagi dengan perasaan segar dan bertenaga")
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       Image(
                  //         image: AssetImage('assets/images/1.png'),
                  //         height: 50,
                  //         width: 50,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Title(
                  //               color: Colors.black,
                  //               child: Text("Sangat Baik")),
                  //           Text(
                  //               "Tidur sangat luar biasa, sangat nyenyak dan puas"),
                  //           Text(
                  //               "Bangun pagi dengan perasaan segar bersemangat dan penuh energi")
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"))
            ],
          );
        });
  }
}

// Row(
//               children: [
//                 Flexible(
//                     child: Text(
//                         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"))
//               ],
//             )
