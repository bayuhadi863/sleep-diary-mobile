import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/last_week_summary.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/monthly_summary.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/monthly_summary.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/summary.dart';
import 'package:sleep_diary_mobile/widgets/monthlyChart.dart';
import 'package:sleep_diary_mobile/widgets/weeklyChart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
List<int> year = List<int>.generate(3, (int index) => 2023 + index);
// const List<String> weekly = <String>[];

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
  // String? _selectedWeekly;
  List<int> lastWeekSleepScale = [];


  // Hanya untuk uji coba backend, boleh dihapus kalau mau dihapus
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    // Set _selectedMonth to the current month
    _selectedMonth = month[now.month - 1];
    _selectedYear = now.year;
    testingSummary();
  }

  // Hanya untuk uji coba backend, boleh dihapus kalau mau dihapus
  void testingSummary() async {
    await LastWeekSummary().getLastWeekSleepTimeAverage();
    await LastWeekSummary().getLastWeekScaleAverage();
    await LastWeekSummary().getLastWeekScale();
    await LastWeekSummary().getLastWeekFactors();
    await MonthlySummary().getMonthlySleepTimeAverage(2, 2024);
    await MonthlySummary().getMonthlyScaleAverage(2, 2024);
    await MonthlySummary().getMonthlyScale(2, 2024);
    await MonthlySummary().getMonthlyFactors(2, 2024);
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
            const Text(
              "Pencapaian Tidur",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const Text(
              "Lihatlah grafik tidurmu",
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(38, 38, 66, 1),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: dropdown(context)),
                Visibility(
                  visible: _selectedItem == 'Per Minggu',
                  replacement: dropdowns(context),
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(38, 38, 66, 1),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                padding: EdgeInsets.all(10),
                // margin: EdgeInsets.all(20),
                decoration: BoxDecoration(border: Border.all()),
                child: SizedBox(
                  height: 250,
                  child: Visibility(
                    visible: _selectedItem == 'Per Minggu',
                    replacement: MonthlyChart(),
                    child: WeeklyChart(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Widget dropdownWeekly(BuildContext context) {
    return Row();
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
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: monthDropdown(context),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 38, 66, 1),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
              });
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
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedWeek = newValue;
              });
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
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedMonth = newValue;
              });
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
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                _selectedYear = newValue;
              });
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
          replacement: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kesimpulan Bulanan",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kesimpulan Mingguan",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
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
            MaterialPageRoute(builder: (context) => SummaryPage()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MonthlySummaryPage()),
          );
        }
      },
    );
  }
}
