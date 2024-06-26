import 'dart:ffi';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/current_week_summary.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/last_week_summary.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/monthly_summary.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/monthly_summary.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/summary.dart';
import 'package:sleep_diary_mobile/widgets/monthlyChart.dart';
import 'package:sleep_diary_mobile/widgets/weeklyChart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';

const List<String> list = <String>['Per Minggu', 'Per Bulan'];
const List<String> week = <String>['Minggu ini', 'Minggu lalu'];
const List<String> month = <String>[
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];

const Map<String, int> monthNumber = {
  'Januari': 1,
  'Februari': 2,
  'Maret': 3,
  'April': 4,
  'Mei': 5,
  'Juni': 6,
  'Juli': 7,
  'Agustus': 8,
  'September': 9,
  'Oktober': 10,
  'November': 11,
  'Desember': 12
};

List<int> year = List<int>.generate(3, (int index) => 2023 + index);
// const List<String> weekly = <String>[];

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class StatistikPage extends StatefulWidget {
  const StatistikPage({super.key});

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  String? _selectedItem = 'Per Minggu';
  String? _selectedWeek = 'Minggu ini';
  String? _selectedMonth;
  int? _selectedYear;

  List<int> lastWeekScales = [0, 0, 0, 0, 0, 0, 0];
  List<int> currentWeekScales = [0, 0, 0, 0, 0, 0, 0];
  List<int> monthlyScales = [];
  List<ChartData> chartData = [];
  bool isFetchLoading = false;
  // String? _selectedWeekly;
  List<int> lastWeekSleepScale = [];
  List<int> currentWeekSleepScale = [];

  // Hanya untuk uji coba backend, boleh dihapus kalau mau dihapus
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    // Set _selectedMonth to the current month
    _selectedMonth = month[now.month - 1];
    _selectedYear = now.year;
    // testingSummary();
    fetchStatisticData();
  }

  void getMonthlyScale() async {
    // loading
    if (mounted) {
      setState(() {
        isFetchLoading = true;
      });
    }

    final monthlyScalesData = await MonthlySummary()
        .getMonthlyScale(monthNumber[_selectedMonth]!, _selectedYear!);

    if (mounted) {
      setState(() {
        monthlyScales = monthlyScalesData;
      });

      setState(() {
        chartData = [];
      });
    }

    for (int i = 0; i < monthlyScalesData.length; i++) {
      if (monthlyScalesData[i] != 0) {
        chartData.add(ChartData(i + 1, monthlyScalesData[i].toDouble()));
      }
    }

    // loading stop
    if (mounted) {
      setState(() {
        isFetchLoading = false;
      });
    }
  }

  void getLastWeekScales() async {
    // loading
    if (mounted) {
      setState(() {
        isFetchLoading = true;
      });

      final lastWeekScalesData = await LastWeekSummary().getLastWeekScale();

      setState(() {
        lastWeekScales = lastWeekScalesData;
      });

      setState(() {
        chartData = [];
      });
    }

    for (int i = 0; i < 7; i++) {
      if (lastWeekScales[i] != 0) {
        chartData.add(ChartData(i + 1, lastWeekScales[i].toDouble()));
      }
    }

    // loading stop
    if (mounted) {
      setState(() {
        isFetchLoading = false;
      });
    }
  }

  void getCurrentWeekScales() async {
    // loading
    if (mounted) {
      setState(() {
        isFetchLoading = true;
      });
    }

    final currentWeekScalesData =
        await CurrentWeekSummary().getCurrentWeekScale();

    if (mounted) {
      setState(() {
        currentWeekScales = currentWeekScalesData;
      });

      setState(() {
        chartData = [];
      });
    }

    for (int i = 0; i < 7; i++) {
      if (currentWeekScales[i] != 0) {
        chartData.add(ChartData(i + 1, currentWeekScales[i].toDouble()));
      }
    }

    // loading stop
    if (mounted) {
      setState(() {
        isFetchLoading = false;
      });
    }
  }

  void fetchStatisticData() {
    if (_selectedItem == 'Per Minggu') {
      if (_selectedWeek == 'Minggu ini') {
        getCurrentWeekScales();
      } else {
        getLastWeekScales();
      }
    } else {
      getMonthlyScale();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Pencapaian Tidur",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Text(
              "Lihatlah grafik tidurmu",
              style: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(38, 38, 66, 1),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: dropdown(context)),
                Visibility(
                  visible: _selectedItem == 'Per Minggu',
                  replacement: dropdowns(context),
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(38, 38, 66, 1),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: weekDropdown(context)),
                )
              ],
            ),

            // dropdowns(context),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                // margin: EdgeInsets.all(20),
                decoration: BoxDecoration(border: Border.all()),
                child: SizedBox(
                  height: 250,
                  child: Visibility(
                    visible: _selectedItem == 'Per Minggu',
                    replacement: isFetchLoading
                        ? Center(
                            child: LoadingAnimationWidget.flickr(
                              leftDotColor: const Color.fromRGBO(58, 58, 93, 1),
                              rightDotColor: const Color(0xFFFFD670),
                              size: 80,
                            ),
                          )
                        : MonthlyChart(
                            monthlyScales: monthlyScales,
                            chartData: chartData,
                          ),
                    child: isFetchLoading
                        ? Center(
                            child: LoadingAnimationWidget.flickr(
                              leftDotColor: const Color.fromRGBO(58, 58, 93, 1),
                              rightDotColor: const Color(0xFFFFD670),
                              size: 80,
                            ),
                          )
                        : WeeklyChart(
                            statisticChartData: chartData,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            summary(context),
          ],
        ),
      ),
    );
  }

  Widget dropdownMonthly(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Widget dropdownWeekly(BuildContext context) {
    return const Row();
  }

  Widget dropdowns(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Container(
        //   decoration: BoxDecoration(
        //       color: const Color.fromRGBO(38, 38, 66, 1),
        //       borderRadius: BorderRadius.circular(8)),
        //   padding: const EdgeInsets.symmetric(horizontal: 8),
        //   child: dropdown(context),
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //       color: const Color.fromRGBO(38, 38, 66, 1),
        //       borderRadius: BorderRadius.circular(8)),
        //   padding: const EdgeInsets.symmetric(horizontal: 8),
        //   child: weekDropdown(context),
        // ),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 38, 66, 1),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: monthDropdown(context),
        ),
        const SizedBox(
          width: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 38, 66, 1),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: yearDropdown(context),
        ),
      ],
    );
  }

  Widget dropdown(BuildContext context) {
    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedItem,
            //hint: Text("Select"),
            iconSize: 15,
            items: list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
              });

              fetchStatisticData();
            },
          ),
        ),
      ],
    );
  }

  Widget weekDropdown(BuildContext context) {
    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedWeek,
            iconSize: 15,
            items: week.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedWeek = newValue;
              });

              fetchStatisticData();
            },
          ),
        ),
      ],
    );
  }

  Widget monthDropdown(BuildContext context) {
    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedMonth,
            iconSize: 15,
            items: month.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedMonth = newValue;
              });

              fetchStatisticData();
            },
          ),
        ),
      ],
    );
  }

  Widget yearDropdown(BuildContext context) {
    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: _selectedYear,
            iconSize: 15,
            items: year.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(
                  value.toString(),
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                _selectedYear = newValue;
              });

              fetchStatisticData();
            },
          ),
        ),
      ],
    );
  }

  Widget summary(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(38, 38, 66, 1),
            borderRadius: BorderRadius.circular(8)),
        child: Visibility(
          visible: _selectedItem == 'Per Minggu',
          replacement: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kesimpulan Bulanan",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kesimpulan Mingguan",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        // Navigate to different page based on the selected item
        if (_selectedItem == 'Per Minggu') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SummaryPage(
                      selectedWeek: _selectedWeek!,
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MonthlySummaryPage(
                month: monthNumber[_selectedMonth]!,
                year: _selectedYear!,
                textMonth: _selectedMonth!,
              ),
            ),
          );
        }
      },
    );
  }
}
