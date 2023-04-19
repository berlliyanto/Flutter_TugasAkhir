// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter_application_1/Services/availability_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/status_service.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/models/status_model.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Services/quality_service.dart';
import 'models/quality_model.dart';

class dashboard extends StatefulWidget {
  static const nameRoute = '/dashboard';

  const dashboard(String b, {super.key});
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late Timer timer;
  int? stateA1;
  int? stateA2,stateA3,stateA4;
  // int stateA2 = 0;
  // int stateA3 = 0;
  // int stateA4 = 0;
  //AVAILABILITY STATE
  getAvailability getAvaiState = getAvailability();
  Future<void> avaiState() async {
    getAvaiState.getState(1).then((value) {
      setState(() {
        stateA1 = value!;
      });
    });
        getAvaiState.getState(2).then((value) {
      setState(() {
        stateA2 = value!;
      });
    });
        getAvaiState.getState(3).then((value) {
      setState(() {
        stateA3 = value!;
      });
    });
        getAvaiState.getState(4).then((value) {
      setState(() {
        stateA4 = value!;
      });
    });
  }

  //PRODUCTION 
  StreamController<List> streamProd = StreamController.broadcast();
  List<dashQuality> QList = [];
  dashQualityy Quality = dashQualityy();
  Future<void> QualityData() async {
    QList = await Quality.dashQualityM();
    streamProd.add(QList);
  }

  // STREAMCONTROLLER MESIN
  StreamController<List> streamStatus = StreamController.broadcast();
  List<statusModel> status = [];
  getStatus statusState = getStatus();
  Future<void> getStatusM() async {
    status = await getStatus.readStat();
    streamStatus.add(status);
  }

