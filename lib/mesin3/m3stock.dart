// ignore_for_file: unused_local_variable

import 'package:intl/intl.dart';
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/quality_service.dart';
import 'package:flutter_application_1/Services/stock.services.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/models/quality_model.dart';
import 'package:flutter_application_1/models/stock_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class m3stock extends StatefulWidget {
  static const nameRoute = '/m3stock';
  const m3stock(String ai, {super.key});

  @override
  State<m3stock> createState() => _m3stockState();
}

class _m3stockState extends State<m3stock> {
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

  //KONTROLER REALTIME DATA (STREAMBUILDER)
  StreamController<List> streamStock = StreamController.broadcast();
  late Timer timer;
  List<stockModel> stockList = [];
  readStock getstockM1 = readStock();
  Future<void> stockData() async {
    stockList = await getstockM1.getStock(3);
    streamStock.add(stockList);
  }

  //RIWAYAT STOCK IN
  StreamController<List> streamRiwayatStock = StreamController.broadcast();
  List<historimodel> riwayatStockList = [];
  getriwayat getriwayatstock = getriwayat();
  Future<void> riwayatstockData() async {
    riwayatStockList = await getriwayatstock.gethistori(3);
    streamRiwayatStock.add(riwayatStockList);
  }

  //RIWAYAT STOCK OUT
  StreamController<List> streamProcessed = StreamController.broadcast();
  List<recQuality> stockProcessed = [];
  recordQuality getStockprocessed = recordQuality();
  Future<void> processedData() async {
    stockProcessed = await getStockprocessed.getrecQuality(3);
    streamProcessed.add(stockProcessed);
  }

