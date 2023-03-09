// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables

import 'dart:async';

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

class dashboard extends StatefulWidget {
  static const nameRoute = '/dashboard';

  const dashboard(String b, {super.key});
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late Timer timer;
  // STREAMCONTROLLER MESIN 1
  StreamController<List> streamStatusM1 = StreamController();
  List<statusModel> status = [];
  getStatusM1 statusState = getStatusM1();
  Future<void> getStatus() async {
    status = await getStatusM1.readStatM1();
    streamStatusM1.add(status);
  }

  // STREAMCONTROLLER MESIN 2
  StreamController<List> streamStatusM2 = StreamController();
  List<status2Model> status2 = [];
  getStatusM2 statusState2 = getStatusM2();
  Future<void> getStatus2() async {
    status2 = await getStatusM2.readStatM2();
    streamStatusM2.add(status);
  }

  // STREAMCONTROLLER MESIN 3
  StreamController<List> streamStatusM3 = StreamController();
  List<status3Model> status3 = [];
  getStatusM3 statusState3 = getStatusM3();
  Future<void> getStatus3() async {
    status3 = await getStatusM3.readStatM3();
    streamStatusM3.add(status);
  }

  // STREAMCONTROLLER MESIN 4
  StreamController<List> streamStatusM4 = StreamController();
  List<status4Model> status4 = [];
  getStatusM4 statusState4 = getStatusM4();
  Future<void> getStatus4() async {
    status4 = await getStatusM4.readStatM4();
    streamStatusM4.add(status);
  }

