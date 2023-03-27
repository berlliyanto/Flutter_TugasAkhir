// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/mesin1/m1energy_usage.dart';
import 'package:flutter_application_1/mesin1/m1pressure.dart';
import 'package:flutter_application_1/models/quality_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/param_service.dart';
import '../Services/quality_service.dart';
import '../Services/stock.services.dart';
import '../models/param_model.dart';
import '../models/stock_model.dart';

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
  late Timer timer;
  TextEditingController jumlah = TextEditingController();
  //STOCK
  StreamController<List> streamStock = StreamController.broadcast();
  List<stockModel> stockList = [];
  readStockM1 getstockM1 = readStockM1();
  Future<void> stockData() async {
    stockList = await getstockM1.getStockM1();
    streamStock.add(stockList);
  }

  // PARAMETER
  StreamController<List> streamParam = StreamController.broadcast();
  List<ParamModel> paramList = [];
  readLatestParamM1 getLatestParamM1 = readLatestParamM1();
  Future<void> latestParam() async {
    paramList = await getLatestParamM1.getParamM1();
    streamParam.add(paramList);
  }

  int? state;
  String? tipeBenda;
  void sharedpref() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var tipeParamM1 = shared.getString('tipeParamM1');
    var stateM1 = shared.getInt('stateParamM1');
    setState(() {
      state = stateM1;
      tipeBenda = tipeParamM1;
    });
  }

  //PRODUCTION
  StreamController<List> streamProd = StreamController.broadcast();
  List<currentQuality> QList = [];
  getQuality Quality = getQuality();
  Future<void> QualityData() async {
    QList = await Quality.getQualityM(1, "$tipeBenda");
    streamProd.add(QList);
  }

  @override
  void initState() {
    latestParam();
    QualityData();
    stockData();
    sharedpref();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      latestParam();
      stockData();
      QualityData();
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
                children: [Production(context), m1pressure(), m1energy()]),
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
          Container(
            margin: EdgeInsets.fromLTRB(
                blockHorizontal * 3, blockVertical * 1, blockHorizontal * 3, 0),
            height: blockVertical * 5,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 197, 251, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(5, 5),
                      blurRadius: 5)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("PARAMETER ", style: TextStyle(color: Colors.black, fontSize: blockVertical*2, fontWeight: FontWeight.bold),),
                CircleAvatar(
                    radius: blockVertical * 2,
                    backgroundColor:
                        (state == 1) ? Colors.green : Colors.red,
                    child: Icon(
                      (state == 1)
                          ? FontAwesomeIcons.check
                          : FontAwesomeIcons.x,
                      color: Colors.white,
                      size: blockVertical * 2.5,
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: blockVertical * 1, horizontal: blockHorizontal * 3),
            height: blockVertical * 14,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 197, 251, 255),
                image: DecorationImage(
                    image: AssetImage("images/asset6.png"), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(5, 5),
                      blurRadius: 5)
                ]),
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
                      (state == 1) ? "Stock $tipeBenda" : "Stock -",
                      style: TextStyle(
                          fontSize: blockVertical * 2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: blockVertical * 0.5,
                    ),
                    StreamBuilder(
                        stream: streamStock.stream,
                        builder: (context, snapshot) {
                          if (state == 1) {
                            if (snapshot.hasData) {
                              return Column(
                                children: stockList.map((e) {
                                  return Text(
                                    (tipeBenda == "A")
                                        ? "${e.A}"
                                        : (tipeBenda == "B")
                                            ? "${e.B}"
                                            : "${e.C}",
                                    style: TextStyle(
                                      fontSize: blockVertical * 2,
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                          }
                          return Text(
                            "No Parameter",
                            style: TextStyle(
                              fontSize: blockVertical * 2,
                            ),
                          );
                        }),
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
            height: blockVertical * 90,
            width: MediaQuerywidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
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
                  height: blockVertical * 1,
                ),
                Divider(thickness: blockVertical * 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Production",
                      style: TextStyle(
                          fontSize: blockVertical * 3,
                          fontWeight: FontWeight.bold),
                    ),
                    StreamBuilder(
                        stream: streamProd.stream,
                        builder: (context, snapshot) {
                          if (state == 1) {
                            if (snapshot.hasData) {
                              return Column(
                                children: QList.map((e) {
                                  return NilaiProduction(
                                      blockHorizontal,
                                      blockVertical,
                                      "Processed Unit",
                                      "${e.processed} Unit",
                                      "Good Processed",
                                      "${e.good} Unit",
                                      "Defect Unit",
                                      "${e.defect} Unit");
                                }).toList(),
                              );
                            }
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ShimmerBody(blockHorizontal, blockVertical);
                          }
                          return NilaiProduction(
                              blockHorizontal,
                              blockVertical,
                              "Processed Unit",
                              "- Unit",
                              "Good Processed",
                              "- Unit",
                              "Defect Unit",
                              "- Unit");
                        }),
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
                    StreamBuilder<Object>(
                        stream: streamParam.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: paramList.map((e) {
                                return NilaiProduction(
                                    blockHorizontal,
                                    blockVertical,
                                    "Loading Time",
                                    (e.state == 1)
                                        ? "${e.loading_time} menit"
                                        : "- menit",
                                    "Cycle Time",
                                    (e.state == 1)
                                        ? "${e.cycle_time} menit"
                                        : "- menit",
                                    "OEE Target",
                                    (e.state == 1)
                                        ? "${e.oee_target} %"
                                        : "- %");
                              }).toList(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ShimmerBody(blockHorizontal, blockVertical);
                          }
                          return NilaiProduction(
                              blockHorizontal,
                              blockVertical,
                              "Loading Time",
                              "- menit",
                              "Cycle Time",
                              "- menit",
                              "OEE Target",
                              "- %");
                        }),
                  ],
                ),
                Divider(
                  thickness: blockVertical * 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockHorizontal * 5,
                      vertical: blockVertical * 2),
                  child: buttonDefect(blockHorizontal, blockVertical),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockHorizontal * 5,
                      vertical: blockVertical * 0),
                  child: buttonSession(blockHorizontal, blockVertical),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget ShimmerBody(
    double blockHorizontal,
    double blockVertical,
  ) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height: blockVertical * 20,
        width: blockHorizontal * 40,
        decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(blockVertical * 1)),
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
          Divider(
            color: Colors.transparent,
            thickness: blockVertical * 0.5,
          ),
          Text(
            baris2,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: blockVertical * 1.8),
          ),
          Text(
            subBaris2,
            style: TextStyle(fontSize: blockVertical * 1.8),
          ),
          Divider(color: Colors.transparent, thickness: blockVertical * 0.5),
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

  Widget buttonSession(double blockHorizontal, double blockVertical) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: blockHorizontal * 100,
        height: blockVertical * 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(212, 2, 84, 122),
                  Color.fromARGB(235, 14, 61, 99)
                ])),
        child: Material(
          type: MaterialType.canvas,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            highlightColor: Color.fromARGB(255, 0, 214, 214),
            radius: blockVertical * 10,
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Center(
              child: Text(
                "Save Report and Create New Session",
                style: TextStyle(
                    fontSize: blockVertical * 2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonDefect(double blockHorizontal, double blockVertical) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: blockHorizontal * 100,
        height: blockVertical * 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(211, 122, 2, 18),
                  Color.fromARGB(235, 99, 14, 14)
                ])),
        child: Material(
          type: MaterialType.canvas,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            highlightColor: Color.fromARGB(255, 255, 0, 0),
            radius: blockVertical * 10,
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.noHeader,
                      useRootNavigator: true,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Masukkan Defect Unit",
                            style: TextStyle(
                                fontSize: blockVertical * 2.5,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: blockVertical * 1.5,
                          ),
                          TextField(
                            controller: jumlah,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Isi Jumlah Defect (unit)"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "*Jika Tidak Ada Defect Mohon Masukan nilai 0",
                                style: TextStyle(fontSize: blockVertical * 1.3),
                              ),
                            ],
                          )
                        ],
                      ),
                      btnOkText: "Add",
                      btnOkIcon: FontAwesomeIcons.plus,
                      btnOkOnPress: () {
                        inputDefect.defectQuality(
                            int.parse(jumlah.text), 1, "$tipeBenda");
                      },
                      btnCancelIcon: FontAwesomeIcons.ban,
                      btnCancelOnPress: () {})
                  .show();
            },
            child: Center(
              child: Text(
                "Input Defect Unit",
                style: TextStyle(
                    fontSize: blockVertical * 2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
