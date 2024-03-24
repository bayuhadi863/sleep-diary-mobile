import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/sleep_diary_repository.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/home_page.dart';

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
  List<String> factors = [];
  ValueNotifier<int> scale = ValueNotifier<int>(0);
  TextEditingController description = TextEditingController();
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                final repository = SleepDiaryRepository(
                  sleepDate: DateFormat.yMMMMEEEEd('en_US').format(HomePage.today),
                  hour1: (hour1 < 10) ? "0$hour1" : hour1.toString(),
                  minute1: (minutes1 < 10) ? "0$minutes1" : minutes1.toString(),
                  hour2: (hour2 < 10) ? "0$hour2" : hour2.toString(),
                  minute2: (minutes2 < 10) ? "0$minutes2" : minutes2.toString(), 
                  scale: scale.value, 
                  factors: factors,
                  description: description.text
                );
                await repository.createSleepDiary(context);
              },
              child: Container(
                height: 50,
                width: 370,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
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
                  DateFormat.yMMMMEEEEd().format(HomePage.today),
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

  Widget _addTime() {
    return AspectRatio(
      aspectRatio: 336 / 250,
      child: Column(
        children: [
          const Text("Pilih jam tidurmu",
              style: TextStyle(color: Colors.white)),
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
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
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
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
                // decoration: BoxDecoration(

                // ),
              ),
              const Text(
                "-",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
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
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
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
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
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
                        image: const AssetImage('assets/images/6.png'),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        colorFilter: (value == 1) ? 
                          const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                          const ColorFilter.mode(Colors.transparent, BlendMode.color)
                      ),
                    );
                  }
                ),
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
                        image: const AssetImage('assets/images/7.png'),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        colorFilter: (value == 2) ? 
                          const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                          const ColorFilter.mode(Colors.transparent, BlendMode.color)
                      ),
                    );
                  }
                ),
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
                        image: const AssetImage('assets/images/8.png'),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        colorFilter: (value == 3) ? 
                          const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                          const ColorFilter.mode(Colors.transparent, BlendMode.color)
                      ),
                    );
                  }
                ),
                ValueListenableBuilder(
                  valueListenable: scale,
                  builder: (context, value, child) {
                    return InkWell(
                      splashColor: Colors.black26,
                      onTap: () {
                        scale.value = 4;
                        print(scale);
                      },
                      child: Ink.image(
                        image: const AssetImage('assets/images/9.png'),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        colorFilter: (value == 4) ? 
                          const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                          const ColorFilter.mode(Colors.transparent, BlendMode.color)
                      ),
                    );
                  }
                ),
                ValueListenableBuilder(
                  valueListenable: scale,
                  builder: (context, value, child) {
                    return InkWell(
                      splashColor: Colors.black26,
                      onTap: () {
                        scale.value = 5;
                        print(scale);
                      },
                      child: Ink.image(
                        image: const AssetImage('assets/images/10.png'),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        colorFilter: (value == 5) ? 
                          const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                          const ColorFilter.mode(Colors.transparent, BlendMode.color)
                      ),
                    );
                  }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AspectRatio _factors() {
    final ValueNotifier<List<bool>> selectedFactors = ValueNotifier<List<bool>>([false, false, false, false, false]);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ValueListenableBuilder(
                  valueListenable: selectedFactors, 
                  builder: (context, value, child){
                    return InkWell(
                      splashColor: Colors.black26,
                      onTap: () {
                          if(!selectedFactors.value[0]){
                            factors.add("lingkungan");
                            selectedFactors.value[0] = true;
                          }
                          else{
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
                              image: const AssetImage('assets/images/lingkungan.png'),
                              height: 50,
                              width: 50,
                              colorFilter: (value[0] == false) ? 
                                const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                                const ColorFilter.mode(Colors.transparent, BlendMode.color)
                            ),
                            const Text("Lingkungan",style: TextStyle(color: Colors.white))
                          ],
                        )
                      )
                    );
                  }
                ),
                ValueListenableBuilder(
                  valueListenable: selectedFactors, 
                  builder: (context, value, child){
                    return InkWell(
                      splashColor: Colors.black26,
                      onTap: () {
                        if(!selectedFactors.value[1]){
                          factors.add("stress");
                          selectedFactors.value[1] = true;
                        }
                        else{
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
                              image: const AssetImage('assets/images/stress.png'),
                              height: 50,
                              width: 50,
                              colorFilter: (value[1] == false) ? 
                                const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                                const ColorFilter.mode(Colors.transparent, BlendMode.color)
                            ),
                            const Text("Stress",style: TextStyle(color: Colors.white))
                          ],
                        )
                      )
                    );
                  }
                ),
                ValueListenableBuilder(
                  valueListenable: selectedFactors, 
                  builder: (context, value, child){
                    return InkWell(
                      splashColor: Colors.black26,
                      onTap: () {
                        if(!selectedFactors.value[2]){
                          factors.add("sakit");
                          selectedFactors.value[2] = true;
                        }
                        else{
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
                              image: const AssetImage('assets/images/sakit.png'),
                              height: 50,
                              width: 50,
                              colorFilter: (value[2] == false) ? 
                                const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                                const ColorFilter.mode(Colors.transparent, BlendMode.color)
                            ),
                            const Text("Sakit",style: TextStyle(color: Colors.white))
                          ],
                        )
                      )
                    );
                  }
                ),
                ValueListenableBuilder(
                  valueListenable: selectedFactors, 
                  builder: (context, value, child){
                    return InkWell(
                      splashColor: Colors.black26,
                      onTap: () {
                        if(!selectedFactors.value[3]){
                          factors.add("gelisah");
                          selectedFactors.value[3] = true;
                        }
                        else{
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
                              image: const AssetImage('assets/images/gelisah.png'),
                              height: 50,
                              width: 50,
                              colorFilter: (value[3] == false) ? 
                                const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                                const ColorFilter.mode(Colors.transparent, BlendMode.color)
                            ),
                            const Text("Gelisah",style: TextStyle(color: Colors.white))
                          ],
                        )
                      )
                    );
                  }
                ),
                ValueListenableBuilder(
                  valueListenable: selectedFactors, 
                  builder: (context, value, child){
                    return InkWell(
                      splashColor: Colors.black26,
                      onTap: () {
                        if(!selectedFactors.value[4]){
                          factors.add("terbangun");
                          selectedFactors.value[4] = true;
                        }
                        else{
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
                              image: const AssetImage('assets/images/terbangun.png'),
                              height: 50,
                              width: 50,
                              colorFilter: (value[4] == false) ? 
                                const ColorFilter.mode(Color.fromRGBO(8, 10, 35, 1), BlendMode.color) : 
                                const ColorFilter.mode(Colors.transparent, BlendMode.color)
                            ),
                            const Text("Terbangun",style: TextStyle(color: Colors.white))
                          ],
                        )
                      )
                    );
                  }
                ),
              ],
            ),
          ]
        )
      ),
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
            title: const Text("Information"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Image(
                            image: AssetImage('assets/images/6.png'),
                            height: 30,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: new Column(
                            children: <Widget>[
                              Title(
                                color: Colors.black,
                                child: Text(
                                  "Sangat Buruk",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text("Tidur sangat buruk dan tidak memuaskan",
                                  textAlign: TextAlign.left),
                              Text(
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
                        Expanded(
                          child: Image(
                            image: AssetImage('assets/images/7.png'),
                            height: 30,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: new Column(
                            children: <Widget>[
                              Title(
                                color: Colors.black,
                                child: Text("Buruk",
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                  "Tidur kurang baik, tetapi tidak seburuk skala 1",
                                  textAlign: TextAlign.left),
                              Text(
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
                        Expanded(
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
                                child: Text("Cukup",
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                  "Tidur relatif stabil tanpa terlalu banyak gangguan",
                                  textAlign: TextAlign.left),
                              Text(
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
                        Expanded(
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
                                child: Text("Baik",
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                  "Tidur sangat baik dan nyenyak sepanjang malam",
                                  textAlign: TextAlign.left),
                              Text(
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
                        Expanded(
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
                                child: Text("Sangat Baik",
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                  "Tidur sangat luar biasa, sangat nyenyak dan puas",
                                  textAlign: TextAlign.left),
                              Text(
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
