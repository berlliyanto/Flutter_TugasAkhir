// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/mesin1/m1energy_usage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class m1monitoring extends StatefulWidget {
  static const nameRoute = '/m1monitoring ';
  const m1monitoring(
    String p, {
    super.key,
  });

  static const List<Tab> myTab = [
    Tab(
      text: "Production",
      icon: Icon(FontAwesomeIcons.computer),
    ),
    Tab(
      text: "Pressure",
      icon: Icon(FontAwesomeIcons.gauge),
    ),
    Tab(
      text: "Energy Usage",
      icon: Icon(FontAwesomeIcons.boltLightning),
    ),
  ];

  @override
  State<m1monitoring> createState() => _m1monitoringState();
}

class _m1monitoringState extends State<m1monitoring> {
  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    // Mengetahui Orientasi Device
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: m1monitoring.myTab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Mesin 1 Monitoring",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 6, 160, 207),
            toolbarHeight: blockVertical * 8,
            leading: backbutton(context),
            bottom: TabBar(
              tabs: m1monitoring.myTab,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.all(5),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 29, 206, 215),
                    Color.fromARGB(255, 19, 78, 227),
                  ]),
            ),
            child: TabBarView(
                children: [Production(context), Pressure(), m1energy()]),
          ),
        ),
      ),
    );
  }

  //Production-----------------------------------------------------------------------------------------------------
  Widget Production(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: blockVertical * 1,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: blockVertical * 3, horizontal: blockHorizontal * 3),
            height: blockVertical * 14,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 190, 203, 245).withOpacity(0.2),
                    Color.fromARGB(255, 24, 161, 224).withOpacity(0.5),
                  ]),
              border: Border.all(
                  color: Color.fromARGB(0, 17, 0, 255).withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Status Mesin",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: Color.fromARGB(255, 0, 255, 8),
                        ),
                        Text("  Running",
                            style: TextStyle(
                              fontSize: 14,
                            )),
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tipe Benda",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("A",
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Stock Bahan A",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("50",
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Life Time",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text("91281",
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: blockVertical*1),
            height: blockVertical * 63,
            width: MediaQuerywidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: blockVertical * 2,
                  ),
                  //Production
                  Center(
                    child: Text(
                      "Production Monitoring System",
                      style: TextStyle(
                          fontSize: blockVertical * 2.5,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 2),
                  SizedBox(
                    height: blockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Production", style: TextStyle(fontSize: blockVertical*3, fontWeight: FontWeight.bold),),
                      Container(
                        height: blockVertical * 20,
                        width: blockHorizontal * 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                                colors: [
                                  Color.fromARGB(255, 180, 179, 179)
                                      .withOpacity(0.5),
                                  Color.fromARGB(255, 182, 182, 182)
                                      .withOpacity(0.2),
                                ]),
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Processed Unit",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("2 Unit"),
                            Divider(color: Colors.transparent),
                            Text(
                              "Flawless Unit",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("30  Unit"),
                            Divider(color: Colors.transparent),
                            Text(
                              "Defect Unit",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("1   Unit"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: blockVertical*1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Production", style: TextStyle(fontSize: blockVertical*3, fontWeight: FontWeight.bold),),
                          Text("Time", style: TextStyle(fontSize: blockVertical*3, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(
                        height: blockVertical * 20,
                        width: blockHorizontal * 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                                colors: [
                                  Color.fromARGB(255, 180, 179, 179)
                                      .withOpacity(0.5),
                                  Color.fromARGB(255, 182, 182, 182)
                                      .withOpacity(0.2),
                                ]),
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Running Time",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("2 menit"),
                            Divider(color: Colors.transparent),
                            Text(
                              "Operation Time",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("30 menit"),
                            Divider(color: Colors.transparent),
                            Text(
                              "Downtime",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("1 menit"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: blockVertical*1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Parameter", style: TextStyle(fontSize: blockVertical*3, fontWeight: FontWeight.bold),),
                      Container(
                        height: blockVertical * 20,
                        width: blockHorizontal * 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                                colors: [
                                  Color.fromARGB(255, 180, 179, 179)
                                      .withOpacity(0.5),
                                  Color.fromARGB(255, 182, 182, 182)
                                      .withOpacity(0.2),
                                ]),
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Loading Time",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("2 menit"),
                            Divider(color: Colors.transparent),
                            Text(
                              "Cycle Time",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("30 menit"),
                            Divider(color: Colors.transparent),
                            Text(
                              "OEE Target",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("1 %"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: blockVertical*5,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //Pressure-----------------------------------------------------------------------------------------------
  Widget Pressure() {
    return Padding(
      padding: EdgeInsets.all(5),
    );
  }
}
