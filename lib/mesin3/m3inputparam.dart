// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/preventive_service.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/param_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_1/Services/availability_service.dart';
import 'package:flutter_application_1/Services/oee_service.dart';
import 'package:flutter_application_1/Services/param_service.dart';
import 'package:flutter_application_1/Services/performance_service.dart';
import 'package:flutter_application_1/Services/quality_service.dart';
import 'package:flutter_application_1/Services/costprice_service.dart';

class m3param extends StatefulWidget {
  static const nameRoute = '/m3param';
  const m3param(String aa, {super.key});

  @override
  State<m3param> createState() => _m3paramState();
}

class _m3paramState extends State<m3param> {
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
  StreamController<List> streamParam = StreamController();
  late Timer timer;
  List<ParamModel3> paramList = [];
  readLatestParamM3 getLatestParamM3 = readLatestParamM3();
  Future<void> latestParam() async {
    paramList = await getLatestParamM3.getParamM3();
    streamParam.add(paramList);
  }

  int state0 = 0;
  int state = 1;
  String machine_id = "3";
  TextEditingController loading = TextEditingController();
  TextEditingController cycle = TextEditingController();
  TextEditingController oee = TextEditingController();
  final List<String> tipeBenda = [
    "A",
    "B",
    "C",
  ];
  late String? tipeValue;
int jam = 0;
  int hari = 0;
  int menit = 0;
  int currentDay = DateTime.now().weekday;
  int currentHour = DateTime.now().hour;
  int currentMinute = DateTime.now().minute;

