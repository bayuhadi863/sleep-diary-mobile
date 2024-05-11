import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyChart extends StatefulWidget {
  const WeeklyChart({Key? key}) : super(key: key);

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(0, 0),
      ChartData(1, 3),
      ChartData(2, 2),
      ChartData(3, 3),
      ChartData(4, 4),
      ChartData(5, 5),
      ChartData(6, 4),
      ChartData(7, 4)
    ];

    return Scaffold(
      body: Center(
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: chartData
                    .map((chartData) =>
                        FlSpot(chartData.x.toDouble(), chartData.y))
                    .toList(),
                isCurved: false,
                dotData: FlDotData(show: true),
              ),
            ],
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
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
              text = 'Sun';
              break;
            case 2:
              text = 'Mon';
              break;
            case 3:
              text = 'Tue';
              break;
            case 4:
              text = 'Wed';
              break;
            case 5:
              text = 'Thu';
              break;
            case 6:
              text = 'Fri';
              break;
            case 7:
              text = 'Sat';
              break;
            default:
              text = '';
              break;
          }
          return Text(text);
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          Widget imageWidget = SizedBox();
          switch (value.toInt()) {
            case 1:
              imageWidget = Image.asset('assets/images/skalabulan1.png');
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
            default:
              imageWidget = SizedBox();
              break;
          }
          return imageWidget;
        },
      );
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}