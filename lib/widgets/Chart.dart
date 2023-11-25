import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TerminalChart extends StatelessWidget {
  final Map<String, dynamic> data = {
    "1hrs": {
      "length": 5,
      "time": [
        "2023-09-08T14:05:00Z",
        "2023-09-08T14:10:00Z",
        "2023-09-08T14:15:00Z",
        "2023-09-08T14:20:00Z",
        "2023-09-08T14:25:00Z"
      ],
      "count": [6, 5, 2, 4, 3]
    },
  };

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 0,
        maxX: data["1hrs"]["length"] - 1.0,
        minY: 0,
        maxY: data["1hrs"]["count"].reduce((a, b) => a > b ? a : b).toDouble() + 2.0,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(data["1hrs"]["length"], (index) {
              return FlSpot(index.toDouble(), data["1hrs"]["count"][index].toDouble());
            }),
            isCurved: true,
            color: Colors.blue,
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}