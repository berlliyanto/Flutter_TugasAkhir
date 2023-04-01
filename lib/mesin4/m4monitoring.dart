// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/mesin4/m4energy_usage.dart';
import 'package:flutter_application_1/mesin4/m4pressure.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class m4monitoring extends StatefulWidget {
  static const nameRoute = '/m4monitoring ';
  const m4monitoring(
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
  State<m4monitoring> createState() => _m4monitoringState();
}

class _m4monitoringState extends State<m4monitoring> {
  int? StockA, StockB, StockC, state;
  String? tipeBenda;
  void sharedpref() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getStockA = shared.getInt("A");
    var getStockB = shared.getInt("B");
    var getStockC = shared.getInt("C");
    var tipeParamM1 = shared.getString('tipeParamM1');
    var stateM1 = shared.getInt('stateParamM1');
    setState(() {
      StockA = getStockA;
      StockB = getStockB;
      StockC = getStockC;
      state = stateM1;
      tipeBenda = tipeParamM1;
    });
  }

  @override
  void initState() {
    sharedpref();
    super.initState();
  }

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
        length: m4monitoring.myTab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Mesin 4 Monitoring",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 45, 49, 83),
            toolbarHeight: blockVertical * 8,
            leading: backbutton(context),
            bottom: TabBar(
              tabs: m4monitoring.myTab,
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
                    Color.fromARGB(255, 37, 39, 59),
                    Color.fromARGB(255, 107, 100, 168),
                  ]),
            ),
            child: TabBarView(
                children: [Production(context), m4pressure(), m4energy()]),
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
                vertical: blockVertical * 1, horizontal: blockHorizontal * 3),
            height: blockVertical * 14,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: AssetImage("images/asset6.png"), fit: BoxFit.cover ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(5, 5),
                blurRadius: 5
              )]
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
                        fontSize: blockVertical * 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: blockVertical * 0.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: blockVertical * 1,
                          width: blockVertical * 1,
                          color: Color.fromARGB(255, 0, 255, 8),
                        ),
                        Text("  Running",
                            style: TextStyle(
                              fontSize: blockVertical * 1.8,
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
                      style: TextStyle(
                          fontSize: blockVertical * 2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: blockVertical * 0.5,
                    ),
                    Text((state == 1) ? "$tipeBenda" : "-",
                        style: TextStyle(
                          fontSize: blockVertical * 2,
                        )),
                    SizedBox(
                      height: blockVertical * 2,
                    ),
                    Text(
                      (state == 1) ? "Stock Bahan $tipeBenda" : "Stock Bahan -",
                      style: TextStyle(
                          fontSize: blockVertical * 2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: blockVertical * 0.5,
                    ),
                    Text(
                        (state == 1)
                            ? (tipeBenda == "A")
                                ? "$StockA"
                                : (tipeBenda == "B")
                                    ? "$StockB"
                                    : (tipeBenda == "C")
                                        ? "$StockC"
                                        : "0"
                            : "Belum Input Parameter",
                        style: TextStyle(
                          fontSize: blockVertical * 2,
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Life Time",
                      style: TextStyle(
                          fontSize: blockVertical * 2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: blockVertical * 0.5),
                    Text("91281",
                        style: TextStyle(
                          fontSize: blockVertical * 2,
                        )),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: blockVertical * 1),
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
                    height: blockVertical * 1.5,
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
                  SizedBox(
                    height: blockVertical * 1
                  ),
                  Divider(thickness: blockVertical*1),
                  SizedBox(
                    height: blockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Production",
                        style: TextStyle(
                            fontSize: blockVertical * 3,
                            fontWeight: FontWeight.bold),
                      ),
                      NilaiProduction(
                          blockHorizontal,
                          blockVertical,
                          "Processed Unit",
                          "2 Unit",
                          "Good Processed",
                          "1 Unit",
                          "Defect Unit",
                          "1 Unit"),
                    ],
                  ),
                  Divider(
                    thickness: blockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Production",
                            style: TextStyle(
                                fontSize: blockVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Time",
                            style: TextStyle(
                                fontSize: blockVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      NilaiProduction(
                          blockHorizontal,
                          blockVertical,
                          "Running Time",
                          "20 menit",
                          "Operation Time",
                          "20 menit",
                          "Downtime",
                          "5 menit"),
                    ],
                  ),
                  Divider(
                    thickness: blockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Parameter",
                        style: TextStyle(
                            fontSize: blockVertical * 3,
                            fontWeight: FontWeight.bold),
                      ),
                      NilaiProduction(
                          blockHorizontal,
                          blockVertical,
                          "Loading Time",
                          "5 menit",
                          "Cycle Time",
                          "0.1 menit",
                          "OEE Target",
                          "85 %"),
                    ],
                  ),
                  SizedBox(
                    height: blockVertical * 5,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget NilaiProduction(
    double blockHorizontal,
    double blockVertical,
    String baris1,
    String subBaris1,
    String baris2,
    String subBaris2,
    String baris3,
    String subBaris3,
  ) {
    return Container(
      height: blockVertical * 20,
      width: blockHorizontal * 40,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
              colors: [
                Color.fromARGB(255, 180, 179, 179).withOpacity(0.5),
                Color.fromARGB(255, 182, 182, 182).withOpacity(0.2),
              ]),
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(blockVertical * 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            baris1,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: blockVertical * 1.8),
          ),
          Text(
            subBaris1,
            style: TextStyle(fontSize: blockVertical * 1.8),
          ),
          Divider(color: Colors.transparent, thickness:blockVertical*0.5,),
          Text(
            baris2,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: blockVertical * 1.8),
          ),
          Text(
            subBaris2,
            style: TextStyle(fontSize: blockVertical * 1.8),
          ),
          Divider(color: Colors.transparent, thickness:blockVertical*0.5),
          Text(
            baris3,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: blockVertical * 1.8),
          ),
          Text(
            subBaris3,
            style: TextStyle(fontSize: blockVertical * 1.8),
          ),
        ],
      ),
    );
  }
}
