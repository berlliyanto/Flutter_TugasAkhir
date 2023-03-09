// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/energy_service.dart';
import 'package:flutter_application_1/models/energy_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class m1energy extends StatefulWidget {
  const m1energy({super.key});

  @override
  State<m1energy> createState() => _m1energyState();
}

class _m1energyState extends State<m1energy> {
// STREAMCONTROLLER
late Timer timer;
StreamController<List> streamEnergy = StreamController();
List<energyModel> energy = [];
Energy listEnergy = Energy();
Future<void> get_Energy() async {
  energy = await listEnergy.getEnergy();
  streamEnergy.add(energy);
}

@override
void initState() {
  get_Energy();
  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    get_Energy();
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
    return Padding(
    padding: EdgeInsets.all(10),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Monitoring Energy",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Container(
            height: blockVertical*70,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                gradient: LinearGradient(
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                    colors: [
                      Color.fromARGB(255, 243, 242, 242).withOpacity(0.5),
                      Color.fromARGB(255, 189, 189, 189).withOpacity(0.2)
                    ]),
                borderRadius: BorderRadius.circular(20)),
            child: LayoutBuilder(builder: (context, constraints) {
              return StreamBuilder<Object>(
                stream: streamEnergy.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: energy.map((e) {
                      return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            content(context,constraints, FontAwesomeIcons.bolt, "Arus", "${e.current} A"),
                            content(context,constraints, FontAwesomeIcons.boltLightning, "Tegangan", "${e.voltage} VAC")
                          ],
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                           content(context,constraints, FontAwesomeIcons.batteryHalf, "Daya", "${e.power} W"),
                           content(context,constraints, FontAwesomeIcons.carBattery, "Energy", "${e.energy} Wh")
                          ],
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                           content(context,constraints, FontAwesomeIcons.signal, "Frequency", "${e.frequency} Hz"),
                           content(context,constraints, FontAwesomeIcons.explosion, "Power Factor", "${e.pf}")
                          ],
                        ),
                      ],
                      );
                      }).toList(),
                    );
                  }else if(snapshot.connectionState == ConnectionState.none){
                    return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          content(context,constraints, FontAwesomeIcons.bolt, "Arus", "0"),
                          content(context,constraints, FontAwesomeIcons.boltLightning, "Tegangan", "0")
                        ],
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         content(context,constraints, FontAwesomeIcons.batteryHalf, "Daya", "0"),
                         content(context,constraints, FontAwesomeIcons.carBattery, "Energy", "0")
                        ],
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         content(context,constraints, FontAwesomeIcons.batteryHalf, "Frequency", "0"),
                         content(context,constraints, FontAwesomeIcons.carBattery, "PF", "0")
                        ],
                      ),
                    ],
                  );
                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                    child: Text("error"),
                  );
                }
              );
            }),
          )
        ],
      ),
    ),
  );
  }
  Widget content(BuildContext context,dynamic constraints,IconData icon, String title, String text ) {
  final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
  return Container(
    padding: EdgeInsets.only(top: blockVertical*1, bottom: blockVertical*1),
    height: constraints.maxHeight * 0.25,
    width: constraints.maxWidth * 0.43,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromARGB(255, 214, 209, 209).withOpacity(0.2),
              Color.fromARGB(255, 80, 78, 78).withOpacity(0.5)
            ]),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.6))),
    child: Column(
      children: [
        Icon(
          icon,
          size: blockVertical*3.5,
        ),
        Text(
          title,
          style: TextStyle(fontSize: blockVertical*3, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: blockVertical*2
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: blockVertical*3, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    ),
  );
}
}

