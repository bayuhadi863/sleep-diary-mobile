import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailCard extends StatefulWidget {
  const DetailCard({Key? key}) : super(key: key);

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //Tanggal
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: const Text(
            "Sabtu, 26 April 2024",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 370,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer_sharp,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "13.00 - 19.00",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "9 jam",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 370,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Kualitas Tidur",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/images/skala5.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Sangat Baik",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: const Text(
                          "Faktor yang memengaruhi",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(
                              'assets/images/gelisah.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(
                              'assets/images/gelisah.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(
                              'assets/images/gelisah.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(
                              'assets/images/gelisah.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(
                              'assets/images/gelisah.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Container(
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Deskripsi Tidur",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Tidur saya semalam terganggu oleh suara bising dari luar jendela saya. Para tetangga sepertinya mengadakan pesta di rumahnya dan suara musik yang keras terus berbunyi hingga dini hari. Saya merasa sangat kesal dan sulit untuk tertidur. Setiap kali hampir tertidur, suara tersebut kembali mengganggu tidur saya. Akibatnya, saya merasa sangat lelah dan tidak segar saat bangun pagi ini.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
