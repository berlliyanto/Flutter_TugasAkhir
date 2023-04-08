// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/availability_service.dart';
import 'package:flutter_application_1/Services/oee_service.dart';
import 'package:flutter_application_1/Services/param_service.dart';
import 'package:flutter_application_1/Services/performance_service.dart';
import 'package:flutter_application_1/Services/quality_service.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/models/availability_model.dart';
import 'package:flutter_application_1/models/oee_model.dart';
import 'package:flutter_application_1/models/param_model.dart';
import 'package:flutter_application_1/models/performance_model.dart';
import 'package:flutter_application_1/models/quality_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class m1oee extends StatefulWidget {
  static const nameRoute = '/m1oee';
  const m1oee(String m, {super.key});

  @override
  State<m1oee> createState() => _m1oeeState();
}

class _m1oeeState extends State<m1oee> {
  late Timer timer;
  String? tipeBenda, tipe;
  void sharedpref() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var tipeParamM1 = shared.getString('tipeParamM1');
    setState(() {
      tipeBenda = tipeParamM1;
    });
  }

  // PARAMETER
  StreamController<List> streamParam = StreamController.broadcast();
  List<ParamModel> paramList = [];
  readLatestParamM1 getLatestParamM1 = readLatestParamM1();
  Future<void> latestParam() async {
    paramList = await getLatestParamM1.getParamM1();
    streamParam.add(paramList);
  }

  //QUALITY
  StreamController<List> streamQuality = StreamController.broadcast();
  List<currentQuality> QList = [];
  getQuality Quality = getQuality();
  Future<void> QualityData() async {
    QList = await Quality.getQualityM(1, "$tipeBenda");
    streamQuality.add(QList);
  }

  //AVAILABILITY
  StreamController<List> streamAvailability = StreamController.broadcast();
  List<avaiModelM> AList = [];
  getAvailability Availability = getAvailability();
  Future<void> Avaidata() async {
    AList = await Availability.availabilityM(1);
    streamAvailability.add(AList);
  }

  //PERFORMANCE
  StreamController<List> streamPerformance = StreamController.broadcast();
  List<getPerformanceModel> PList = [];
  getPerformance Performance = getPerformance();
  Future<void> Perdata() async {
    PList = await Performance.getPerform(1);
    streamPerformance.add(AList);
  }

  //OEE
  StreamController<List> streamOEE = StreamController.broadcast();
  List<getOEEModel> OEEList = [];
  getOEE OEE = getOEE();
  Future<void> OEEdata() async {
    OEEList = await OEE.getResult(1);
    streamOEE.add(OEEList);
  }

  @override
  void initState() {
    OEEdata();
    latestParam();
    Perdata();
    Avaidata();
    QualityData();
    sharedpref();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      latestParam();
      Perdata();
      Avaidata();
      QualityData();
      OEEdata();
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

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    // Mengetahui Orientasi Device
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mesin 1 OEE",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 6, 160, 207),
          toolbarHeight: blockVertical * 8,
          leading: backbutton(context),
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder(
              stream: streamParam.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: paramList.map((param) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: blockVertical * 1),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: blockHorizontal * 2,
                                vertical: blockVertical * 1),
                            child: Container(
                              height: blockVertical * 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(3, 5),
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.circular(blockVertical * 2)),
                              child: (param.state == 1)
                                  ? StreamBuilder(
                                      stream: streamOEE.stream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children: OEEList.map((e) {
                                              dynamic oee = e.nilaioee! * 100;
                                              dynamic quality =
                                                  e.quality! * 100;
                                              dynamic availability =
                                                  e.availability! * 100;
                                              dynamic performance =
                                                  e.performance! * 100;
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                      height:
                                                          blockVertical * 0.5),
                                                  Text(
                                                    "Overall Equipment and Effectivenes",
                                                    style: TextStyle(
                                                        fontSize:
                                                            blockVertical * 2.5,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Divider(
                                                    thickness: 2,
                                                  ),
                                                  circleOEE(
                                                      blockHorizontal,
                                                      blockVertical,
                                                      (e.nilaioee <= 1.0)
                                                          ? e.nilaioee
                                                              .toDouble()
                                                          : 1.0,
                                                      oee.toStringAsFixed(2)),
                                                  SizedBox(
                                                    height: blockVertical * 2.5,
                                                  ),
                                                  rowOEE(
                                                      blockHorizontal,
                                                      blockVertical,
                                                      "${availability.toStringAsFixed(2)}",
                                                      "${performance.toStringAsFixed(2)}",
                                                      "${quality.toStringAsFixed(2)}"),
                                                ],
                                              );
                                            }).toList(),
                                          );
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Column(
                                            children: [
                                              SizedBox(
                                                  height: blockVertical * 0.5),
                                              Text(
                                                "Overall Equipment and Effectivenes",
                                                style: TextStyle(
                                                    fontSize:
                                                        blockVertical * 2.5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Divider(
                                                thickness: 2,
                                              ),
                                              Shimmer.fromColors(
                                                highlightColor: Colors.white,
                                                baseColor: Colors.grey,
                                                child: CircleAvatar(
                                                  radius: blockVertical * 10,
                                                  backgroundColor: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                height: blockVertical * 2.5,
                                              ),
                                              ShimmerrowOEE(blockHorizontal, blockVertical)
                                            ],
                                          );
                                        }
                                        return Column(
                                          children: [
                                            SizedBox(
                                                height: blockVertical * 0.5),
                                            Text(
                                              "Overall Equipment and Effectivenes",
                                              style: TextStyle(
                                                  fontSize: blockVertical * 2.5,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                            circleOEE(blockHorizontal,
                                                blockVertical, 0.0, "0"),
                                            SizedBox(
                                              height: blockVertical * 2.5,
                                            ),
                                            rowOEE(blockHorizontal,
                                                blockVertical, "0", "0", "0"),
                                          ],
                                        );
                                      })
                                  : Column(
                                      children: [
                                        SizedBox(height: blockVertical * 0.5),
                                        Text(
                                          "Overall Equipment and Effectivenes",
                                          style: TextStyle(
                                              fontSize: blockVertical * 2.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          thickness: 2,
                                        ),
                                        circleOEE(blockHorizontal,
                                            blockVertical, 0.0, "0"),
                                        SizedBox(
                                          height: blockVertical * 2.5,
                                        ),
                                        rowOEE(blockHorizontal, blockVertical,
                                            "0", "0", "0"),
                                      ],
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: blockHorizontal * 2,
                                right: blockHorizontal * 2,
                                top: blockVertical * 0.5,
                                bottom: blockVertical * 1.5),
                            child: Container(
                              height: blockVertical * 87,
                              width: MediaQuerywidth,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(blockVertical * 2),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(3, 5),
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 10,
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: blockVertical * 1,
                                  ),
                                  Text(
                                    "Availability",
                                    style: TextStyle(
                                        fontSize: blockVertical * 2.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(thickness: 2),
                                  SizedBox(
                                    height: blockVertical * 1,
                                  ),
                                  (param.state == 1)
                                      ? StreamBuilder(
                                          stream: streamAvailability.stream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Column(
                                                children: AList.map((e) {
                                                  dynamic Arate =
                                                      (e.availabilityrate! *
                                                          100);
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      percentOEE(
                                                          blockHorizontal,
                                                          blockVertical,
                                                          Color.fromARGB(
                                                              255, 0, 217, 255),
                                                          Color.fromARGB(255,
                                                              76, 175, 170),
                                                          e.availabilityrate
                                                              .toDouble(),
                                                          (Arate)
                                                              .toStringAsFixed(
                                                                  2)),
                                                      NilaiOEE(
                                                          blockHorizontal,
                                                          blockVertical,
                                                          "Running Time",
                                                          "${(e.runningtime! / 60).toStringAsFixed(2)} Menit",
                                                          "Operation Time",
                                                          "${(e.operationtime! / 60).toStringAsFixed(2)} Menit",
                                                          "Downtime",
                                                          "${(e.downtime! / 60).toStringAsFixed(2)} Menit")
                                                    ],
                                                  );
                                                }).toList(),
                                              );
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CircleBody(blockHorizontal,
                                                      blockVertical),
                                                  ShimmerBody(blockHorizontal,
                                                      blockVertical),
                                                ],
                                              );
                                            }
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                percentOEE(
                                                    blockHorizontal,
                                                    blockVertical,
                                                    Color.fromARGB(
                                                        255, 0, 217, 255),
                                                    Color.fromARGB(
                                                        255, 76, 175, 170),
                                                    0.0,
                                                    "0"),
                                                NilaiOEE(
                                                    blockHorizontal,
                                                    blockVertical,
                                                    "Running Time",
                                                    "0 Menit",
                                                    "Operation Time",
                                                    "0 Menit",
                                                    "Downtime",
                                                    "0 Menit")
                                              ],
                                            );
                                          })
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            percentOEE(
                                                blockHorizontal,
                                                blockVertical,
                                                Color.fromARGB(
                                                    255, 0, 217, 255),
                                                Color.fromARGB(
                                                    255, 76, 175, 170),
                                                0.0,
                                                "0"),
                                            NilaiOEE(
                                                blockHorizontal,
                                                blockVertical,
                                                "Running Time",
                                                "0 Menit",
                                                "Operation Time",
                                                "0 Menit",
                                                "Downtime",
                                                "0 Menit")
                                          ],
                                        ),
                                  SizedBox(
                                    height: blockVertical * 1,
                                  ),
                                  Divider(thickness: 2),
                                  Text(
                                    "Performance",
                                    style: TextStyle(
                                        fontSize: blockVertical * 2.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: blockVertical * 1,
                                  ),
                                  (param.state == 1)
                                      ? StreamBuilder(
                                          stream: streamPerformance.stream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Column(
                                                  children: PList.map((e) {
                                                dynamic Prate =
                                                    (e.performancerate! * 100);
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    percentOEE(
                                                        blockHorizontal,
                                                        blockVertical,
                                                        Color.fromARGB(
                                                            255, 255, 0, 0),
                                                        Color.fromARGB(
                                                            255, 175, 76, 76),
                                                        (e.state == 1)
                                                            ? (e.performancerate
                                                                        .toDouble() <=
                                                                    1.0)
                                                                ? e.performancerate
                                                                    .toDouble()
                                                                : 1.0
                                                            : 0.0,
                                                        (e.state == 1)
                                                            ? Prate
                                                                .toStringAsFixed(
                                                                    2)
                                                            : "-"),
                                                    NilaiOEE(
                                                        blockHorizontal,
                                                        blockVertical,
                                                        "Cycle Time",
                                                        (e.state == 1)
                                                            ? "${e.cycle_time} Menit"
                                                            : "- Menit",
                                                        "Processed Unit",
                                                        (e.state == 1)
                                                            ? "${e.processed} Unit"
                                                            : "- Menit",
                                                        "Operation Time",
                                                        (e.state == 1)
                                                            ? "${(e.operationtime! / 60).toStringAsFixed(2)} Menit"
                                                            : "- Menit")
                                                  ],
                                                );
                                              }).toList());
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CircleBody(blockHorizontal,
                                                      blockVertical),
                                                  ShimmerBody(blockHorizontal,
                                                      blockVertical),
                                                ],
                                              );
                                            }
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                percentOEE(
                                                    blockHorizontal,
                                                    blockVertical,
                                                    Color.fromARGB(
                                                        255, 255, 0, 0),
                                                    Color.fromARGB(
                                                        255, 175, 76, 76),
                                                    0.0,
                                                    "0"),
                                                NilaiOEE(
                                                    blockHorizontal,
                                                    blockVertical,
                                                    "Cycle Time",
                                                    "0 Menit",
                                                    "Good Processed",
                                                    "0 Unit",
                                                    "Operation Time",
                                                    "0 Menit")
                                              ],
                                            );
                                          })
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            percentOEE(
                                                blockHorizontal,
                                                blockVertical,
                                                Color.fromARGB(255, 255, 0, 0),
                                                Color.fromARGB(
                                                    255, 175, 76, 76),
                                                0.0,
                                                "-"),
                                            NilaiOEE(
                                                blockHorizontal,
                                                blockVertical,
                                                "Cycle Time",
                                                "0 Menit",
                                                "Good Processed",
                                                "0 Unit",
                                                "Operation Time",
                                                "0 Menit")
                                          ],
                                        ),
                                  SizedBox(
                                    height: blockVertical * 1,
                                  ),
                                  Divider(thickness: 2),
                                  Text(
                                    "Quality",
                                    style: TextStyle(
                                        fontSize: blockVertical * 2.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: blockVertical * 1,
                                  ),
                                  (param.state == 1)
                                      ? StreamBuilder(
                                          stream: streamQuality.stream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Column(
                                                children: QList.map((q) {
                                                  dynamic Qrate =
                                                      (q.qualityrate! * 100);
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      percentOEE(
                                                          blockHorizontal,
                                                          blockVertical,
                                                          Color.fromARGB(
                                                              255, 251, 255, 0),
                                                          Color.fromARGB(255,
                                                              175, 173, 76),
                                                          (q.state == 1)
                                                              ? q.qualityrate
                                                                  .toDouble()
                                                              : 0.0,
                                                          (q.state == 1)
                                                              ? Qrate
                                                                  .toStringAsFixed(
                                                                      2)
                                                              : "-"),
                                                      NilaiOEE(
                                                          blockHorizontal,
                                                          blockVertical,
                                                          "Processed Unit",
                                                          (q.state == 1)
                                                              ? "${q.processed} Unit"
                                                              : "- Unit",
                                                          "Good Processed",
                                                          (q.state == 1)
                                                              ? "${q.good} Unit"
                                                              : "- Unit",
                                                          "Defect",
                                                          (q.state == 1)
                                                              ? "${q.defect} Unit"
                                                              : "- Unit")
                                                    ],
                                                  );
                                                }).toList(),
                                              );
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CircleBody(blockHorizontal,
                                                      blockVertical),
                                                  ShimmerBody(blockHorizontal,
                                                      blockVertical),
                                                ],
                                              );
                                            }
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                percentOEE(
                                                    blockHorizontal,
                                                    blockVertical,
                                                    Color.fromARGB(
                                                        255, 251, 255, 0),
                                                    Color.fromARGB(
                                                        255, 175, 173, 76),
                                                    0.0,
                                                    "0"),
                                                NilaiOEE(
                                                    blockHorizontal,
                                                    blockVertical,
                                                    "Processed Unit",
                                                    "0 Unit",
                                                    "Good Processed",
                                                    "0 Unit",
                                                    "Defect",
                                                    "0 Unit")
                                              ],
                                            );
                                          })
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            percentOEE(
                                                blockHorizontal,
                                                blockVertical,
                                                Color.fromARGB(
                                                    255, 251, 255, 0),
                                                Color.fromARGB(
                                                    255, 175, 173, 76),
                                                0.0,
                                                "0"),
                                            NilaiOEE(
                                                blockHorizontal,
                                                blockVertical,
                                                "Processed Unit",
                                                "0 Unit",
                                                "Good Processed",
                                                "0 Unit",
                                                "Defect",
                                                "0 Unit")
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                    height: blockVertical * 80,
                    width: MediaQuerywidth,
                    color: Colors.transparent,
                    child: Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.grey,
                        child: Text(
                          'Loading',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: blockVertical * 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Center();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget NilaiOEE(
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

  Widget percentOEE(double blockHorizontal, double blockVertical, Color colors1,
      Color colors2, double value, String center) {
    return CircularPercentIndicator(
      animateFromLastPercent: true,
      radius: blockVertical * 8,
      lineWidth: 10,
      percent: value,
      backgroundColor: colors2.withOpacity(0.5),
      progressColor: colors1,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 2000,
      center: Text(
        "$center %",
        style: TextStyle(fontSize: blockVertical * 2.5),
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

  Widget CircleBody(
    double blockHorizontal,
    double blockVertical,
  ) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: blockVertical * 8,
      ),
    );
  }

  Widget rowOEE(double blockHorizontal, double blockVertical,
      String availability, String performance, String quality) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              "Availability",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: blockVertical * 2),
            ),
            Text("$availability %",
                style: TextStyle(fontSize: blockVertical * 2)),
          ],
        ),
        Column(
          children: [
            Text("Performance",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: blockVertical * 2)),
            Text("$performance %",
                style: TextStyle(fontSize: blockVertical * 2)),
          ],
        ),
        Column(
          children: [
            Text("Quality",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: blockVertical * 2)),
            Text("$quality %", style: TextStyle(fontSize: blockVertical * 2)),
          ],
        ),
      ],
    );
  }

  Widget circleOEE(double blockHorizontal, double blockVertical, double value,
      String center) {
    return Center(
      child: CircularPercentIndicator(
        radius: blockVertical * 10,
        lineWidth: 20,
        percent: value,
        backgroundColor: Colors.green.withOpacity(0.5),
        progressColor: Color.fromARGB(255, 0, 255, 8),
        circularStrokeCap: CircularStrokeCap.round,
        animateFromLastPercent: true,
        animation: true,
        animationDuration: 2000,
        center: Text(
          "$center %",
          style: TextStyle(fontSize: blockVertical * 3),
        ),
      ),
    );
  }

  Widget ShimmerrowOEE(double blockHorizontal, double blockVertical) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Container(
            height: blockVertical * 5,
            width: blockHorizontal * 80,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(blockHorizontal * 5)),
          ),
        )
      ],
    );
  }
}
