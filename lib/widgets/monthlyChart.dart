import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/statistik.dart';

class MonthlyChart extends StatefulWidget {
  final List<ChartData> chartData;
  final List<int> monthlyScales;
  const MonthlyChart(
      {super.key, required this.chartData, required this.monthlyScales});

  @override
  State<MonthlyChart> createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: widget.monthlyScales.length.toDouble() * 30.0,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 38, 66, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: LineChart(
                LineChartData(
                  backgroundColor: Colors.transparent,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.white,
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: widget.chartData
                          .map((chartData) =>
                              FlSpot(chartData.x.toDouble(), chartData.y))
                          .toList(),
                      isCurved: false,
                      dotData: FlDotData(show: true),
                      color: const Color(0xFFFFD670),
                    ),
                  ],
                  minX: 0,
                  maxX: widget.monthlyScales.length.toDouble() + 1,
                  minY: 0,
                  maxY: 6,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 1.0,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.2),
                        strokeWidth: 1,
                        dashArray: [5, 4],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                    leftTitles: AxisTitles(sideTitles: _leftTitles),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          // Check if the value is already an integer
          if (value % 1 == 0 && value != 0) {
            // If it's an integer, return it as a Text widget
            if (value > widget.monthlyScales.length) {
              return const Text('');
            }
            return Text(
              value.toInt().toString(),
              style: const TextStyle(color: Colors.white),
            );
          } else {
            // Otherwise, return an empty Text widget (or handle it as needed)
            return const Text('');
          }
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          Widget imageWidget = const SizedBox();
          switch (value.toInt()) {
            case 1:
              imageWidget = Image.asset(
                'assets/images/skalabulan1.png',
              );
              break;
            case 2:
              imageWidget = Image.asset(
                'assets/images/skalabulan2.png',
              );
              break;
            case 3:
              imageWidget = Image.asset('assets/images/skalabulan3.png');
              break;
            case 4:
              imageWidget = Image.asset('assets/images/skalabulan4.png');
              break;
            case 5:
              imageWidget = Image.asset('assets/images/skalabulan5.png');
              break;
            case 6:
              imageWidget = const SizedBox();
            default:
              imageWidget = const SizedBox();
              break;
          }
          return imageWidget;
        },
      );
}
