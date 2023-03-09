import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_application_1/models/graphProM1_model.dart';

class chartProduction extends StatefulWidget {
  const chartProduction({super.key, required this.points});
  final List<productionPoint> points;

  @override
  State<chartProduction> createState() => _chartProductionState();
}

class _chartProductionState extends State<chartProduction> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: widget.points.map((e) => FlSpot(e.x, e.y)).toList(),
              isCurved: false,
              dotData: FlDotData(show: true),
            )
          ],
        ),
      ),
    );
  }
}