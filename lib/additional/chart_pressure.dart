import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/pressure_service.dart';
import 'package:flutter_application_1/models/pressure_model.dart';
import 'package:shimmer/shimmer.dart';

class chartPressure extends StatefulWidget {
  const chartPressure({super.key});

  @override
  State<chartPressure> createState() => _chartPressureState();
}

class _chartPressureState extends State<chartPressure> {
  StreamController<List> streamPressure = StreamController.broadcast();
  late Timer timer;
  List<pressureModel> pressureList = [];
  getPressureChart getChart = getPressureChart();
  Future<void> latestvolt() async {
    pressureList = await getChart.getPressure();
    streamPressure.add(pressureList);
  }
  List<pressurePoint> get voltage_Point{
  return pressureList.mapIndexed((index, element) => pressurePoint(x: index.toDouble(), y: element.value!.toDouble())).toList();
}
    @override
  void initState() {
    latestvolt();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      latestvolt();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder<Object>(
      stream: streamPressure.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return AspectRatio(
          aspectRatio: 16/9,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.white,
              lineBarsData: [
                LineChartBarData(
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 9, 99, 110), Color.fromARGB(255, 0, 198, 212)]),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(colors:[Color.fromARGB(255, 9, 99, 110).withOpacity(0.4), Color.fromARGB(255, 0, 198, 212).withOpacity(0.4)] )
                  ),
                  spots: voltage_Point.map((e) => FlSpot(e.x.toDouble(), e.y.toDouble())).toList(),
                  isCurved: true,
                  dotData: FlDotData(show: true),
                )
              ],
            ),
          ),
        );
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey,
              child: Container(
                height: blockVertical*18,
                width: blockHorizontal*75,
                color: Colors.white,
              ),
            ),
          );
        }
        return Center();
      }
    );
  }
}