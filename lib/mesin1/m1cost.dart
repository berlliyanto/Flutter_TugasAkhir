// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class m1cost extends StatefulWidget {
  static const nameRoute = '/m1cost';
  const m1cost(String k, {super.key});

  @override
  State<m1cost> createState() => _m1costState();
}

class _m1costState extends State<m1cost> {
  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mesin 1 Cost Price",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CARD COST PRICE-------------------------------------------------------------------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: blockVertical * 2,
                      horizontal: blockHorizontal * 2),
                  child: Container(
                    width: MediaQuerywidth,
                    height: blockVertical * 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(blockVertical * 2),
                        gradient: LinearGradient(
                          end: Alignment.topLeft,
                          begin: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 0, 201, 228),
                            Color.fromARGB(255, 0, 25, 252),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(3, 3),
                              blurRadius: 5)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: blockVertical * 1.5,
                        ),
                        Text(
                          "Pendapatan",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: blockVertical * 2.5),
                        ),
                        SizedBox(
                          height: blockVertical * 1,
                        ),
                        Text(
                          "Rp. 300.000",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: blockVertical * 2.8),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: blockHorizontal * 2,
                              vertical: blockVertical * 1),
                          child: Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "Status Mesin : ",
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 1.5),
                        ),
                        Text(
                          "Running",
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 1.5),
                        ),
                        SizedBox(
                          height: blockVertical * 1,
                        ),
                        Text(
                          "Processed Unit : ",
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 1.5),
                        ),
                        Text(
                          "50",
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 1.5),
                        ),
                        SizedBox(
                          height: blockVertical * 1,
                        ),
                        Text(
                          "Harga per Unit : ",
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 1.5),
                        ),
                        Text(
                          "Rp. 1.000",
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 1.5),
                        ),
                        SizedBox(
                          height: blockVertical * 1,
                        ),
                        Text(
                          "Total Harga Unit : ",
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 1.5),
                        ),
                        Text(
                          "Rp. 50.000",
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                // AKTIVITAS TERBARU-----------------------------------------------------------------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.only(
                      left: blockHorizontal * 3,
                      top: blockVertical * 1,
                      bottom: blockVertical * 1),
                  child: Text(
                    "Aktivitas Terbaru",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: blockVertical * 3,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ////LIST RIWAYAT ----------------------------------------------------------------------------------------------------------------
                Container(
                  color: Colors.transparent,
                  height: blockVertical * 44,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        listHistory((context)),
                        listHistory((context)),
                        listHistory((context)),
                        listHistory((context)),
                        listHistory((context)),
                        listHistory((context)),
                        listHistory((context)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listHistory(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: blockHorizontal * 2, vertical: blockVertical * 0.5),
      child: Container(
        height: blockVertical * 10,
        decoration: BoxDecoration(
            color: Colors.greenAccent.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuerywidth,
        child: ListTile(
          title: Text(
            "Processed Unit : 50",
            style: TextStyle(fontSize: blockVertical * 2),
          ),
          subtitle: Text("17 Juli 2023"),
          leading: Icon(FontAwesomeIcons.b),
          tileColor: Colors.greenAccent,
          trailing: Text("Rp. 50.000"),
        ),
      ),
    );
  }
}
