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
      aspectRatio: 336 / 100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bagaimana kualitas tidurmu?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.info,
                  color: Colors.black,
                  size: 30,
                ),
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
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/lingkungan.png'),
                    height: 50,
                    width: 50,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/stress.png'),
                    height: 50,
                    width: 50,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/sakit.png'),
                    height: 50,
                    width: 50,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/gelisah.png'),
                    height: 50,
                    width: 50,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const AssetImage('assets/images/terbangun.png'),
                    height: 50,
                    width: 50,
                  ),
                ),
                
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
}
