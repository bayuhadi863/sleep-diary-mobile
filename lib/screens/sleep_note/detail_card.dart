
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
        backgroundColor: Colors
            .white24, // Atur warna latar belakang AppBar sesuai kebutuhan Anda
        elevation: 0, // Hilangkan bayangan di bawah AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Tambahkan ikon panah kembali
          onPressed: () {
            Navigator.pop(
                context); // Tambahkan fungsi untuk kembali ke layar sebelumnya
          },
        ),
        title: const Text(
          "Sabtu, 6 April 2024", // Teks tanggal sebagai judul AppBar
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Spacer antara teks dan kotak
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 370,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius:
                        BorderRadius.circular(10), // Atur border radius di sini
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
                    borderRadius:
                        BorderRadius.circular(10), // Atur border radius di sini
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
                        'assets/images/skala5.png', // Ubah sesuai path gambar Anda
                        width: 100, // Sesuaikan ukuran gambar
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
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius:
                        BorderRadius.circular(10), // Atur border radius di sini
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Faktor yang memengaruhi",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                  height: 200,
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
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Tidur saya semalam terganggu oleh suara bising dari luar jendela saya. Para tetangga sepertinya mengadakan pesta di rumahnya dan suara musik yang keras terus berbunyi hingga dini hari. Saya merasa sangat kesal dan sulit untuk tertidur. Setiap kali hampir tertidur, suara tersebut kembali mengganggu tidur saya. Akibatnya, saya merasa sangat lelah dan tidak segar saat bangun pagi ini.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
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
