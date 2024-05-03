import 'package:flutter/material.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/last_week_summary.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/monthly_summary.dart';

class StatistikPage extends StatefulWidget {
  const StatistikPage({super.key});

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  
  // Hanya untuk uji coba backend, boleh dihapus kalau mau dihapus
  @override
  void initState(){
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
      body: Center(
        child: Text(
          'Halaman Statistik User',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