  @override
  void initState() {
    avaiState();
    QualityData();
    getValidUser();
    getStatusM();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getStatusM();
      QualityData();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  bool slide = false;
  String? name, otoritas;
  Future<void> getValidUser() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getName = shared.getString("name");
    var getOtoritas = shared.getString("otoritas");
    setState(() {
      name = getName!;
      otoritas = getOtoritas!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    // Mengetahui Orientasi Device
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        //APPBAR----------------------------------------------------------------------------------------------------------------
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          toolbarHeight: blockVertical * 6,
          centerTitle: true,
          title: Text(
            "Production Monitoring System",
            style: TextStyle(
                color: Color.fromARGB(255, 235, 235, 235),
                fontSize: blockVertical * 2,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black.withOpacity(0.2),
          shadowColor: Colors.transparent,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                FontAwesomeIcons.bars,
                size: blockVertical * 2.5,
                color: Color.fromARGB(255, 235, 235, 235),
              ),
            ),
          ),
        ),
        //DRAWER-------------------------------------------------------------------------------------------------------------------------
        drawer: drawer(),
        //LANDSCAPE-------------------------------------------------------------------------------------------------------------------
        //BODY---------------------------------------------------------------------------------------------------------------------------
        body:
            //POTRAIT------------------------------------------------------------------------------------------------------------------
            Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 217, 240, 255),
            image: DecorationImage(
                image: AssetImage('images/asset20.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: blockVertical * 10,
            ),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Color.fromARGB(255, 214, 211, 211).withOpacity(0.7),
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.9)
                ])),
            child: RefreshIndicator(
              displacement: blockVertical * 3,
              onRefresh: () async {
                await QualityData();
                await getStatusM();
                await avaiState();
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //LOGIN DATA---------------------------------------------------------------------------------------------------------
                    Padding(
                      padding: EdgeInsets.only(
                          left: blockHorizontal * 2.5,
                          bottom: blockVertical * 2,
                          top: blockVertical * 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    (name == "Berlliyanto Aji Nugraha")
                                        ? AssetImage('images/asset21.jpg')
                                        : AssetImage('images/asset11.png'),
                              ),
                              SizedBox(
                                width: blockHorizontal * 2,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello, $name",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 241, 241, 241),
                                        fontWeight: FontWeight.bold,
                                        fontSize: blockVertical * 2),
                                  ),
                                  Text(
                                    "$otoritas",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 241, 241, 241),
                                        fontSize: blockVertical * 1.5),
                                  )
                                ],
                              ),
                            ],
                          ),
                          (otoritas == "Admin")
                              ? IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, myakun,
                                        arguments: "dari dashboard");
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.user,
                                    size: blockVertical * 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    //STATUS MESIN--------------------------------------------------------------------------------------------------------------
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: blockHorizontal * 3),
                      child: Container(
                        padding: EdgeInsets.only(top: blockVertical * 1.5),
                        height: blockVertical * 15,
                        width: MediaQuerywidth,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 25, 134),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('images/asset10.png'),
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: blockHorizontal * 3),
                              child: Text(
                                "Active Machine",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: blockVertical * 2),
                              ),
                            ),
                            Expanded(
                              child: StreamBuilder<Object>(
                                  stream: streamStatus.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: status.map((e) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                  radius: blockVertical * 2.8,
                                                  backgroundColor:
                                                      (e.status == 1)
                                                          ? Colors.green
                                                          : Colors.red,
                                                  child: Icon(
                                                    (e.status == 1)
                                                        ? FontAwesomeIcons.check
                                                        : FontAwesomeIcons.x,
                                                    color: Colors.white,
                                                    size: blockVertical * 2.5,
                                                  )),
                                              SizedBox(
                                                height: blockVertical * 0.5,
                                              ),
                                              Text(
                                                "Machine ${e.machine_id}",
                                                style: TextStyle(
                                                    fontSize:
                                                        blockVertical * 1.5,
                                                    color: Colors.white),
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          shimmerKonek(
                                              blockVertical, blockHorizontal),
                                          shimmerKonek(
                                              blockVertical, blockHorizontal),
                                          shimmerKonek(
                                              blockVertical, blockHorizontal),
                                          shimmerKonek(
                                              blockVertical, blockHorizontal),
                                        ],
                                      );
                                    }
                                    return CircleAvatar();
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //BODY MENU-------------------------------------------------------------------------------------------------------------
                    Container(
                      padding: EdgeInsets.only(top: blockVertical * 1),
                      margin: EdgeInsets.only(top: blockVertical * 2),
                      height: blockVertical * 90,
                      width: MediaQuerywidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: blockVertical * 0.5,
                              width: blockHorizontal * 10,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          SizedBox(
                            height: blockVertical * 2,
                          ),
                          //MENU MESIN--------------------------------------------------------------------------------------------------
                          Container(
                            height: blockVertical * 10,
                            width: MediaQuerywidth,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                menuMesin(
                                    "Machine 1",
                                    FontAwesomeIcons.mobileButton,
                                    Color.fromARGB(255, 0, 16, 247)
                                        .withOpacity(0.5),
                                    mym1home),
                                menuMesin(
                                    "Machine 2",
                                    FontAwesomeIcons.mobileButton,
                                    Color.fromARGB(255, 58, 97, 203)
                                        .withOpacity(0.5),
                                    mym2home),
                                menuMesin(
                                    "Machine 3",
                                    FontAwesomeIcons.mobileButton,
                                    Color.fromARGB(255, 0, 250, 208)
                                        .withOpacity(0.5),
                                    mym3home),
                                menuMesin(
                                    "Machine 4",
                                    FontAwesomeIcons.mobileButton,
                                    Color.fromARGB(255, 8, 145, 150)
                                        .withOpacity(0.5),
                                    mym4home),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: blockVertical * 1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 20),
                            child: Text(
                              "Production",
                              style: TextStyle(
                                  fontSize: blockVertical * 3,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          //SLIDER PRODCUTION-------------------------------------------------------------------------------------------
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            height: blockVertical * 30,
                            width: MediaQuerywidth,
                            color: Colors.transparent,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return StreamBuilder<Object>(
                                    stream: streamProd.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return CarouselSlider(
                                          items: QList.map((e) {
                                            //Mesin----------------------------------------------------------
                                            return menuProduction(
                                                constraints,
                                                (e.machine_id == 1)
                                                    ? Color.fromARGB(
                                                        255, 87, 89, 236)
                                                    : (e.machine_id == 2)
                                                        ? Color.fromARGB(255, 58, 97, 203)
                                                        : (e.machine_id == 3)
                                                            ? Color.fromARGB(255, 92, 192, 179)
                                                            : Color.fromARGB(255, 28, 182, 209),
                                                (e.machine_id == 1)
                                                    ? Color.fromARGB(
                                                        255, 18, 2, 240)
                                                    : (e.machine_id == 2)
                                                        ? Color.fromARGB(
                                                            255, 13, 89, 177)
                                                        : (e.machine_id == 3)
                                                            ? Color.fromARGB(255, 0, 185, 169)
                                                            : Color.fromARGB(255, 0, 139, 139),
                                                "Machine ${e.machine_id}",
                                                (e.machine_id == 1)
                                                    ? mym1monitoring
                                                    : (e.machine_id == 2)
                                                        ? mym2monitoring
                                                        : (e.machine_id == 3)
                                                            ? mym3monitoring
                                                            : mym4monitoring,
                                                (e.machine_id == 1 &&
                                                        stateA1 == 1)
                                                    ? " Running"
                                                    : (e.machine_id == 2 &&
                                                            stateA2 == 1)
                                                        ? " Running"
                                                        : (e.machine_id == 3 &&
                                                                stateA3 == 1)
                                                            ? " Running"
                                                            : (e.machine_id == 4 &&
                                                                    stateA4 == 1)
                                                                ? " Running"
                                                                : " Stop/Finish",
                                                (e.state == 1)
                                                    ? "Type ${e.tipe}"
                                                    : "Type -",
                                                (e.state == 1)
                                                    ? "Processed Unit : ${e.processed}"
                                                    : "Processed Unit : -",
                                                (e.state == 1) ? "Good Processed : ${e.good}" : "Good Processed : -",
                                                (e.state == 1) ? "Defect : ${e.defect}" : "Defect : -",
                                                (e.machine_id == 1 &&
                                                        stateA1 == 1)
                                                    ? Color.fromARGB(255, 24, 240, 4)
                                                    : (e.machine_id == 2 &&
                                                            stateA2 == 1)
                                                        ? Color.fromARGB(255, 24, 240, 4)
                                                        : (e.machine_id == 3 &&
                                                                stateA3 == 1)
                                                            ? Color.fromARGB(255, 24, 240, 4)
                                                            : (e.machine_id == 4 &&
                                                                    stateA4 == 1)
                                                                ? Color.fromARGB(255, 24, 240, 4)
                                                                : Color.fromARGB(255, 240, 4, 4),);
                                                
                                          }).toList(),
                                          options: CarouselOptions(
                                              autoPlay: true,
                                              enlargeCenterPage: true,
                                              enlargeFactor: 0.15),
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return ShimmerProd(constraints);
                                      }
                                      return menuProduction(
                                          constraints,
                                          Color.fromARGB(255, 87, 89, 236),
                                          Color.fromARGB(255, 2, 18, 240),
                                          "Machine -",
                                          mym1monitoring,
                                          " -",
                                          "Type -",
                                          "Processed Unit : -",
                                          "Good Processed : -",
                                          "Defect : -",
                                          Color.fromARGB(255, 240, 4, 4));
                                    });
                              },
                            ),
                          ),
                          Divider(
                            thickness: blockVertical * 1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 20),
                            child: Text(
                              "Overall Equipment Effectiveness",
                              style: TextStyle(
                                  fontSize: blockVertical * 3,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          //OEE---------------------------------------------------------------------------------------------------------------
                          CarouselSlider(
                              items: [
                                //MESIN 1-------------------------------------------
                                menuOEE(
                                    blockVertical,
                                    Color.fromARGB(255, 8, 4, 240),
                                    "Machine 1",
                                    0.8,
                                    "80 %"),
                                //MESIN 2-------------------------------------------
                                menuOEE(
                                    blockVertical,
                                    Color.fromARGB(255, 58, 97, 203),
                                    "Machine 2",
                                    0.8,
                                    "80 %"),
                                //MESIN 3-------------------------------------------
                                menuOEE(
                                    blockVertical,
                                    Color.fromARGB(255, 0, 250, 208),
                                    "Machine 3",
                                    0.8,
                                    "80 %"),
                                //MESIN 4-------------------------------------------
                                menuOEE(
                                    blockVertical,
                                    Color.fromARGB(255, 8, 145, 150),
                                    "Machine 4",
                                    0.8,
                                    "80 %"),
                              ],
                              options: CarouselOptions(
                                autoPlay: true,
                              )),
                          SizedBox(
                            height: blockVertical * 3,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//MENU MESIN------------------------------------------------------------------
  Widget menuMesin(
      String title, IconData icon, Color colors, String navigator) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return Container(
      color: Colors.transparent,
      height: blockVertical * 15,
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colors,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, navigator,
                        arguments: "from dashboard");
                  },
                  icon: Icon(icon)),
            ),
            SizedBox(
              height: blockVertical * 0.5,
            ),
            Text(
              title,
              style: TextStyle(fontSize: blockVertical * 1.5),
            )
          ],
        );
      }),
    );
  }

