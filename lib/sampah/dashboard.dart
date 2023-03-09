// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/status_mesin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class dashboard extends StatefulWidget {
  static const nameRoute = '/dashboard';

  const dashboard(String b, {super.key});
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
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
        //APPBAR----------------------------------------------------------------------------------------------------------------
        appBar: AppBar(
          title: Text(
            "DASHBOARD",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 3, 131, 167),
          toolbarHeight: blockVertical * 8,
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
        ),
        //DRAWER-------------------------------------------------------------------------------------------------------------------------
        drawer: drawer(),
        //POTRAIT
        //BODY---------------------------------------------------------------------------------------------------------------------------
        body: Stack(
          children: [
            // Background----------------------------------------------------------------------------------------------------------------
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 16, 225, 236),
                      Color.fromARGB(255, 7, 19, 187),
                    ]),
              ),
            ),
            //FRONT BACKGROUND----------------------------------------------------------------------------------------------------------------
            Scrollbar(
              trackVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        //Content Status Mesin-------------------------------------------------------------------
                        statusMesin(),
                        // Header Status Mesin----------------------------------------------------------------------------------------------------------------
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              blockHorizontal * 2,
                              blockVertical * 3,
                              blockHorizontal * 2,
                              blockVertical * 1),
                          child: Container(
                            padding: EdgeInsets.only(
                              left: blockHorizontal * 5,
                            ),
                            height: MediaQueryheight * 0.05,
                            width: MediaQuerywidth,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.7),
                                      offset: Offset(3, 3))
                                ],
                                image: DecorationImage(
                                    image: AssetImage("images/asset10.png"),
                                    fit: BoxFit.cover)),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.signal,
                                  color: Color.fromARGB(255, 1, 104, 133),
                                  size: MediaQueryheight * 0.025,
                                ),
                                Text(
                                  "      Status Mesin",
                                  style: GoogleFonts.getFont('Oswald',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQueryheight * 0.02,
                                      color: Color.fromARGB(255, 1, 104, 133)),
                                ),
                                // SizedBox(
                                //   width: blockHorizontal * 55,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Production 4 Mesin----------------------------------------------------------------------------------------------------------------
                        // bodyProduction(),
                    // STOCK BAHAN MESIN----------------------------------------------------------------------------------------------------------------
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          blockHorizontal * 1.2,
                          blockVertical * 3,
                          blockHorizontal * 1.2,
                          blockVertical * 5),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                blockHorizontal * 3,
                                blockVertical * 7,
                                blockHorizontal * 3,
                                blockVertical * 0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                // image: DecorationImage(image: AssetImage("images/asset3.png"), fit: BoxFit.cover),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 3, 112, 116),
                                      Color.fromARGB(255, 1, 22, 34),
                                    ]),
                                borderRadius:
                                    BorderRadius.circular(blockVertical * 2),
                              ),
                              height: MediaQueryheight * 0.23,
                              width: MediaQuerywidth,
                              child: Scrollbar(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    buildCard(
                                        FontAwesomeIcons.boxArchive,
                                        "Mesin 1",
                                        "Bahan A",
                                        " Bahan B",
                                        " Bahan C",
                                        "/stock_mesin1"),
                                    SizedBox(
                                      width: blockHorizontal * 5,
                                    ),
                                    buildCard(
                                        FontAwesomeIcons.boxArchive,
                                        "Mesin 2",
                                        "Bahan A",
                                        " Bahan B",
                                        " Bahan C",
                                        "/stock_mesin2"),
                                    SizedBox(
                                      width: blockHorizontal * 5,
                                    ),
                                    buildCard(
                                        FontAwesomeIcons.boxArchive,
                                        "Mesin 3",
                                        "Bahan A",
                                        " Bahan B",
                                        " Bahan C",
                                        "/stock_mesin3"),
                                    SizedBox(
                                      width: blockHorizontal * 5,
                                    ),
                                    buildCard(
                                        FontAwesomeIcons.boxArchive,
                                        "Mesin 4",
                                        "Bahan A",
                                        " Bahan B",
                                        " Bahan C",
                                        "/stock_mesin4"),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          //HEADER STOCK BAHAN----------------------------------------------------------------------------------------------------------------
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                blockHorizontal * 2,
                                blockVertical * 3,
                                blockHorizontal * 2,
                                blockVertical * 1),
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: blockHorizontal * 5),
                              height: MediaQueryheight * 0.05,
                              width: MediaQuerywidth,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        color: Color.fromARGB(255, 0, 0, 0)
                                            .withOpacity(0.7),
                                        offset: Offset(3, 3))
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage("images/asset10.png"),
                                      fit: BoxFit.cover)),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.boxOpen,
                                    color: Color.fromARGB(255, 1, 104, 133),
                                    size: MediaQueryheight * 0.025,
                                  ),
                                  Text(
                                    "      Stock Bahan Mesin",
                                    style: GoogleFonts.getFont('Oswald',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQueryheight * 0.02,
                                        color:
                                            Color.fromARGB(255, 1, 104, 133)),
                                  ),
                                  // SizedBox(
                                  //   width: blockHorizontal * 40,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Content Stock Bahan----------------------------------------------------------------------------------------------------------------
  Widget buildCard(IconData icon, String title, String A, String B, String C,
      String routeName) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return ClipRRect(
      borderRadius: BorderRadius.circular(blockVertical * 2),
      child: Container(
        width: MediaQuerywidth * 0.75,
        height: MediaQueryheight * 0.23,
        color: Colors.transparent,
        child: Stack(children: [
          //blurEffect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(blockVertical * 2),
                border: Border.all(
                  color: Colors.white.withOpacity(0.13),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.5)
                    ])),
            child: InkWell(
              splashColor: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: blockVertical * 5,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: blockVertical * 3,
                        color: Colors.white),
                  ),
                  SizedBox(height: blockVertical * 2.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        A,
                        style: TextStyle(
                            color: Colors.white, fontSize: blockVertical * 2),
                      ),
                      Text(B,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: blockVertical * 2)),
                      Text(C,
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 2))
                    ],
                  ),
                  SizedBox(
                    height: blockVertical * 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "20",
                        style: TextStyle(
                            fontSize: blockVertical * 2.5, color: Colors.white),
                      ),
                      Text("30",
                          style: TextStyle(
                              fontSize: blockVertical * 2.5,
                              color: Colors.white)),
                      Text("40",
                          style: TextStyle(
                              fontSize: blockVertical * 2.5,
                              color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
