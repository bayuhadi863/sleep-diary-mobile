import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  late List<FactorData> _chartData = [];
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            "Kesimpulan Mingguan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
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
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Minggu Lalu',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(38, 38, 66, 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Rerata Durasi Tidur Mingguan',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 30),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer_sharp,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "7 Jam",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(38, 38, 66, 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Rerata Skala Kualitas Tidur",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/skala5.png',
                          width: 190,
                          height: 190,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Tidurmu sangat nyenyak, Pertahankan!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(38, 38, 66, 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Faktor Penganggu Tidur",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SfCircularChart(
                          backgroundColor: Colors.transparent,
                          series: <CircularSeries>[
                            RadialBarSeries<FactorData, String>(
                              useSeriesColor: true,
                              trackOpacity: 0.2,
                              dataSource: _chartData,
                              xValueMapper: (FactorData data, _) =>
                                  data.faktorPenyebab,
                              yValueMapper: (FactorData data, _) =>
                                  data.persentase,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: false,
                              ),
                              cornerStyle: CornerStyle.bothCurve,
                              enableTooltip: true,
                              maximumValue: 100,
                              radius: '100%',
                            ),
                          ],
                          legend: const Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap),
                          tooltipBehavior: _tooltipBehavior,
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(38, 38, 66, 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        "Saran yang Mungkin Membantu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Bergaul Bang",
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

  List<FactorData> getChartData() {
    final List<FactorData> chartData = [
      FactorData('Lingkungan', 70),
      FactorData('Stress', 20),
      FactorData('Sakit', 65),
      FactorData('Gelisah', 25),
      FactorData('Terbangun', 40),
    ];
    return chartData;
  }
}

class FactorData {
  FactorData(this.faktorPenyebab, this.persentase);
  final String faktorPenyebab;
  final int persentase;
}