//EFEK SHIMMER ------------------------------------------------------------------
  Column shimmerKonek(double blockVertical, double blockHorizontal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey,
          child: CircleAvatar(
            radius: blockVertical * 2.8,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          height: blockVertical * 0.5,
        ),
        Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey,
          child: Container(
            height: blockVertical * 1.5,
            width: blockHorizontal * 15,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(blockVertical * 0.5)),
          ),
        )
      ],
    );
  }

  Widget ShimmerProd(
    BoxConstraints constraints,
  ) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: constraints.maxHeight * 0.05,
                vertical: constraints.maxHeight * 0.05),
            height: constraints.maxHeight * 0.7,
            width: constraints.maxWidth * 0.7,
            decoration: BoxDecoration(color: Colors.white),
          ),
        ));
  }

//MENU PRODUCTION CAROUSEL-----------------------------------------------------
  Widget menuProduction(
      BoxConstraints constraints,
      Color color1,
      Color color2,
      String title,
      String routes,
      String status,
      String tipe,
      String Processed,
      String Good,
      String Defect,
      Color colorStatus) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: constraints.maxHeight * 0.05,
            vertical: constraints.maxHeight * 0.05),
        height: constraints.maxHeight * 0.805,
        width: constraints.maxWidth * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [color1, color2],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: constraints.maxHeight * 0.12,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: constraints.maxHeight * 0.2,
                  width: constraints.maxWidth * 0.15,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 110, 110, 110).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, routes,
                              arguments: "from dashboard");
                        },
                        icon: Icon(
                          FontAwesomeIcons.arrowRightLong,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.1,
                      width: constraints.maxHeight * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: colorStatus),
                    ),
                    Text(status,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxHeight * 0.08)),
                  ],
                ),
                Text(tipe,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxHeight * 0.08))
              ],
            ),
            Divider(
              thickness: constraints.maxHeight * 0.01,
            ),
            Text(Processed,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: constraints.maxHeight * 0.08)),
            Text(Good,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: constraints.maxHeight * 0.08)),
            Text(Defect,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: constraints.maxHeight * 0.08))
          ],
        ),
      ),
    );
  }

  Widget menuOEE(double blockVertical, Color color, String title,
      double percent, String Value) {
    return CircularPercentIndicator(
      progressColor: color,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 2,
      percent: percent,
      radius: blockVertical * 8,
      lineWidth: blockVertical * 2,
      header: Text(
        title,
        style: TextStyle(
          fontSize: blockVertical * 2.5,
        ),
      ),
      center: Text(
        Value,
        style: TextStyle(fontSize: blockVertical * 2),
      ),
    );
  }
}
