import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/monthly_summary.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlySummaryPage extends StatefulWidget {
  final int month;
  final String textMonth;
  final int year;
  const MonthlySummaryPage(
      {super.key,
      required this.month,
      required this.year,
      required this.textMonth});

  @override
  State<MonthlySummaryPage> createState() => _MonthlySummaryState();
}

class _MonthlySummaryState extends State<MonthlySummaryPage> {
  late List<FactorData> _chartData = [];
  late TooltipBehavior _tooltipBehavior;

  String sleepTimeAverage = '0 Jam';
  double scaleAverage = 0;
  Map<String, int> factors = {
    "lingkungan": 0,
    "stress": 0,
    "sakit": 0,
    "gelisah": 0,
    "terbangun": 0
  };
  bool isLoading = false;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    getSummary();
  }

  Future<void> getSleepTimeAverage() async {
    sleepTimeAverage = await MonthlySummary()
        .getMonthlySleepTimeAverage(widget.month, widget.year);

    if (mounted) {
      setState(() {
        sleepTimeAverage = sleepTimeAverage;
      });
    }
  }

  Future<void> getScaleAverage() async {
    scaleAverage = await MonthlySummary()
        .getMonthlyScaleAverage(widget.month, widget.year);

    if (mounted) {
      setState(() {
        scaleAverage = scaleAverage;
      });
    }
  }

  Future<void> getFactors() async {
    factors =
        await MonthlySummary().getMonthlyFactors(widget.month, widget.year);

    if (mounted) {
      setState(() {
        factors = factors;
      });

      setState(() {
        _chartData = [
          FactorData('Lingkungan', factors['lingkungan']!),
          FactorData('Stress', factors['stress']!),
          FactorData('Sakit', factors['sakit']!),
          FactorData('Gelisah', factors['gelisah']!),
          FactorData('Terbangun', factors['terbangun']!),
        ];
      });
    }
  }

  void getSummary() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await getSleepTimeAverage();
    await getScaleAverage();
    await getFactors();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        title: Text(
          "Kesimpulan Bulanan",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : scaleAverage.round() == 0
              ? Center(
                  child: Column(children: [
                    const SizedBox(
                      height: 300,
                    ),
                    Image.asset(
                      'assets/images/hayo.png',
                      width: 80,
                      height: 80,
                    ),
                    Text(
                      "Hayo, Ketahuan belum isi bulan ini ...",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 14),
                    )
                  ]),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget.textMonth} ${widget.year}',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 14),
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
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          'Rerata Durasi Tidur Bulanan',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 30),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.timer_sharp,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                sleepTimeAverage,
                                                style: GoogleFonts.poppins(
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
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rerata Skala Kualitas Tidur",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Image.asset(
                                    'assets/images/skalabulan${scaleAverage.round()}.png',
                                    width: 180,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    getSleepScaleText(scaleAverage.round()),
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
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
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Faktor Penganggu Tidur",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
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
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          isVisible: false,
                                        ),
                                        cornerStyle: CornerStyle.bothCurve,
                                        enableTooltip: true,
                                        maximumValue: 31,
                                        radius: '100%',
                                      ),
                                    ],
                                    legend: const Legend(
                                        isVisible: true,
                                        overflowMode:
                                            LegendItemOverflowMode.wrap),
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
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  "Saran yang Mungkin Membantu",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Bergaul Bang",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                const SizedBox(
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

String getSleepScaleText(int scale) {
  if (scale == 1) {
    return 'Kualitas tidurmu sangat buruk, Perbaiki!';
  } else if (scale == 2) {
    return 'Kualitas tidurmu buruk, Perbaiki!';
  } else if (scale == 3) {
    return 'Kualitas tidurmu cukup, Tingkatkan!';
  } else if (scale == 4) {
    return 'Kualitas tidurmu baik, Tingkatkan!';
  } else {
    return 'Kualitas tidurmu sempurna, Pertahankan!';
  }
}
