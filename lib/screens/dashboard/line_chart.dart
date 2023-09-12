import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  // Generate random data for the chart
  final List<List<FlSpot>> data = [
    List.generate(
        12, (index) => FlSpot(index.toDouble(), Random().nextDouble() * 100)),
    List.generate(
        12, (index) => FlSpot(index.toDouble(), Random().nextDouble() * 100)),
    List.generate(
        12, (index) => FlSpot(index.toDouble(), Random().nextDouble() * 100)),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: const Color(0xff37434d),
              width: 1,
            ),
          ),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: data[0],
              isCurved: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: Colors.blue, // Set the color for this line
            ),
            LineChartBarData(
              spots: data[1],
              isCurved: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: Colors.red, // Set the color for this line
            ),
            LineChartBarData(
              spots: data[2],
              isCurved: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: Colors.black, // Set the color for this line
            ),
          ],
        ),
      ),
    );
  }
}