  TextEditingController jumlah = TextEditingController();
  bool riwayat = true;
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
    getValidUser();
    processedData();
    riwayatstockData();
    stockData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      processedData();
      riwayatstockData();
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Machine 3 Stock",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 1, 94, 74),
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
                  Color.fromARGB(255, 58, 203, 172),
                  Color.fromARGB(255, 13, 177, 150)
                ]),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: blockVertical * 13,
                  width: MediaQuerywidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 38, 46, 161),
                      Color.fromARGB(255, 1, 80, 250)
                    ]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 6),
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 2)
                    ],
                    image: DecorationImage(
                        image: AssetImage("images/asset8.png"),
                        fit: BoxFit.cover),
                  ),
                  //TAMBAH BAHAN-----------------------------------------------------------------------------------------
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Add Stock",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      (otoritas=="Admin"||otoritas=="User-Warehouse")?ButtonaddStock(blockVertical):ButtonaddStockDis(blockVertical),
                    ],
                  ),
                ),
                //KETERSEDIAAN BAHAN-----------------------------------------------------------------------------------------
                Container(
                  padding: EdgeInsets.only(top: 5),
                  color: Colors.transparent,
                  height: blockVertical * 15,
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
                                    Stock(
                                        constraints,
                                        Color.fromARGB(255, 255, 77, 7),
                                        "${e.A}",
                                        FontAwesomeIcons.a,
                                        e.A!),
                                    Stock(
                                        constraints,
                                        Color.fromARGB(255, 253, 173, 0),
                                        "${e.B}",
                                        FontAwesomeIcons.b,
                                        e.B!),
                                    Stock(
                                        constraints,
                                        Color.fromARGB(255, 7, 32, 255),
                                        "${e.C}",
                                        FontAwesomeIcons.c,
                                        e.C!),
                                  ],
                                );
                              }).toList(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.white,
                                  highlightColor: Colors.grey,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: constraints.maxHeight * 0.9,
                                    width: constraints.maxWidth * 0.3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.white,
                                  highlightColor: Colors.grey,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: constraints.maxHeight * 0.9,
                                    width: constraints.maxWidth * 0.3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.white,
                                  highlightColor: Colors.grey,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: constraints.maxHeight * 0.9,
                                    width: constraints.maxWidth * 0.3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Container();
                        });
                  }),
                ),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: blockVertical * 0.5),
                  child: Container(
                    padding: EdgeInsets.all(blockVertical * 0.5),
                    height: blockVertical * 5,
                    width: MediaQuerywidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(blockVertical * 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              riwayat = true;
                              print(riwayat);
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            height: blockVertical * 4,
                            width: blockHorizontal * 46,
                            decoration: BoxDecoration(
                                color: (riwayat)
                                    ? Colors.lightBlue
                                    : Colors.blueGrey,
                                borderRadius:
                                    BorderRadius.circular(blockVertical * 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.circleArrowDown,
                                  size: blockVertical * 2.5,
                                  color:
                                      (riwayat) ? Colors.white : Colors.black45,
                                ),
                                Text(
                                  " Stock In",
                                  style: TextStyle(
                                      fontSize: blockVertical * 2,
                                      color: (riwayat)
                                          ? Colors.white
                                          : Colors.black45),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              riwayat = false;
                              print(riwayat);
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            height: blockVertical * 4,
                            width: blockHorizontal * 46,
                            decoration: BoxDecoration(
                                color: (riwayat)
                                    ? Colors.blueGrey
                                    : Colors.lightBlue,
                                borderRadius:
                                    BorderRadius.circular(blockVertical * 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.circleArrowUp,
                                  size: blockVertical * 2.5,
                                  color:
                                      (riwayat) ? Colors.black45 : Colors.white,
                                ),
                                Text(
                                  " Stock Out",
                                  style: TextStyle(
                                      fontSize: blockVertical * 2,
                                      color: (riwayat)
                                          ? Colors.black45
                                          : Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //RIWAYAT PENGGUNAAN BAHAN-----------------------------------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.only(
                    left: blockHorizontal * 3,
                  ),
                  child: Text(
                    (riwayat) ? "Stock In History" : "Stock Out History",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: blockVertical * 3.2,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //PILIH RIWAYAT BAHAN-------------------------------------------------------------------------------------------------
                Container(
                  height: blockVertical * 9,
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
                  padding: EdgeInsets.only(bottom: blockVertical * 4.5),
                  color: Colors.transparent,
                  height: blockVertical * 45,
                  width: MediaQuerywidth,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    //STOCK IN
                    child: (riwayat)
                        ? StreamBuilder<Object>(
                            stream: streamRiwayatStock.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: riwayatStockList.map(
                                    (e) {
                                      if (stateC) {
                                        if (e.tipe == "C") {
                                          return Column(
                                            children: [
                                              listHistory(
                                                  context,
                                                  DateFormat(
                                                          "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                      .parse(e.createdAt!)
                                                      .toLocal()
                                                      .toString()
                                                      .split(' ')[0],
                                                  e.jumlah!,
                                                  Color.fromARGB(
                                                      255, 23, 42, 211),
                                                  Colors.greenAccent,
                                                  FontAwesomeIcons.c),
                                            ],
                                          );
                                        }
                                      } else if (stateB) {
                                        if (e.tipe == "B") {
                                          return Column(
                                            children: [
                                              listHistory(
                                                  context,
                                                  DateFormat(
                                                          "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                      .parse(e.createdAt!)
                                                      .toLocal()
                                                      .toString()
                                                      .split(' ')[0],
                                                  e.jumlah!,
                                                  Color.fromARGB(
                                                      255, 253, 216, 5),
                                                  Colors.greenAccent,
                                                  FontAwesomeIcons.b),
                                            ],
                                          );
                                        }
                                      } else if (stateA) {
                                        if (e.tipe == "A") {
                                          return Column(
                                            children: [
                                              listHistory(
                                                  context,
                                                  DateFormat(
                                                          "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                      .parse(e.createdAt!)
                                                      .toLocal()
                                                      .toString()
                                                      .split(' ')[0],
                                                  e.jumlah!,
                                                  Color.fromARGB(
                                                      255, 241, 100, 6),
                                                  Color.fromARGB(
                                                      255, 226, 125, 42),
                                                  FontAwesomeIcons.a),
                                            ],
                                          );
                                        }
                                      }
                                      return Column();
                                    },
                                  ).toList(),
                                );
                              }
                              return Center();
                            },
                            //STOCK OUT
                          )
                        : StreamBuilder<Object>(
                            stream: streamProcessed.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: stockProcessed.map(
                                    (e) {
                                      if (stateC) {
                                        if (e.tipe == "C" && e.processed != 0) {
                                          return Column(
                                            children: [
                                              processHistory(
                                                  context,
                                                  DateFormat(
                                                          "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                      .parse(e.createdAt!)
                                                      .toLocal()
                                                      .toString()
                                                      .split(' ')[0],
                                                  e.processed!,
                                                  Color.fromARGB(
                                                      255, 23, 42, 211),
                                                  Colors.greenAccent,
                                                  FontAwesomeIcons.c),
                                            ],
                                          );
                                        }
                                      } else if (stateB) {
                                        if (e.tipe == "B" && e.processed != 0) {
                                          return Column(
                                            children: [
                                              processHistory(
                                                  context,
                                                  DateFormat(
                                                          "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                      .parse(e.createdAt!)
                                                      .toLocal()
                                                      .toString()
                                                      .split(' ')[0],
                                                  e.processed!,
                                                  Color.fromARGB(
                                                      255, 253, 216, 5),
                                                  Colors.greenAccent,
                                                  FontAwesomeIcons.b),
                                            ],
                                          );
                                        }
                                      } else if (stateA) {
                                        if (e.tipe == "A" && e.processed != 0) {
                                          return Column(
                                            children: [
                                              processHistory(
                                                  context,
                                                  DateFormat(
                                                          "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                      .parse(e.createdAt!)
                                                      .toLocal()
                                                      .toString()
                                                      .split(' ')[0],
                                                  e.processed!,
                                                  Color.fromARGB(
                                                      255, 241, 100, 6),
                                                  Color.fromARGB(
                                                      255, 226, 125, 42),
                                                  FontAwesomeIcons.a),
                                            ],
                                          );
                                        }
                                      }
                                      return Column();
                                    },
                                  ).toList(),
                                );
                              }
                              return Center();
                            },
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
  Widget listHistory(BuildContext context, String tanggal, int jumlah,
      Color color1, Color color2, IconData icon) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        height: blockVertical * 10,
        decoration: BoxDecoration(
            color: color1.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuerywidth,
        child: ListTile(
          title: Text(
            "Add Unit : $jumlah",
            style:
                TextStyle(fontSize: blockVertical * 2.3, color: Colors.white),
          ),
          subtitle: Text(tanggal,
              style:
                  TextStyle(color: Colors.white, fontSize: blockVertical * 2)),
          leading: Icon(
            icon,
            color: Colors.white,
            size: blockVertical * 4.5,
          ),
          tileColor: color2,
          trailing: Text("+$jumlah",
              style:
                  TextStyle(color: Colors.white, fontSize: blockVertical * 3)),
        ),
      ),
    );
  }

  //LIST RIWAYAT PROCESSED----------------------------------------------------------------------------------------------------------------
  Widget processHistory(BuildContext context, String tanggal, int jumlah,
      Color color1, Color color2, IconData icon) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        height: blockVertical * 10,
        decoration: BoxDecoration(
            color: color1.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuerywidth,
        child: ListTile(
          title: Text(
            "Processed Unit : $jumlah",
            style:
                TextStyle(fontSize: blockVertical * 2.3, color: Colors.white),
          ),
          subtitle: Text(tanggal,
              style:
                  TextStyle(color: Colors.white, fontSize: blockVertical * 2)),
          leading: Icon(
            icon,
            color: Colors.white,
            size: blockVertical * 4.5,
          ),
          tileColor: color2,
          trailing: Text("-$jumlah",
              style:
                  TextStyle(color: Colors.white, fontSize: blockVertical * 3)),
        ),
      ),
    );
  }

// JUMLAH STOCK-------------------------------------------------------------------------------------------
  Widget Stock(BoxConstraints constraints, Color color, String unit,
      IconData icon, int value) {
    return Container(
      padding: EdgeInsets.all(8),
      height: constraints.maxHeight * 0.9,
      width: constraints.maxWidth * 0.3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (value > 5)
              ? Icon(
                  icon,
                  color: Colors.white,
                  size: constraints.maxHeight * 0.2,
                )
              : Icon(
                  FontAwesomeIcons.triangleExclamation,
                  color: Colors.red,
                  size: constraints.maxHeight * 0.2,
                ),
          Divider(
            thickness: constraints.maxHeight * 0.01,
          ),
          Text("Amount : ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: constraints.maxHeight * 0.15,
                  fontWeight: FontWeight.bold)),
          Text(
            "$unit unit",
            style: TextStyle(
                color: (value > 5) ? Colors.white : Colors.red,
                fontSize: constraints.maxHeight * 0.15,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget ButtonaddStock(double blockVertical) {
    return ClipOval(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Add Stock",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownSearch<String>(
                            clearButtonProps: ClearButtonProps(
                              isVisible: true,
                            ),
                            popupProps: PopupProps.menu(
                              constraints: BoxConstraints(maxHeight: 170),
                              showSelectedItems: true,
                            ),
                            items: tipeBenda,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Choose Object Type",
                                hintText: "Object Type",
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Input Amount (unit)"),
                          ),
                        ],
                      ),
                      btnOkText: "Add",
                      btnOkIcon: FontAwesomeIcons.plus,
                      btnOkOnPress: () {
                        //addStockM1 untuk menambah jumlah
                        //riwayatStock untuk menambah riwayat
                        if (tipeValue == "A") {
                          addStock.putStock(int.parse(jumlah.text), 0, 0, 3);
                          addriwayatStock.connectAPIPost(
                            3,
                            tipeValue.toString(),
                            int.parse(jumlah.text),
                          );
                        } else if (tipeValue == "B") {
                          addStock.putStock(0, int.parse(jumlah.text), 0, 3);
                          addriwayatStock.connectAPIPost(
                            3,
                            tipeValue.toString(),
                            int.parse(jumlah.text),
                          );
                        } else if (tipeValue == "C") {
                          addStock.putStock(0, 0, int.parse(jumlah.text), 3);
                          addriwayatStock.connectAPIPost(
                            3,
                            tipeValue.toString(),
                            int.parse(jumlah.text),
                          );
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
    );
  }

  Widget ButtonaddStockDis(double blockVertical) {
    return ClipOval(
      child: Container(
        height: blockVertical * 7,
        width: blockVertical * 7,
        color: Color.fromARGB(255, 112, 112, 112),
        child: Center(
          child: IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.plus),
          ),
        ),
      ),
    );
  }
}
