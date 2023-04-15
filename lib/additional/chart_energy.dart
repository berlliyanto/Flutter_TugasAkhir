import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/energy_service.dart';
import 'package:shimmer/shimmer.dart';
// ignore: implementation_imports
import '../../models/energy_model.dart';

//VOLTAGE------------------------------------------------------------------------------------
class chartVolt extends StatefulWidget {
  const chartVolt({super.key,});

  @override
  State<chartVolt> createState() => _chartVoltState();
}

class _chartVoltState extends State<chartVolt> {
  StreamController<List> streamVolt = StreamController.broadcast();
  late Timer timer;
  List<voltModel> voltList = [];
  chartperEnergy getLatestvolt = chartperEnergy();
  Future<void> latestvolt() async {
    voltList = await getLatestvolt.getVolt();
    streamVolt.add(voltList);
  }
  List<voltPoint> get voltage_Point{
  return voltList.mapIndexed((index, element) => voltPoint(x: index.toDouble(), y: element.voltage!.toDouble())).toList();
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
      stream: streamVolt.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return AspectRatio(
          aspectRatio: 16/9,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.white,
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Color.fromARGB(255, 94, 94, 94).withOpacity(0.5),
                    strokeWidth: 1
                  );
                },
              ),
              lineBarsData: [
                LineChartBarData(
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 9, 99, 110), Color.fromARGB(255, 0, 198, 212)]),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(colors:[Color.fromARGB(255, 9, 99, 110).withOpacity(0.4), Color.fromARGB(255, 0, 198, 212).withOpacity(0.4)] ),
                    applyCutOffY: true,
                    cutOffY: 5,
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

//CURRENT------------------------------------------------------------------------------------
class chartcurrent extends StatefulWidget {
  const chartcurrent({super.key,});

  @override
  State<chartcurrent> createState() => _chartcurrentState();
}

class _chartcurrentState extends State<chartcurrent> {
  StreamController<List> streamcurrent = StreamController.broadcast();
  late Timer timer;
  List<currentModel> currentList = [];
  chartperEnergy getLatestcurrent = chartperEnergy();
  Future<void> latestcurrent() async {
    currentList = await getLatestcurrent.getCurrent();
    streamcurrent.add(currentList);
  }
  List<currentPoint> get current_Point{
  return currentList.mapIndexed((index, element) => currentPoint(x: index.toDouble(), y: element.current!.toDouble())).toList();
}
    @override
  void initState() {
    latestcurrent();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      latestcurrent();
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
      stream: streamcurrent.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return AspectRatio(
          aspectRatio: 16/9,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.white,
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Color.fromARGB(255, 94, 94, 94).withOpacity(0.5),
                    strokeWidth: 1
                  );
                },
              ),
              lineBarsData: [
                LineChartBarData(
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 9, 99, 110), Color.fromARGB(255, 0, 198, 212)]),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(colors:[Color.fromARGB(255, 9, 99, 110).withOpacity(0.4), Color.fromARGB(255, 0, 198, 212).withOpacity(0.4)] )
                  ),
                  spots: current_Point.map((e) => FlSpot(e.x.toDouble(), e.y.toDouble())).toList(),
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

//POWER------------------------------------------------------------------------------------
class chartpower extends StatefulWidget {
  const chartpower({super.key,});

  @override
  State<chartpower> createState() => _chartpowerState();
}

class _chartpowerState extends State<chartpower> {
  StreamController<List> streampower = StreamController.broadcast();
  late Timer timer;
  List<powerModel> powerList = [];
  chartperEnergy getLatestpower = chartperEnergy();
  Future<void> latestpower() async {
    powerList = await getLatestpower.getPower();
    streampower.add(powerList);
  }
  List<powerPoint> get power_Point{
  return powerList.mapIndexed((index, element) => powerPoint(x: index.toDouble(), y: element.power!.toDouble())).toList();
}
    @override
  void initState() {
    latestpower();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      latestpower();
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
      stream: streampower.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return AspectRatio(
          aspectRatio: 16/9,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.white,
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Color.fromARGB(255, 94, 94, 94).withOpacity(0.5),
                    strokeWidth: 1
                  );
                },
              ),
              lineBarsData: [
                LineChartBarData(
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 9, 99, 110), Color.fromARGB(255, 0, 198, 212)]),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(colors:[Color.fromARGB(255, 9, 99, 110).withOpacity(0.4), Color.fromARGB(255, 0, 198, 212).withOpacity(0.4)] )
                  ),
                  spots: power_Point.map((e) => FlSpot(e.x.toDouble(), e.y.toDouble())).toList(),
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

