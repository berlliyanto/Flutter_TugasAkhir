// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/energy_service.dart';
import 'package:flutter_application_1/additional/chart_energy.dart';
import 'package:flutter_application_1/models/energy_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class m2energy extends StatefulWidget {
  const m2energy({super.key});

  @override
  State<m2energy> createState() => _m2energyState();
}

class _m2energyState extends State<m2energy> {
  bool state = true;
// STREAMCONTROLLER
  late Timer timer;
  StreamController<List> streamEnergy = StreamController.broadcast();
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
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: blockVertical * 7,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Monitoring Energy",
                      style: TextStyle(
                          fontSize: blockVertical * 3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                (state)
                    ? Container(
                        margin: EdgeInsets.only(bottom: blockVertical * 4),
                        height: blockVertical * 70,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(0.5)),
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                                colors: [
                                  Color.fromARGB(255, 243, 242, 242)
                                      .withOpacity(0.5),
                                  Color.fromARGB(255, 189, 189, 189)
                                      .withOpacity(0.2)
                                ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return StreamBuilder<Object>(
                              stream: streamEnergy.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: energy.map((e) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              content(
                                                  context,
                                                  constraints,
                                                  FontAwesomeIcons.bolt,
                                                  "Current",
                                                  "${e.current} A"),
                                              content(
                                                  context,
                                                  constraints,
                                                  FontAwesomeIcons
                                                      .boltLightning,
                                                  "Voltage",
                                                  "${e.voltage} VAC")
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                constraints.maxHeight * 0.05,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              content(
                                                  context,
                                                  constraints,
                                                  FontAwesomeIcons.batteryHalf,
                                                  "Power",
                                                  "${e.power} W"),
                                              content(
                                                  context,
                                                  constraints,
                                                  FontAwesomeIcons.carBattery,
                                                  "Energy",
                                                  "${e.energy} KWh")
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                constraints.maxHeight * 0.05,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              content(
                                                  context,
                                                  constraints,
                                                  FontAwesomeIcons.signal,
                                                  "Frequency",
                                                  "${e.frequency} Hz"),
                                              content(
                                                  context,
                                                  constraints,
                                                  FontAwesomeIcons.explosion,
                                                  "Power Factor",
                                                  "${e.pf}")
                                            ],
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
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
                                return Center(
                                  child: Text("error"),
                                );
                              });
                        }),
                      )
                    //CHART ENERGY--------------------------------------------------------
                    : 
                    Container(
                        margin: EdgeInsets.only(bottom: blockVertical * 4),
                        height: blockVertical * 185,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(0.5)),
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                                colors: [
                                  Color.fromARGB(255, 243, 242, 242)
                                      .withOpacity(0.5),
                                  Color.fromARGB(255, 189, 189, 189)
                                      .withOpacity(0.2)
                                ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("VOLTAGE (V)", style: TextStyle(fontSize: blockVertical*3.5, fontWeight: FontWeight.bold),),
                                chartVolt(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("CURRENT (A)", style: TextStyle(fontSize: blockVertical*3.5, fontWeight: FontWeight.bold),),
                                chartcurrent(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("POWER (W)", style: TextStyle(fontSize: blockVertical*3.5, fontWeight: FontWeight.bold),),
                                chartpower(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ENERGY (KWh)", style: TextStyle(fontSize: blockVertical*3.5, fontWeight: FontWeight.bold),),
                                chartenergy(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("FREQUENCY (Hz)", style: TextStyle(fontSize: blockVertical*3.5, fontWeight: FontWeight.bold),),
                                chartfrequency(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("POWER FACTOR", style: TextStyle(fontSize: blockVertical*3.5, fontWeight: FontWeight.bold),),
                                chartpf(),
                              ],
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: blockVertical * 2),
                padding: EdgeInsets.all(blockVertical * 0.5),
                height: blockVertical * 5,
                width: blockHorizontal * 50,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.circular(blockVertical * 3),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(3, 3),
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.linear,
                      height: blockVertical * 4,
                      width: blockHorizontal * 23.5,
                      decoration: BoxDecoration(
                          color: (state)
                              ? Color.fromARGB(255, 6, 93, 207)
                              : Color.fromARGB(255, 43, 60, 87),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              state = true;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.listOl,
                            color: (state) ? Colors.white : Colors.black,
                            size: blockVertical * 2.5,
                          )),
                    ),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.linear,
                      height: blockVertical * 4,
                      width: blockHorizontal * 23.5,
                      decoration: BoxDecoration(
                          color: (state)
                              ? Color.fromARGB(255, 43, 60, 87)
                              : Color.fromARGB(255, 6, 93, 207),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              state = false;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.chartColumn,
                            color: (state) ? Colors.black : Colors.white,
                            size: blockVertical * 2.5,
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget content(BuildContext context, dynamic constraints, IconData icon,
      String title, String text) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return Container(
      padding:
          EdgeInsets.only(top: blockVertical * 1, bottom: blockVertical * 1),
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
            size: blockVertical * 3.5,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: blockVertical * 3, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: blockVertical * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: blockVertical * 3, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