  @override
  void initState() {
    getValidUser();
    latestParam();
    getJadwalPrev().getSingleJadwal().then((value) {
      var jamValue = value[2]['jam'];
      var hariValue = value[2]['hari'];
      var menitValue = value[2]['menit'];
      setState(() {
        jam = int.parse(jamValue);
        hari = int.parse(hariValue);
        menit = int.parse(menitValue);
      });
      if (currentDay == hari && currentHour >= jam && currentHour <= jam + 2) {
        AwesomeDialog(context: context,
        dialogType: DialogType.info,
        title: "Sedang Perawatan",
        desc: "Mesin 3 sedang dilakukan perawatan, estimasi parawatan sampai jam ${jam + 2}.$menit WIB",
        btnOkOnPress: (){},
        useRootNavigator: true
        ).show();
      }
    });
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Machine 3 Input Parameter",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 1, 94, 74),
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
                  Color.fromARGB(255, 58, 203, 172),
                  Color.fromARGB(255, 13, 177, 150)
                ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // CONTAINER PARAMETER-----------------------------------------------------------------------------------------------------------------------
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
                                              Text(
                                                  (e.state == 1)
                                                      ? "${e.loading_time} Minute"
                                                      : "0.0 Minute",
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
                                              Text(
                                                  (e.state == 1)
                                                      ? "${e.cycle_time} Minute"
                                                      : "0.0 Minute",
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
                                              Text(
                                                  (e.state == 1)
                                                      ? "${e.oee_target} %"
                                                      : "0.0 %",
                                                  style: TextStyle(
                                                      fontSize:
                                                          blockVertical * 1.5)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: blockVertical * 1,
                                          ),
                                          Text(
                                            "Object type",
                                            style: TextStyle(
                                                fontSize: blockVertical * 1.5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  (e.state == 1)
                                                      ? "Type ${e.tipe_benda}"
                                                      : "Undefined Type",
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
                InputParam(
                  context,
                ),
                //BUTTON INPUT--------------------------------------------------------------------
                (currentDay == hari &&
                        currentHour >= jam &&
                        currentHour <= jam + 2)
                    ? buttonInputDis(MediaQueryheight, MediaQuerywidth,
                        blockHorizontal, blockVertical)
                    : (otoritas == "Admin" || otoritas == "User-Operator")
                        ? buttonInput(MediaQueryheight, MediaQuerywidth,
                            blockHorizontal, blockVertical)
                        : buttonInputDis(MediaQueryheight, MediaQuerywidth,
                            blockHorizontal, blockVertical),
                //Button Reset Data---------------------------------------------------------------------------------------------------
                (currentDay == hari &&
                        currentHour >= jam &&
                        currentHour <= jam + 2)
                    ? buttonResetDis(MediaQueryheight, MediaQuerywidth, blockHorizontal, blockVertical)
                    : (otoritas == "Admin" || otoritas == "User-Operator")
                        ? buttonReset(MediaQueryheight, MediaQuerywidth, blockHorizontal, blockVertical)
                        : buttonResetDis(MediaQueryheight, MediaQuerywidth, blockHorizontal, blockVertical)
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                          hintText: "Input Value...",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 106, 106, 107)),
                          labelText: "Loading Time (Minute)",
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
                          hintText: "Input Value...",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 106, 106, 107)),
                          labelText: "Cycle Time (Minute)",
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
                          hintText: "Input Value...",
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
                              labelText: "Choose Object Type",
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 98, 97, 100)),
                              hintText: "Object Type",
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

  Widget buttonInput(double MediaQueryheight, double MediaQuerywidth,
      double blockHorizontal, double blockVertical) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: blockHorizontal * 2, vertical: blockVertical * 1),
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
                    tipeValue!.isNotEmpty) {
                  if (int.parse(oee.text) > 100) {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.leftSlide,
                            title: "Error",
                            desc: "OEE value should not be greater than 100% !",
                            useRootNavigator: true,
                            autoHide: Duration(seconds: 2))
                        .show();
                  } else {
                    inputParameter
                        .insertParam3(machine_id, loading.text, cycle.text,
                            oee.text, tipeValue.toString(), state)
                        .then(
                          (value) => {
                            // ignore: unnecessary_null_comparison
                            if (value != null)
                              {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.leftSlide,
                                  title: "Success",
                                  desc: "Success Input Parameter",
                                  btnOkOnPress: () {
                                    Navigator.pushNamed(context, mym3monitoring,
                                        arguments: "sukses");
                                  },
                                ).show()
                              },
                          },
                        );
                    trigQuality.TriggerQuality(3, tipeValue.toString());
                    trigAvailability.triggerAvai(3, 3);
                    triggCost.trigCost(3);
                    trigPerformance.triggerPerformance(3);
                    trigOEE.triggerOEE(3);
                  }
                } else {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.leftSlide,
                          title: "Fail",
                          desc: "Parameters Can't Be Empty",
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
    );
  }

  Widget buttonReset(double MediaQueryheight, double MediaQuerywidth,
      double blockHorizontal, double blockVertical) {
    return Padding(
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
              onTap: () {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.leftSlide,
                        title: "Reset",
                        desc:
                            "Are You Sure You Want To Delete The Current Parameter Data?",
                        useRootNavigator: true,
                        btnOkIcon: FontAwesomeIcons.check,
                        btnOkOnPress: () async {
                          final SharedPreferences shared =
                              await SharedPreferences.getInstance();
                          shared.remove('stateParamM3');
                          shared.remove('tipeParamM3');
                          resetPerformance.resPerformance(3);
                          resetCost.resettCost(3);
                          resetQuality.reset(3);
                          resetAvailability.resetAvai(3);
                          resetOEE.resOEE(3);
                          resetParamM3.putParam(state0).then((value) {
                            if (value.state == 0) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.leftSlide,
                                title: "Success",
                                desc: "Success Reset Parameter",
                                useRootNavigator: true,
                                autoHide: Duration(seconds: 2),
                              );
                            }
                          });
                        },
                        btnCancelIcon: FontAwesomeIcons.x,
                        btnCancelOnPress: () {})
                    .show();
              },
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
    );
  }

  Widget buttonResetDis(double MediaQueryheight, double MediaQuerywidth,
      double blockHorizontal, double blockVertical) {
    return Padding(
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
                    Color.fromARGB(210, 165, 165, 165),
                    Color.fromARGB(235, 102, 102, 102)
                  ])),
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
    );
  }

  Widget buttonInputDis(double MediaQueryheight, double MediaQuerywidth,
      double blockHorizontal, double blockVertical) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: blockHorizontal * 2, vertical: blockVertical * 1),
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
                    Color.fromARGB(210, 165, 165, 165),
                    Color.fromARGB(235, 102, 102, 102)
                  ])),
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
    );
  }
}
