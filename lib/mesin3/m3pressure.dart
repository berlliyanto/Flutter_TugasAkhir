// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/additional/chart_pressure.dart';
import 'package:flutter_application_1/models/pressure_model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_application_1/Services/pressure_service.dart';
import 'package:shimmer/shimmer.dart';

class m3pressure extends StatefulWidget {
  const m3pressure({super.key});

  @override
  State<m3pressure> createState() => _m3pressureState();
}
class _m3pressureState extends State<m3pressure> {
  late Timer timer;
  final StreamController<List> streamGauge = StreamController.broadcast();
  List<pressureGauge> GaugeData = [];
  getPressureGauge getPress = getPressureGauge();
    Future<void> pressGauges() async {
     GaugeData = await getPress.getValue();
    streamGauge.add(GaugeData);
  }
   @override
  void initState() {
    pressGauges();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      pressGauges();
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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: blockVertical*1, left: blockHorizontal*1,right: blockHorizontal*1),
          height: blockVertical*45,
          width: MediaQuerywidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(blockVertical*3)
          ),
          child: StreamBuilder(
            stream: streamGauge.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Column(
                  children: GaugeData.map((e) {
                    return SizedBox(
                      height: blockVertical*45,
                      width: blockVertical*45,
                      child: SfRadialGauge(
                      title: GaugeTitle(text: "Tekanan Angin", textStyle: TextStyle(fontSize: blockVertical*3, fontWeight: FontWeight.bold)),
                      axes: [
                        RadialAxis(
                          minimum: 0,
                          maximum: 16,
                          pointers: [
                            NeedlePointer(value: e.value.toDouble(), enableAnimation: true,)
                          ],
                          ranges: [
                            GaugeRange(startValue: 0, endValue: e.value.toDouble(), color: Colors.green,),
                          ],
                          annotations: [
                            GaugeAnnotation(widget: Text("${e.value}", style: TextStyle(fontSize: blockVertical*3, fontWeight: FontWeight.bold),),
                            positionFactor: 0.5,
                            angle: 90,),
                            GaugeAnnotation(widget: Text("bar", style: TextStyle(fontSize: blockVertical*1.5, fontWeight: FontWeight.bold),),
                            positionFactor: 0.65,
                            angle: 90,)
                          ],
                        ),
                      ],
                                      ),
                    );
                  }).toList(),
                );
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: Text(
                      'Loading',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: blockVertical*5,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return SfRadialGauge();
            }
          ),
        ),
        SizedBox(height: blockVertical*2,),
        chartPressure(),
      ],
    );
  }
}