  @override
  void initState() {
    getValidUser();
    getStatus();
    getStatus2();
    getStatus3();
    getStatus4();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getStatus();
      getStatus2();
      getStatus3();
      getStatus4();
    });
    super.initState();
  }

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
                fontWeight: FontWeight.bold  
              ),
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
        body: (isLandscape)?
        Center(
          child: Text("JANGAN MODE LANDSCAPE PLIS"),
        )
        :
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
              top: blockVertical * 12,
            ),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Color.fromARGB(255, 214, 211, 211).withOpacity(0.3),
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.9)
                ])),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: (name=="Berlliyanto Aji Nugraha")? AssetImage('images/asset21.jpg'):AssetImage('images/asset12.1.png'),
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
                                  color: Color.fromARGB(255, 241, 241, 241),
                                  fontWeight: FontWeight.bold,
                                  fontSize: blockVertical * 2),
                            ),
                            Text(
                              "$otoritas",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 241, 241, 241),
                                  fontSize: blockVertical * 1.5),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  //STATUS MESIN--------------------------------------------------------------------------------------------------------------
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: blockHorizontal * 3),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, top: 10),
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
                          Text("Konektivitas Mesin", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: blockVertical*2),),
                            Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                StreamBuilder<Object>(
                                  stream: streamStatusM1.stream,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: status.map((e) {
                                          return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                            backgroundColor:(e.status==1)? Colors.green:Colors.red,
                                            child: Icon((e.status==1)?FontAwesomeIcons.check:FontAwesomeIcons.x, color: Colors.white,)
                                          ),
                                          SizedBox(
                                            height: blockVertical * 0.5,
                                          ),
                                          Text(
                                            "Mesin 1",
                                            style: TextStyle(fontSize: blockVertical * 1.5, color: Colors.white),
                                          )
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }else if(snapshot.connectionState==ConnectionState.waiting){
                                      return CircularProgressIndicator();
                                    }
                                    return CircleAvatar();
                                  }
                                ),
                                StreamBuilder<Object>(
                                  stream: streamStatusM2.stream,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: status2.map((e) {
                                          return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                            backgroundColor:(e.status==1)? Colors.green:Colors.red,
                                            child: Icon((e.status==1)?FontAwesomeIcons.check:FontAwesomeIcons.x, color: Colors.white,)
                                          ),
                                          SizedBox(
                                            height: blockVertical * 0.5,
                                          ),
                                          Text(
                                            "Mesin 2",
                                            style: TextStyle(fontSize: blockVertical * 1.5, color: Colors.white),
                                          )
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }else if(snapshot.connectionState==ConnectionState.waiting){
                                      return CircularProgressIndicator();
                                    }
                                    return CircleAvatar();
                                  }
                                ),
                                StreamBuilder<Object>(
                                  stream: streamStatusM3.stream,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: status3.map((e) {
                                          return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                            backgroundColor:(e.status==1)? Colors.green:Colors.red,
                                            child: Icon((e.status==1)?FontAwesomeIcons.check:FontAwesomeIcons.x, color: Colors.white,)
                                          ),
                                          SizedBox(
                                            height: blockVertical * 0.5,
                                          ),
                                          Text(
                                            "Mesin 3",
                                            style: TextStyle(fontSize: blockVertical * 1.5, color: Colors.white),
                                          )
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }else if(snapshot.connectionState==ConnectionState.waiting){
                                      return CircularProgressIndicator();
                                    }
                                    return CircleAvatar();
                                  }
                                ),
                                StreamBuilder<Object>(
                                  stream: streamStatusM4.stream,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: status4.map((e) {
                                          return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                            backgroundColor:(e.status==1)? Colors.green:Colors.red,
                                            child: Icon((e.status==1)?FontAwesomeIcons.check:FontAwesomeIcons.x, color: Colors.white,)
                                          ),
                                          SizedBox(
                                            height: blockVertical * 0.5,
                                          ),
                                          Text(
                                            "Mesin 4",
                                            style: TextStyle(fontSize: blockVertical * 1.5, color: Colors.white),
                                          )
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }else if(snapshot.connectionState==ConnectionState.waiting){
                                      return CircularProgressIndicator();
                                    }
                                    return CircleAvatar();
                                  }
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //BODY MENU-------------------------------------------------------------------------------------------------------------
                  Container(
                    padding: EdgeInsets.only(top: blockVertical * 1),
                    margin: EdgeInsets.only(top: blockVertical * 2),
                    height: blockVertical * 66,
                    width: MediaQuerywidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
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
                                    "Mesin 1",
                                    FontAwesomeIcons.mobileButton,
                                    Color.fromARGB(255, 0, 16, 247)
                                        .withOpacity(0.5),
                                    mym1home),
                                menuMesin(
                                    "Mesin 2",
                                    FontAwesomeIcons.mobileButton,
                                    Color.fromARGB(255, 123, 6, 190)
                                        .withOpacity(0.5),
                                    mym2home),
                                menuMesin(
                                    "Mesin 3",
                                    FontAwesomeIcons.mobileButton,
                                    Color.fromARGB(255, 71, 250, 0)
                                        .withOpacity(0.5),
                                    mym3home),
                                menuMesin(
                                    "Mesin 4",
                                    FontAwesomeIcons.mobileButton,
                                    Color.fromARGB(255, 42, 41, 77)
                                        .withOpacity(0.5),
                                    mym4home),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: blockVertical * 1,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20),
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
                                return CarouselSlider(
                                    items: [
                                      //Mesin 1----------------------------------------------------------
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          height: constraints.maxHeight * 0.7,
                                          width: constraints.maxWidth * 0.7,
                                          decoration:
                                              BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                                                Color.fromARGB(255, 87, 89, 236), Color.fromARGB(255, 2, 18, 240)
                                              ],
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Mesin 1", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.12, fontWeight: FontWeight.bold),),
                                                  Container(
                                                    height: constraints.maxHeight*0.2,
                                                    width: constraints.maxWidth*0.15,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 110, 110, 110).withOpacity(0.4),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Center(
                                                      child: IconButton(onPressed:(){
                                                        Navigator.pushNamed(context, mym1monitoring, arguments: "from dashboard");
                                                      },icon:Icon(FontAwesomeIcons.arrowRightLong, color: Colors.white,)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: constraints.maxHeight*0.05,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: constraints.maxHeight*0.1,
                                                        width: constraints.maxHeight*0.1,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 30, 255, 0)),
                                                      ),
                                                      Text(" Running",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                                    ],
                                                  ),
                                                  Text("Tipe A",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08))
                                                ],
                                              ),
                                              Divider(thickness: constraints.maxHeight*0.01,),
                                              Text("Processed Unit : ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                              Text("Flawless Unit : ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                              Text("Defect Unit: ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08))
                                            ],
                                          ),
                                        ),
                                      ),
                                      //Mesin 2----------------------------------------------------------
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          height: constraints.maxHeight * 0.7,
                                          width: constraints.maxWidth * 0.7,
                                          decoration:
                                              BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                                                Color.fromARGB(255, 189, 87, 236), Color.fromARGB(255, 145, 2, 240)
                                              ],
                                            ),),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Mesin 2", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.12, fontWeight: FontWeight.bold),),
                                                  Container(
                                                    height: constraints.maxHeight*0.2,
                                                    width: constraints.maxWidth*0.15,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 110, 110, 110).withOpacity(0.4),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Center(
                                                      child: IconButton(onPressed:(){
                                                        Navigator.pushNamed(context, mym2monitoring, arguments: "from dashboard");
                                                      },icon:Icon(FontAwesomeIcons.arrowRightLong, color: Colors.white,)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: constraints.maxHeight*0.05,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: constraints.maxHeight*0.1,
                                                        width: constraints.maxHeight*0.1,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 30, 255, 0)),
                                                      ),
                                                      Text(" Running",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                                    ],
                                                  ),
                                                  Text("Tipe A",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08))
                                                ],
                                              ),
                                              Divider(thickness: constraints.maxHeight*0.01,),
                                              Text("Processed Unit : ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                              Text("Flawless Unit : ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                              Text("Defect Unit: ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08))
                                            ],
                                          ),
                                        ),
                                      ),
                                      //Mesin 3----------------------------------------------------------
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          height: constraints.maxHeight * 0.7,
                                          width: constraints.maxWidth * 0.7,
                                          decoration:
                                              BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                                                Color.fromARGB(255, 92, 192, 97), Color.fromARGB(255, 0, 185, 15)
                                              ],
                                            ),),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Mesin 3", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.12, fontWeight: FontWeight.bold),),
                                                  Container(
                                                    height: constraints.maxHeight*0.2,
                                                    width: constraints.maxWidth*0.15,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 110, 110, 110).withOpacity(0.4),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Center(
                                                      child: IconButton(onPressed:(){
                                                        Navigator.pushNamed(context, mym3monitoring, arguments: "from dashboard");
                                                      },icon:Icon(FontAwesomeIcons.arrowRightLong, color: Colors.white,)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: constraints.maxHeight*0.05,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: constraints.maxHeight*0.1,
                                                        width: constraints.maxHeight*0.1,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 30, 255, 0)),
                                                      ),
                                                      Text(" Running",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                                    ],
                                                  ),
                                                  Text("Tipe A",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08))
                                                ],
                                              ),
                                              Divider(thickness: constraints.maxHeight*0.01,),
                                              Text("Processed Unit : ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                              Text("Flawless Unit : ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                              Text("Defect Unit: ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08))
                                            ],
                                          ),
                                        ),
                                      ),
                                      //Mesin 4----------------------------------------------------------
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          height: constraints.maxHeight * 0.7,
                                          width: constraints.maxWidth * 0.7,
                                          decoration:
                                              BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                                                Color.fromARGB(255, 129, 118, 192),
                                                Color.fromARGB(255, 40, 41, 56),
                                              ],
                                            ),),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Mesin 4", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.12, fontWeight: FontWeight.bold),),
                                                  Container(
                                                    height: constraints.maxHeight*0.2,
                                                    width: constraints.maxWidth*0.15,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 110, 110, 110).withOpacity(0.4),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Center(
                                                      child: IconButton(onPressed:(){
                                                        Navigator.pushNamed(context, mym4monitoring, arguments: "from dashboard");
                                                      },icon:Icon(FontAwesomeIcons.arrowRightLong, color: Colors.white,)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: constraints.maxHeight*0.05,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: constraints.maxHeight*0.1,
                                                        width: constraints.maxHeight*0.1,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 30, 255, 0)),
                                                      ),
                                                      Text(" Running",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                                    ],
                                                  ),
                                                  Text("Tipe A",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08))
                                                ],
                                              ),
                                              Divider(thickness: constraints.maxHeight*0.01,),
                                              Text("Processed Unit : ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                              Text("Flawless Unit : ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08)),
                                              Text("Defect Unit: ",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.08))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.15
                                    ),
                                  );
                              },
                            ),
                          ),
                          Divider(
                            thickness: blockVertical * 1,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20),
                            child: Text(
                              "Overall Equipment Effectiveness",
                              style: TextStyle(
                                  fontSize: blockVertical * 3,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          //OEE---------------------------------------------------------------------------------------------------------------
                          CarouselSlider(items: [
                              //MESIN 1-------------------------------------------
                              CircularPercentIndicator(
                                progressColor: Color.fromARGB(255, 8, 4, 240),
                                circularStrokeCap: CircularStrokeCap.round,
                                animation: true,
                                animationDuration: 2,
                                percent: 0.8,
                                radius: blockVertical*8,
                                lineWidth: blockVertical*2,
                                header: Text("Mesin 1", style: TextStyle(fontSize: blockVertical*2.5,),),
                                center: Text("80 %", style: TextStyle(fontSize: blockVertical*2),),
                              ),
                              CircularPercentIndicator(
                                progressColor: Color.fromARGB(255, 165, 4, 240),
                                circularStrokeCap: CircularStrokeCap.round,
                                animation: true,
                                animationDuration: 2,
                                percent: 0.8,
                                radius: blockVertical*8,
                                lineWidth: blockVertical*2,
                                header: Text("Mesin 2", style: TextStyle(fontSize: blockVertical*2.5,),),
                                center: Text("80 %", style: TextStyle(fontSize: blockVertical*2),),
                              ),
                              CircularPercentIndicator(
                                progressColor: Color.fromARGB(255, 24, 240, 4),
                                circularStrokeCap: CircularStrokeCap.round,
                                animation: true,
                                animationDuration: 2,
                                percent: 0.8,
                                radius: blockVertical*8,
                                lineWidth: blockVertical*2,
                                header: Text("Mesin 3", style: TextStyle(fontSize: blockVertical*2.5,),),
                                center: Text("80 %", style: TextStyle(fontSize: blockVertical*2),),
                              ),
                              CircularPercentIndicator(
                                progressColor: Color.fromARGB(255, 49, 49, 83),
                                circularStrokeCap: CircularStrokeCap.round,
                                animation: true,
                                animationDuration: 2,
                                percent: 0.8,
                                radius: blockVertical*8,
                                lineWidth: blockVertical*2,
                                header: Text("Mesin 4", style: TextStyle(fontSize: blockVertical*2.5,),),
                                center: Text("80 %", style: TextStyle(fontSize: blockVertical*2),),
                              ),
                                
                            
                            ], options: CarouselOptions(
                              autoPlay: true,

                            )),
                          SizedBox(height: blockVertical*3,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ), 
      ),
    );
  }

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
}
