import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/current_week_summary.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/last_week_summary.dart';
import 'package:sleep_diary_mobile/screens/sleep_note/statistik.dart';

class WeeklyChart extends StatefulWidget {
  final List<ChartData> statisticChartData;
  const WeeklyChart({
    super.key,
    required this.statisticChartData,
  });

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(38, 38, 66, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.transparent,
              lineTouchData: LineTouchData(
                  touchTooltipData:
                      LineTouchTooltipData(tooltipBgColor: Colors.indigo[100])),
              lineBarsData: [
                LineChartBarData(
                  spots: widget.statisticChartData
                      .map((chartData) =>
                          FlSpot(chartData.x.toDouble(), chartData.y))
                      .toList(),
                  isCurved: true,
                  dotData: FlDotData(show: true),
                  color: Colors.white,
                ),
              ],
              minX: 0,
              maxX: 8,
              minY: 0,
              maxY: 6,
              borderData: FlBorderData(
                show: false,
              ),
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
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'Min';
              break;
            case 2:
              text = 'Sen';
              break;
            case 3:
              text = 'Sel';
              break;
            case 4:
              text = 'Rab';
              break;
            case 5:
              text = 'Kam';
              break;
            case 6:
              text = 'Jum';
              break;
            case 7:
              text = 'Sab';
              break;
            case 8:
              text = '  ';
            default:
              text = '';
              break;
          }
          return Text(
            text,
            style: const TextStyle(color: Colors.white),
          );
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          Widget imageWidget = SizedBox();
          switch (value.toInt()) {
            case 1:
              imageWidget = Container(
                margin: const EdgeInsets.only(right: 0.0),
                child: Image.asset('assets/images/skalabulan2.png'),
              );
              

              break;
            case 2:
              imageWidget = Image.asset('assets/images/skalabulan2.png');
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
