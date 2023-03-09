// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/models/param_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Services/param_service.dart';

class m2param extends StatefulWidget {
  static const nameRoute = '/m2param';
  const m2param(String r, {super.key});

  @override
  State<m2param> createState() => _m2paramState();
}

class _m2paramState extends State<m2param> {
  //KONTROLER REALTIME DATA (STREAMBUILDER)
  StreamController<List> streamParam = StreamController();
  late Timer timer;
  List<ParamModel2> paramList = [];
  readLatestParamM2 getLatestParamM2 = readLatestParamM2();
  Future<void> latestParam() async {
    paramList = await getLatestParamM2.getParamM2();
    streamParam.add(paramList);
  }

  //KONTROLER PARAMETER YANG DI INPUTKAN
  int state = 1;
  String machine_id = "2";
  TextEditingController loading = TextEditingController();
  TextEditingController cycle = TextEditingController();
  TextEditingController oee = TextEditingController();
  TextEditingController harga = TextEditingController();
  final List<String> tipeBenda = [
    "A",
    "B",
    "C",
  ];
  late String? tipeValue;

  @override
  void initState() {
    latestParam();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      latestParam();
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
            "Mesin 2 Input Parameter",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 82, 0, 234),
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
                  Color.fromARGB(255, 122, 29, 215),
                  Color.fromARGB(255, 13, 76, 237),
                ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // HEADER PARAMETER-----------------------------------------------------------------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      blockHorizontal * 2,
                      blockVertical * 2,
                      blockHorizontal * 2,
                      blockVertical * 0.1),
                  child: Container(
                    width: MediaQuerywidth,
                    height: blockVertical * 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 92, 95, 107).withOpacity(0.6),
                            Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                          ]),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: blockHorizontal * 2),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.flask,
                            size: blockVertical * 3,
                            color: Colors.white,
                          ),
                          Text(
                            "    PARAMETER",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: blockVertical * 2,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //BODY PARAMATER----------------------------------------------------------------------------------------
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: blockHorizontal * 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: MediaQuerywidth,
                      height: blockVertical * 20,
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
                              ],
                            ),
                          ),
                          child: StreamBuilder<Object>(
                              stream: streamParam.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: paramList.map((e) {
                                      return Column(
                                        children: [
                                          Text(
                                            "Loading Time",
                                            style: TextStyle(
                                                fontSize: blockVertical * 1.5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("${e.loading_time} Menit",
                                                  style: TextStyle(
                                                      fontSize:
                                                          blockVertical * 1.5)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: blockVertical * 1,
                                          ),
                                          Text(
                                            "Cycle Time",
                                            style: TextStyle(
                                                fontSize: blockVertical * 1.5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("${e.cycle_time} Menit",
                                                  style: TextStyle(
                                                      fontSize:
                                                          blockVertical * 1.5)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: blockVertical * 1,
                                          ),
                                          Text(
                                            "OEE Target",
                                            style: TextStyle(
                                                fontSize: blockVertical * 1.5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("${e.oee_target} %",
                                                  style: TextStyle(
                                                      fontSize:
                                                          blockVertical * 1.5)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: blockVertical * 1,
                                          ),
                                          Text(
                                            "Tipe Benda",
                                            style: TextStyle(
                                                fontSize: blockVertical * 1.5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Bentuk ${e.tipe_benda}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          blockVertical * 1.5)),
                                            ],
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                                return Center(
                                  child: Text("No data"),
                                );
                              }),
                        ),
                      ]),
                    ),
                  ),
                ),
                //INPUT FIELD PARAMATER----------------------------------------------------------------------------------------
                InputParam(
                  context,
                ),
                //BUTTON INPUT----------------------------------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockHorizontal * 2,
                      vertical: blockVertical * 1),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: MediaQuerywidth,
                      height: MediaQueryheight * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(211, 10, 179, 69),
                                Color.fromARGB(235, 2, 139, 146)
                              ])),
                      child: Material(
                        type: MaterialType.canvas,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          splashColor: Color.fromARGB(19, 3, 191, 233),
                          radius: 100,
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (loading.text.isNotEmpty &&
                                cycle.text.isNotEmpty &&
                                oee.text.isNotEmpty &&
                                harga.text.isNotEmpty &&
                                tipeValue!.isNotEmpty) {
                              inputParameter
                                  .insertParam(
                                      machine_id,
                                      loading.text,
                                      cycle.text,
                                      oee.text,
                                      harga.text,
                                      tipeValue.toString(),
                                      state)
                                  .then(
                                    (value) => {
                                      // ignore: unnecessary_null_comparison
                                      if (value != null)
                                        {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.leftSlide,
                                            title: "Sukses",
                                            desc: "Sukses Input Parameter",
                                            btnOkOnPress: () {
                                              Navigator.pop(context);
                                            },
                                          ).show()
                                        },
                                    },
                                  );
                            } else {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.leftSlide,
                                      title: "Gagal",
                                      desc:
                                          "Parameter Tidak Boleh Ada Yang Kosong",
                                      autoHide: Duration(seconds: 2))
                                  .show();
                              print("ok");
                            }
                          },
                          child: Center(
                            child: Text(
                              "INPUT DATA",
                              style: TextStyle(
                                  fontSize: MediaQueryheight * 0.02,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //BUTTON RESET----------------------------------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: blockHorizontal * 2,
                  ),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: MediaQuerywidth,
                      height: MediaQueryheight * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(210, 179, 117, 10),
                                Color.fromARGB(235, 146, 2, 2)
                              ])),
                      child: Material(
                        type: MaterialType.canvas,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          splashColor: Color.fromARGB(19, 3, 191, 233),
                          radius: 100,
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          child: Center(
                            child: Text(
                              "RESET DATA",
                              style: TextStyle(
                                  fontSize: MediaQueryheight * 0.02,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
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

  //FORM FIELD INPUT PARAMETER----------------------------------------------------------------------------------------
  Widget InputParam(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(blockHorizontal * 2, blockVertical * 2,
              blockHorizontal * 2, blockVertical * 0.1),
          child: Container(
            width: MediaQuerywidth,
            height: blockVertical * 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 92, 95, 107).withOpacity(0.6),
                    Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                  ]),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: blockHorizontal * 2),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.plus,
                    size: blockVertical * 3,
                    color: Colors.white,
                  ),
                  Text(
                    "    INPUT PARAMETER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: blockVertical * 2,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: blockHorizontal * 2, vertical: blockVertical * 0.05),
          child: Container(
            width: MediaQuerywidth,
            height: blockVertical * 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.5)
                  ]),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockHorizontal * 2,
                        vertical: blockVertical * 1),
                    child: TextFormField(
                      controller: loading,
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF605F64))),
                          hintText: "Masukan Nilai...",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 106, 106, 107)),
                          labelText: "Loading Time (Menit)",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 98, 97, 100))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockHorizontal * 2,
                        vertical: blockVertical * 1),
                    child: TextFormField(
                      controller: cycle,
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF605F64))),
                          hintText: "Masukan Nilai...",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 106, 106, 107)),
                          labelText: "Cycle Time (Menit)",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 98, 97, 100))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockHorizontal * 2,
                        vertical: blockVertical * 1),
                    child: TextFormField(
                      controller: oee,
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF605F64))),
                          hintText: "Masukan Nilai...",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 106, 106, 107)),
                          labelText: "OEE Target (%)",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 98, 97, 100))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockHorizontal * 2,
                        vertical: blockVertical * 1),
                    child: TextFormField(
                      controller: harga,
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF605F64))),
                          hintText: "Masukan Nilai...",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 106, 106, 107)),
                          labelText: "Harga per Unit (Rp)",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 98, 97, 100))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockHorizontal * 2,
                        vertical: blockVertical * 1),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: blockHorizontal * 2.5,
                          vertical: blockVertical * 0.5),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.3)),
                      ),
                      child: DropdownSearch<String>(
                        clearButtonProps: ClearButtonProps(
                          isVisible: true,
                        ),
                        popupProps: PopupProps.bottomSheet(
                          constraints:
                              BoxConstraints(maxHeight: blockVertical * 21.5),
                          showSelectedItems: true,
                        ),
                        items: tipeBenda,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Pilih Tipe Benda",
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 98, 97, 100)),
                              hintText: "Tipe Benda",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 98, 97, 100))),
                        ),
                        onChanged: (value) {
                          setState(() {
                            tipeValue = value;
                          });
                          print(tipeValue);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
