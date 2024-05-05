import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/last_week_summary.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/monthly_summary.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/summary.dart';

class StatistikPage extends StatefulWidget {
  const StatistikPage({super.key});

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  // Hanya untuk uji coba backend, boleh dihapus kalau mau dihapus
  @override
  void initState() {
    super.initState();
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
          child: Column(
        children: [
          const SizedBox(
            height: 600,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(38, 38, 66, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kesimpulan Mingguan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onTap: () {
                      print('ditekan');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SummaryPage()));  
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
