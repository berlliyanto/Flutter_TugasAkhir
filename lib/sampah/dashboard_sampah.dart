// ignore_for_file: sized_box_for_whitespace

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/mesin1/m1home.dart';
import 'package:flutter_application_1/mesin2/m2home.dart';
import 'package:flutter_application_1/mesin3/m3home.dart';
import 'package:flutter_application_1/mesin4/m4home.dart';
import 'package:google_fonts/google_fonts.dart';

class dashboard extends StatefulWidget {
  static const nameRoute = '/dashboard';

  const dashboard({super.key});
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  var currentpage = DrawerSections.isidashboard;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //APPBAR
        appBar: AppBar(
          title: Text("DASHBOARD"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 3, 131, 167),
        ),

        //DRAWER
        drawer: drawer(),
        // Drawer(
        // child: SingleChildScrollView(child: Column(
        //   children: [
        //     Headerdrawer(),
        //     Drawerlist(),
        //   ],
        // ),),
        // ),

        //BODY
        body: Stack(
          children: [
            // Background
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF3ac3cb),
                      Color(0xFFFFFFFF),
                    ]),
              ),
            ),

            //FRONT BACKGROUND
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                        child: Container(
                          height: 120,
                          width: 340,
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Color.fromARGB(255, 165, 157, 157),
                                    offset: Offset(2, 2))
                              ]),

                          // Content Status Mesin
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 40),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 156,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(2, 2),
                                                    blurRadius: 5)
                                              ]),
                                          // child: FutureBuilder(
                                          //   future: MongoDatabase.getData(),
                                          //   builder: (context,
                                          //       AsyncSnapshot snapshot) {
                                          //     if (snapshot.connectionState ==
                                          //         ConnectionState.waiting) {
                                          //       return Center(
                                          //         child:
                                          //             CircularProgressIndicator(),
                                          //       );
                                          //     } else {
                                          //       if (snapshot.hasData) {
                                          //         var totalData =
                                          //             snapshot.data.length;
                                          //         print(totalData);
                                          //         return Center(
                                          //             child: Text(
                                          //           totalData.toString(),
                                          //           style: TextStyle(
                                          //               fontSize: 14,
                                          //               color: Colors.green),
                                          //         ));
                                          //       } else {
                                          //         return Center(
                                          //           child: Text(
                                          //             "Mesin 1 Not Connected",
                                          //             style: TextStyle(
                                          //                 fontSize: 14,
                                          //                 color: Colors.red),
                                          //           ),
                                          //         );
                                          //       }
                                          //     }
                                          //   },
                                          // ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          height: 30,
                                          width: 156,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(2, 2),
                                                    blurRadius: 5)
                                              ]),
                                          child: Center(
                                            child: Text("Mesin 2 Not Connected",
                                                style: TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 156,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(2, 2),
                                                    blurRadius: 5)
                                              ]),
                                          child: Center(
                                            child: Text("Mesin 3 Not Connected",
                                                style: TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          height: 30,
                                          width: 156,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(2, 2),
                                                    blurRadius: 5)
                                              ]),
                                          child: Center(
                                            child: Text("Mesin 4 Not Connected",
                                                style: TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      // Header Status Mesin
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          height: 40,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Color.fromARGB(255, 165, 157, 157),
                                  offset: Offset(2, 2))
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Status Mesin",
                                style: GoogleFonts.getFont('Oswald',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 1, 104, 133)),
                              ),
                              SizedBox(
                                width: 190,
                              ),
                              Icon(Icons.graphic_eq,
                                  color: Color.fromARGB(255, 1, 104, 133)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Background 4 Mesin
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: 345,
                        width: 350,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color(0xFF3ac3cb),
                                Color(0xFFFFFFFF),
                              ]),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // MESIN 1
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Card(
                                          color:
                                              Color.fromARGB(93, 4, 226, 137),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              m1home.nameRoute);
                                                      setState(() {
                                                        currentpage =
                                                            DrawerSections
                                                                .mesin1;
                                                        print(currentpage);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 110,
                                                      width: 110,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .precision_manufacturing,
                                                            size: 50,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            "MESIN 1",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //MESIN 2
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Card(
                                          color: Color.fromARGB(93, 9, 23, 216),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              m2home.nameRoute);
                                                    },
                                                    child: Container(
                                                      height: 110,
                                                      width: 110,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .precision_manufacturing,
                                                            size: 50,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            "MESIN 2",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //MESIN 3
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Card(
                                          color:
                                              Color.fromARGB(93, 107, 228, 1),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              m3home.nameRoute);
                                                    },
                                                    child: Container(
                                                      height: 110,
                                                      width: 110,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .precision_manufacturing,
                                                            size: 50,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            "MESIN 3",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //MESIN 4
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Card(
                                          color:
                                              Color.fromARGB(93, 5, 176, 165),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              m4home.nameRoute);
                                                    },
                                                    child: Container(
                                                      height: 110,
                                                      width: 110,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .precision_manufacturing,
                                                            size: 50,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            "MESIN 4",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // STOCK BAHAN MESIN
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 50),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
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
                              borderRadius: BorderRadius.circular(1),
                            ),
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildCard(Icons.add_box, "Mesin 1", "Bahan A",
                                    " Bahan B", " Bahan C", "/stock_mesin1"),
                                SizedBox(
                                  width: 20,
                                ),
                                buildCard(Icons.add_box, "Mesin 2", "Bahan A",
                                    " Bahan B", " Bahan C", "/stock_mesin2"),
                                SizedBox(
                                  width: 20,
                                ),
                                buildCard(Icons.add_box, "Mesin 3", "Bahan A",
                                    " Bahan B", " Bahan C", "/stock_mesin3"),
                                SizedBox(
                                  width: 20,
                                ),
                                buildCard(Icons.add_box, "Mesin 4", "Bahan A",
                                    " Bahan B", " Bahan C", "/stock_mesin4"),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 10),
                            height: 40,
                            width: 360,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Color.fromARGB(255, 165, 157, 157),
                                    offset: Offset(2, 2))
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Stock Bahan Mesin",
                                  style: GoogleFonts.getFont('Oswald',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 1, 104, 133)),
                                ),
                                SizedBox(
                                  width: 150,
                                ),
                                Icon(Icons.shop,
                                    color: Color.fromARGB(255, 1, 104, 133)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 240, 0, 10),
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            height: 10,
                            width: 360,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    offset: Offset(1, 1))
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
          ],
        ),
      ),
    );
  }

  //Content Stock Bahan
  Widget buildCard(IconData icon, String title, String A, String B, String C,
      String routeName) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 200,
        height: 200,
        color: Colors.transparent,
        child: Stack(children: [
          //blurEffect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                    size: 40,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        A,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(B, style: TextStyle(color: Colors.white)),
                      Text(C, style: TextStyle(color: Colors.white))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "20",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text("30",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text("40",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ],
                  )
                ],
              ),
              onTap: () {},
            ),
          ),
        ]),
      ),
    );
  }
}

enum DrawerSections {
  isidashboard,
  mesin1,
  mesin2,
  mesin3,
  mesin4,
  setting,
  kelolaakun,
  logout,
}




// Testing Database
// child: FutureBuilder(
//                 future: MongoDatabase.getData(),
//                 builder: (context, AsyncSnapshot snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else {
//                     if (snapshot.hasData) {
//                       var totalData = snapshot.data.length;
//                       print(totalData);
//                       return Container(
//                         padding: EdgeInsets.all(20),
//                         child: Text("DATA FOUND", style: TextStyle(fontSize: 24),)
//                       );
//                     } else {
//                       return Center(
//                         child: Text("No Data Available"),
//                       );
//                     }
//                   }
//                 },
//               ),


