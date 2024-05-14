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
  // List<ChartData> chartData = [
  //   ChartData(1, 1),
  //   ChartData(2, 2),
  //   ChartData(3, 3),
  //   ChartData(4, 4),
  //   ChartData(5, 5),
  //   ChartData(6, 6),
  //   ChartData(7, 5),
  //   ChartData(8, 4),
  //   ChartData(9, 3),
  //   ChartData(10, 2),
  //   ChartData(11, 1),
  //   ChartData(12, 2),
  //   // ChartData(13, 3),
  //   ChartData(14, 4),
  //   ChartData(15, 5),
  //   ChartData(16, 6),
  //   ChartData(17, 5),
  //   // ChartData(18, 4),
  //   // ChartData(19, 3),
  //   // ChartData(20, 2),
  //   // ChartData(21, 1),
  //   // ChartData(22, 2),
  //   // ChartData(23, 3),
  //   // ChartData(24, 4),
  //   // ChartData(25, 5),
  //   // ChartData(26, 6),
  //   // ChartData(27, 5),
  //   // ChartData(28, 4),
  //   // ChartData(29, 3),
  //   // ChartData(30, 2),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: widget.monthlyScales.length * 30.0,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: widget.chartData
                      .map((chartData) =>
                          FlSpot(chartData.x.toDouble(), chartData.y))
                      .toList(),
                  isCurved: true,
                  dotData: FlDotData(show: true),
                ),
              ],
              minX: 0,
              maxX: widget.monthlyScales.length.toDouble() + 1,
              minY: 0,
              maxY: 6,
              borderData: FlBorderData(
                border: const Border(
                  bottom: BorderSide(),
                  left: BorderSide(),
                ),
              ),
              gridData: FlGridData(show: false),
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
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          // Check if the value is already an integer
          if (value % 1 == 0 && value != 0) {
            // If it's an integer, return it as a Text widget
            if (value > widget.monthlyScales.length) {
              return Text('');
            }
            return Text(value.toInt().toString());
          } else {
            // Otherwise, return an empty Text widget (or handle it as needed)
            return Text('');
          }
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          Widget imageWidget = SizedBox();
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
              imageWidget = SizedBox();
            default:
              imageWidget = SizedBox();
              break;
          }
          return imageWidget;
        },
      );
}
