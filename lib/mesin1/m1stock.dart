// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/stock.services.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/models/stock_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class m1stock extends StatefulWidget {
  static const nameRoute = '/m1stock';
  const m1stock(String q, {super.key});

  @override
  State<m1stock> createState() => _m1stockState();
}

class _m1stockState extends State<m1stock> {
  //KONTROLER REALTIME DATA (STREAMBUILDER)
  StreamController<List> streamStock = StreamController();
  late Timer timer;
  List<stockModel> stockList = [];
  readStockM1 getstockM1 = readStockM1();
  Future<void> stockData() async {
    stockList = await getstockM1.getStockM1();
    streamStock.add(stockList);
  }

  TextEditingController jumlah = TextEditingController();
  bool stateA = true;
  bool stateB = false;
  bool stateC = false;
  final List<String> tipeBenda = <String>[
    "A",
    "B",
    "C",
  ];
  late String? tipeValue;

  @override
  void initState() {
    stockData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      stockData();
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
            "Mesin 1 Stock Bahan",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 6, 160, 207),
          toolbarHeight: blockVertical * 8,
          leading: backbutton(context),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: MediaQuerywidth,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage("images/asset8.png"),
                        fit: BoxFit.cover),
                  ),
                  //TAMBAH BAHAN-----------------------------------------------------------------------------------------
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Tambah Stock",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      ClipOval(
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.white,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.noHeader,
                                        useRootNavigator: true,
                                        body: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tambah Stock",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            DropdownSearch<String>(
                                              clearButtonProps:
                                                  ClearButtonProps(
                                                isVisible: true,
                                              ),
                                              popupProps: PopupProps.menu(
                                                constraints: BoxConstraints(
                                                    maxHeight: 170),
                                                showSelectedItems: true,
                                              ),
                                              items: tipeBenda,
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Pilih Tipe Benda",
                                                  hintText: "Tipe Benda",
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  tipeValue = value;
                                                });
                                              },
                                            ),
                                            TextField(
                                              controller: jumlah,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Isi Jumlah (unit)"),
                                            ),
                                          ],
                                        ),
                                        btnOkText: "Add",
                                        btnOkIcon: FontAwesomeIcons.plus,
                                        btnOkOnPress: () {
                                          if (tipeValue == "A") {
                                            addStockM1.putStockM1(
                                                int.parse(jumlah.text), 0, 0);
                                          } else if (tipeValue == "B") {
                                            addStockM1.putStockM1(
                                                0, int.parse(jumlah.text), 0);
                                          } else if (tipeValue == "C") {
                                            addStockM1.putStockM1(
                                                0, 0, int.parse(jumlah.text));
                                          }
                                        },
                                        btnCancelIcon: FontAwesomeIcons.ban,
                                        btnCancelOnPress: () {})
                                    .show();
                              },
                              icon: Icon(FontAwesomeIcons.plus),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //KETERSEDIAAN BAHAN-----------------------------------------------------------------------------------------
                Container(
                  padding: EdgeInsets.only(top: 5),
                  color: Colors.transparent,
                  height: 120,
                  width: MediaQuerywidth,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return StreamBuilder<Object>(
                        stream: streamStock.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: stockList.map((e) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      height: constraints.maxHeight * 0.9,
                                      width: constraints.maxWidth * 0.3,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 255, 77, 7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.a,
                                            color: Colors.white,
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          Text("Jumlah : ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          Text(
                                            "${e.A} unit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      height: constraints.maxHeight * 0.9,
                                      width: constraints.maxWidth * 0.3,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 253, 173, 0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.b,
                                            color: Colors.white,
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          Text("Jumlah : ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          Text(
                                            "${e.B} unit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      height: constraints.maxHeight * 0.9,
                                      width: constraints.maxWidth * 0.3,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 7, 32, 255),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.c,
                                            color: Colors.white,
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          Text("Jumlah : ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          Text(
                                            "${e.C} unit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container();
                        });
                  }),
                ),
                Divider(
                  thickness: 2,
                ),
                //RIWAYAT PENGGUNAAN BAHAN-----------------------------------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.only(
                    left: blockHorizontal * 3,
                  ),
                  child: Text(
                    "Riwayat Penggunaan Bahan",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //PILIH RIWAYAT BAHAN-------------------------------------------------------------------------------------------------
                Container(
                  height: 75,
                  width: MediaQuerywidth,
                  color: Colors.transparent,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //KOTAK A--------------------------------------------------------------------------
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              stateA = true;
                              stateB = false;
                              stateC = false;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(8),
                              height: constraints.maxHeight * 0.8,
                              width: constraints.maxWidth * 0.3,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 77, 7),
                                borderRadius: BorderRadius.circular(10),
                                border: (stateA)
                                    ? Border.all(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        width: 3)
                                    : Border.all(
                                        color: Color.fromARGB(255, 255, 77, 7),
                                      ),
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.a,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        //KOTAK B--------------------------------------------------------------------------
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              stateA = false;
                              stateB = true;
                              stateC = false;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(8),
                              height: constraints.maxHeight * 0.8,
                              width: constraints.maxWidth * 0.3,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 253, 173, 0),
                                borderRadius: BorderRadius.circular(10),
                                border: (stateB)
                                    ? Border.all(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        width: 3)
                                    : Border.all(
                                        color: Color.fromARGB(255, 253, 173, 0),
                                      ),
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.b,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        //KOTAK C--------------------------------------------------------------------------
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              stateA = false;
                              stateB = false;
                              stateC = true;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(8),
                              height: constraints.maxHeight * 0.8,
                              width: constraints.maxWidth * 0.3,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 7, 32, 255),
                                borderRadius: BorderRadius.circular(10),
                                border: (stateC)
                                    ? Border.all(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        width: 3)
                                    : Border.all(
                                        color: Color.fromARGB(255, 7, 32, 255),
                                      ),
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.c,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ],
                    );
                  }),
                ),
                //LIST RIWAYAT BAHAN------------------------------------------------------------------------------------------------------
                Container(
                  color: Colors.transparent,
                  height: 300,
                  width: MediaQuerywidth,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        (stateC)
                            ? Column(
                                children: [
                                  listHistoryC(context),
                                  listHistoryC(context),
                                  listHistoryC(context),
                                  listHistoryC(context),
                                  listHistoryC(context),
                                ],
                              )
                            : (stateB)
                                ? Column(
                                    children: [
                                      listHistoryB(context),
                                      listHistoryB(context),
                                      listHistoryB(context),
                                      listHistoryB(context),
                                      listHistoryB(context),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      listHistoryA(context),
                                      listHistoryA(context),
                                      listHistoryA(context),
                                      listHistoryA(context),
                                      listHistoryA(context),
                                    ],
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
    );
  }

  //LIST RIWAYAT BAHAN----------------------------------------------------------------------------------------------------------------
  Widget listHistoryA(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 100, 6).withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuerywidth,
        child: ListTile(
          title: Text(
            "Processed Unit : 50",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          subtitle: Text("17 Juli 2023", style: TextStyle(color: Colors.white)),
          leading: Icon(
            FontAwesomeIcons.a,
            color: Colors.white,
          ),
          tileColor: Color.fromARGB(255, 226, 125, 42),
          trailing: Text("-50", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget listHistoryB(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 253, 216, 5).withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuerywidth,
        child: ListTile(
          title: Text(
            "Processed Unit : 100",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          subtitle: Text("17 Juli 2023", style: TextStyle(color: Colors.white)),
          leading: Icon(
            FontAwesomeIcons.b,
            color: Colors.white,
          ),
          tileColor: Colors.greenAccent,
          trailing: Text("-100", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget listHistoryC(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 23, 42, 211).withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuerywidth,
        child: ListTile(
          title: Text(
            "Processed Unit : 34",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          subtitle: Text(
            "17 Juli 2023",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            FontAwesomeIcons.c,
            color: Colors.white,
          ),
          tileColor: Colors.greenAccent,
          trailing: Text("-34", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget chartStock() {
    return Center();
  }
}