//ENERGY------------------------------------------------------------------------------------
class chartenergy extends StatefulWidget {
  const chartenergy({super.key,});

  @override
  State<chartenergy> createState() => _chartenergyState();
}

class _chartenergyState extends State<chartenergy> {
  StreamController<List> streamenergy = StreamController.broadcast();
  late Timer timer;
  List<energiModel> energyList = [];
  chartperEnergy getLatestenergy = chartperEnergy();
  Future<void> latestenergy() async {
    energyList = await getLatestenergy.getEnergi();
    streamenergy.add(energyList);
  }
  List<energyPoint> get energy_Point{
  return energyList.mapIndexed((index, element) => energyPoint(x: index.toDouble(), y: element.energy!.toDouble())).toList();
}
    @override
  void initState() {
    latestenergy();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      latestenergy();
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
      stream: streamenergy.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return AspectRatio(
          aspectRatio: 16/9,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.white,
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Color.fromARGB(255, 94, 94, 94).withOpacity(0.5),
                    strokeWidth: 1
                  );
                },
              ),
              lineBarsData: [
                LineChartBarData(
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 9, 99, 110), Color.fromARGB(255, 0, 198, 212)]),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(colors:[Color.fromARGB(255, 9, 99, 110).withOpacity(0.4), Color.fromARGB(255, 0, 198, 212).withOpacity(0.4)] )
                  ),
                  spots: energy_Point.map((e) => FlSpot(e.x.toDouble(), e.y.toDouble())).toList(),
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

//FREQUENCY------------------------------------------------------------------------------------
class chartfrequency extends StatefulWidget {
  const chartfrequency({super.key,});

  @override
  State<chartfrequency> createState() => _chartfrequencyState();
}

class _chartfrequencyState extends State<chartfrequency> {
  StreamController<List> streamfrequency = StreamController.broadcast();
  late Timer timer;
  List<frequencyModel> frequencyList = [];
  chartperEnergy getLatestfrequency = chartperEnergy();
  Future<void> latestfrequency() async {
    frequencyList = await getLatestfrequency.getFrequency();
    streamfrequency.add(frequencyList);
  }
  List<frequencyPoint> get frequency_Point{
  return frequencyList.mapIndexed((index, element) => frequencyPoint(x: index.toDouble(), y: element.frequency!.toDouble())).toList();
}
    @override
  void initState() {
    latestfrequency();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      latestfrequency();
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
      stream: streamfrequency.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return AspectRatio(
          aspectRatio: 16/9,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.white,
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Color.fromARGB(255, 94, 94, 94).withOpacity(0.5),
                    strokeWidth: 1
                  );
                },
              ),
              lineBarsData: [
                LineChartBarData(
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 9, 99, 110), Color.fromARGB(255, 0, 198, 212)]),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(colors:[Color.fromARGB(255, 9, 99, 110).withOpacity(0.4), Color.fromARGB(255, 0, 198, 212).withOpacity(0.4)] )
                  ),
                  spots: frequency_Point.map((e) => FlSpot(e.x.toDouble(), e.y.toDouble())).toList(),
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

//POWER FACTOR------------------------------------------------------------------------------------
class chartpf extends StatefulWidget {
  const chartpf({super.key,});

  @override
  State<chartpf> createState() => _chartpfState();
}

class _chartpfState extends State<chartpf> {
  StreamController<List> streampf = StreamController.broadcast();
  late Timer timer;
  List<pfModel> pfList = [];
  chartperEnergy getLatestpf = chartperEnergy();
  Future<void> latestpf() async {
    pfList = await getLatestpf.getPf();
    streampf.add(pfList);
  }
  List<pfPoint> get pf_Point{
  return pfList.mapIndexed((index, element) => pfPoint(x: index.toDouble(), y: element.pf!.toDouble())).toList();
}
    @override
  void initState() {
    latestpf();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      latestpf();
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
      stream: streampf.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return AspectRatio(
          aspectRatio: 16/9,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.white,
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Color.fromARGB(255, 94, 94, 94).withOpacity(0.5),
                    strokeWidth: 1
                  );
                },
              ),
              lineBarsData: [
                LineChartBarData(
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 9, 99, 110), Color.fromARGB(255, 0, 198, 212)]),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(colors:[Color.fromARGB(255, 9, 99, 110).withOpacity(0.4), Color.fromARGB(255, 0, 198, 212).withOpacity(0.4)] )
                  ),
                  spots: pf_Point.map((e) => FlSpot(e.x.toDouble(), e.y.toDouble())).toList(),
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