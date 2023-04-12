// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class m4cost extends StatelessWidget {
  static const nameRoute = '/m4cost';
  const m4cost(String al, {super.key});

  @override
  Widget build(BuildContext context) {
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
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Machine 4 Cost Price",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 7, 189, 189),
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
                  Color.fromARGB(255, 39, 214, 214),
                                    Color.fromARGB(255, 1, 176, 182),
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
                            Color.fromARGB(255, 39, 214, 214),
                                    Color.fromARGB(255, 1, 176, 182),
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
                          "Total Harga Produksi : ",
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
                Container(
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
