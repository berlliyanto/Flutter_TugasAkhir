// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/status_service.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/models/status_model.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../constant.dart';

class m3home extends StatefulWidget {
  static const nameRoute = '/m3home';

  const m3home(String e, {super.key});

  @override
  State<m3home> createState() => _m3homeState();
}

class _m3homeState extends State<m3home> {
  //STREAMCONTROLLER STATUS MESIN
  StreamController<List> streamStatusM3 = StreamController.broadcast();
  List<status3Model> status = [];
  getStatusM3 statusState = getStatusM3();
  Future<void> getStatus() async {
    status = await getStatusM3.readStatM3();
    streamStatusM3.add(status);
  }

  late Timer timer;
  int id = 0;
  double sizedheight = 20;
  double blurshadow = 10;

  @override
  void initState() {
    getStatus();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getStatus();
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
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    final myappbar = AppBar(
      title: Text("Media Query"),
    );
    final bodyheight = MediaQueryheight -
        myappbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    // Mengetahui Orientasi Device
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        //APPBAR------------------------------------------------------------------------------------
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          toolbarHeight: blockVertical * 6,
          shadowColor: Colors.transparent,
          title: Text(
            "Machine 3",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 1, 94, 74).withOpacity(0.5),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                FontAwesomeIcons.bars,
                size: blockVertical * 3,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, mydashboard,
                      arguments: 'dari mesin 2');
                  // ignore: deprecated_member_use
                },
                icon: Icon(FontAwesomeIcons.house))
          ],
        ),
        //DRAWER------------------------------------------------------------------------------------
        drawer: drawer(mode: "Mesin3"),
        //BODY------------------------------------------------------------------------------------
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage("images/asset18.jpg"), fit: BoxFit.cover)
          ),
          child: Container(
            padding: EdgeInsets.only(top: blockVertical*8),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(end: Alignment.bottomCenter, begin: Alignment.topCenter, colors: [
                Color.fromARGB(255, 26, 26, 26).withOpacity(0.9), Color.fromARGB(255, 117, 117, 117).withOpacity(0.85)
              ])
            ),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  blockHorizontal*2, blockVertical * 3, blockHorizontal*2, blockVertical * 0.1),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockHorizontal * 2,
                      vertical: blockVertical * 2),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: blockHorizontal * 3),
                          alignment: Alignment.centerLeft,
                          height: blockVertical * 6,
                          width: MediaQuerywidth,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(blockVertical * 1),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    offset: Offset(5, 10),
                                    blurRadius: 10)
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 58, 203, 172),
                                    Color.fromARGB(255, 13, 177, 150),
                                  ])),
                          child: StreamBuilder<Object>(
                              stream: streamStatusM3.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: status.map((e) {
                                      return Text(
                                        (e.status == 1)
                                            ? "Machine ${e.machine_id} - Is Active"
                                            : "Machine ${e.machine_id} - Not Active",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }).toList(),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.white,
                                    highlightColor: Colors.grey,
                                    child: Text(
                                      'Loading',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: blockVertical * 2.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                                return Text("error");
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Listmenu3((context), "Input Parameter", mym3param, "from mesin 3",
                    Icons.add_box),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Cost Price", mym3cost, "from mesin 3",
                    Icons.price_change),
                SizedBox(height: sizedheight),
                Listmenu3((context), "OEE", mym3oee, "from mesin 3",
                    FontAwesomeIcons.chartPie),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Monitoring", mym3monitoring, "from mesin 3",
                    FontAwesomeIcons.computer),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Stock", mym3stock, "from mesin 3",
                    FontAwesomeIcons.boxOpen),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Troubleshoot", mym3alarm, "from mesin 3",
                    FontAwesomeIcons.solidBell),
                SizedBox(height: sizedheight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // FUNCTION LIST MENU HALAMAN MESIN 3--------------------------------------------------------------------------------------------------------
  Widget Listmenu3(BuildContext context, String title, String navigate,
      String arg, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 2, 77, 65),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(10, 10),
              blurRadius: blurshadow,
            )
          ]),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushNamed(context, navigate, arguments: arg);
        },
      ),
    );
  }
}
