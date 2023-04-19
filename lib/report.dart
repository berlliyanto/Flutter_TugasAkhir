// ignore_for_file: unused_local_variable

import 'package:flutter_application_1/additional/report_pdf.dart';
import 'package:flutter_application_1/additional/single_reportpdf.dart';
import 'package:flutter_application_1/additional/tabel_report.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class report extends StatefulWidget {
  static const nameRoute = '/report';
  const report(String hk, {super.key});

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  String? mesinValue, reportValue;
  bool visibleR = true;

  final List<String> mesin = <String>[
    "All Machine",
    "Machine 1",
    "Machine 2",
    "Machine 3",
    "Machine 4",
  ];
  final List<String> report = <String>[
    "All Report",
    "Parameter",
    "OEE",
    "Production",
    "Stock",
    "Cost Price",
  ];
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
  void initState() {
    getValidUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          toolbarHeight: blockVertical * 6,
          shadowColor: Colors.transparent,
          title: Text(
            "Production Report",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 85, 110).withOpacity(0.5),
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
                      arguments: 'dari mesin 1');
                  // ignore: deprecated_member_use
                },
                icon: Icon(FontAwesomeIcons.house))
          ],
        ),
        drawer: drawer(),
        body: Container(
          padding: EdgeInsets.fromLTRB(blockVertical * 1, blockVertical * 11,
              blockVertical * 1, blockVertical * 0.5),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(blockVertical * 1),
                    height: blockVertical * 25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(blockVertical * 2)),
                    child: Dropdown(blockHorizontal, blockVertical)),
                SizedBox(
                  height: blockVertical * 1,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: blockHorizontal * 3,
                  ),
                  height: blockVertical * 62,
                  width: MediaQuerywidth,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(blockVertical * 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: blockVertical * 0.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: blockVertical * 0.5,
                            width: blockHorizontal * 10,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Preview Content",
                            style: TextStyle(
                                fontSize: blockVertical * 2.5,
                                fontWeight: FontWeight.bold),
                          ),
                          (otoritas == "Admin" || otoritas == "User-Management")
                              ? IconButton(
                                  onPressed: () async {
                                    //-----------------------ALL MACHINE ------------------------//
                                    (mesinValue == "All Machine") // IF()
                                        ? (reportValue == "All Report") //IF()
                                            //All Machine & All Report
                                            ? allmachinePDF()
                                            //ALL MACHINE & PARAMETER
                                            : (reportValue == "Parameter")
                                                ? //ELSE IF()
                                                AMRPARAM()
                                                //ALL MACHINE & OEE
                                                : (reportValue == "OEE")
                                                    ? //ELSE IF()
                                                    AMROEE()
                                                    //ALL MACHINE & PRODUCTION
                                                    : (reportValue ==
                                                            "Production")
                                                        ? //ELSE IF()
                                                        AMRP()
                                                        //ALL MACHINE & STOCK
                                                        : (reportValue ==
                                                                "Stock")
                                                            ? //ELSE IF()
                                                            AMRS()
                                                            //ALL MACHINE & STOCK
                                                            : (reportValue ==
                                                                    "Cost Price")
                                                                ? //ELSE IF()
                                                                AMRCS()
                                                                //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                                : AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    animType:
                                                                        AnimType
                                                                            .leftSlide,
                                                                    dialogType:
                                                                        DialogType
                                                                            .warning,
                                                                    title:
                                                                        "Choose Report First!",
                                                                    useRootNavigator:
                                                                        true,
                                                                    autoHide: Duration(
                                                                        seconds:
                                                                            2),
                                                                  ).show()
                                        //-----------------------MACHINE 1------------------------//
                                        : (mesinValue ==
                                                "Machine 1") // ELSE IF()
                                            ? (reportValue == "Parameter")
                                                ? //ELSE IF()
                                                ParameterMPDF(mid: 1).AMRPARAM()
                                                //MACHINE 1 & OEE
                                                : (reportValue == "OEE")
                                                    ? //ELSE IF()
                                                    OEEMPDF(mid: 1).AMROEE()
                                                    //MACHINE 1 & PRODUCTION
                                                    : (reportValue ==
                                                            "Production")
                                                        ? //ELSE IF()
                                                        ProductionMPDF(mid: 1)
                                                            .AMRP()
                                                        //MACHINE 1 & STOCK
                                                        : (reportValue ==
                                                                "Stock")
                                                            ? //ELSE IF()
                                                            StockMPDF(mid: 1)
                                                                .AMRS()
                                                            //MACHINE 1 & STOCK
                                                            : (reportValue ==
                                                                    "Cost Price")
                                                                ? //ELSE IF()
                                                                CostMPDF(mid: 1)
                                                                    .AMRCS()
                                                                //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                                : AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    animType:
                                                                        AnimType
                                                                            .leftSlide,
                                                                    dialogType:
                                                                        DialogType
                                                                            .warning,
                                                                    title:
                                                                        "Choose Report First!",
                                                                    useRootNavigator:
                                                                        true,
                                                                    autoHide: Duration(
                                                                        seconds:
                                                                            2),
                                                                  ).show()
                                            //-----------------------MACHINE 2------------------------//
                                            : (mesinValue ==
                                                    "Machine 2") // ELSE IF()
                                                ? (reportValue == "Parameter")
                                                    ? //ELSE IF()
                                                    ParameterMPDF(mid: 2)
                                                        .AMRPARAM()
                                                    //MACHINE 2 & OEE
                                                    : (reportValue == "OEE")
                                                        ? //ELSE IF()
                                                        OEEMPDF(mid: 2).AMROEE()
                                                        //MACHINE 2 & PRODUCTION
                                                        : (reportValue ==
                                                                "Production")
                                                            ? //ELSE IF()
                                                            ProductionMPDF(
                                                                    mid: 2)
                                                                .AMRP()
                                                            //MACHINE 2 & STOCK
                                                            : (reportValue ==
                                                                    "Stock")
                                                                ? //ELSE IF()
                                                                StockMPDF(mid: 2)
                                                                    .AMRS()
                                                                //MACHINE 2 & STOCK
                                                                : (reportValue ==
                                                                        "Cost Price")
                                                                    ? //ELSE IF()
                                                                    CostMPDF(mid: 2)
                                                                        .AMRCS()
                                                                    //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                                    : AwesomeDialog(
                                                                        context:
                                                                            context,
                                                                        animType:
                                                                            AnimType.leftSlide,
                                                                        dialogType:
                                                                            DialogType.warning,
                                                                        title:
                                                                            "Choose Report First!",
                                                                        useRootNavigator:
                                                                            true,
                                                                        autoHide:
                                                                            Duration(seconds: 2),
                                                                      ).show()
                                                //-----------------------MACHINE 3------------------------//
                                                : (mesinValue ==
                                                        "Machine 3") // ELSE IF()
                                                    ? (reportValue ==
                                                            "Parameter")
                                                        ? //ELSE IF()
                                                        ParameterMPDF(mid: 3)
                                                            .AMRPARAM()
                                                        //MACHINE 3 & OEE
                                                        : (reportValue == "OEE")
                                                            ? //ELSE IF()
                                                            OEEMPDF(mid: 3)
                                                                .AMROEE()
                                                            //MACHINE 3 & PRODUCTION
                                                            : (reportValue ==
                                                                    "Production")
                                                                ? //ELSE IF()
                                                                ProductionMPDF(
                                                                        mid: 3)
                                                                    .AMRP()
                                                                //MACHINE 3 & STOCK
                                                                : (reportValue ==
                                                                        "Stock")
                                                                    ? //ELSE IF()
                                                                    StockMPDF(mid: 3)
                                                                        .AMRS()
                                                                    //MACHINE 3 & STOCK
                                                                    : (reportValue ==
                                                                            "Cost Price")
                                                                        ? //ELSE IF()
                                                                        CostMPDF(mid: 3)
                                                                            .AMRCS()
                                                                        //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                                        : AwesomeDialog(
                                                                            context:
                                                                                context,
                                                                            animType:
                                                                                AnimType.leftSlide,
                                                                            dialogType:
                                                                                DialogType.warning,
                                                                            title:
                                                                                "Choose Report First!",
                                                                            useRootNavigator:
                                                                                true,
                                                                            autoHide:
                                                                                Duration(seconds: 2),
                                                                          )
                                                                            .show()
                                                    //-----------------------MACHINE 4------------------------//
                                                    : (mesinValue ==
                                                            "Machine 4") // ELSE IF()
                                                        ? (reportValue ==
                                                                "Parameter")
                                                            ? //ELSE IF()
                                                            ParameterMPDF(mid: 4)
                                                                .AMRPARAM()
                                                            //MACHINE 4 & OEE
                                                            : (reportValue ==
                                                                    "OEE")
                                                                ? //ELSE IF()
                                                                OEEMPDF(mid: 4)
                                                                    .AMROEE()
                                                                //MACHINE 4 & PRODUCTION
                                                                : (reportValue ==
                                                                        "Production")
                                                                    ? //ELSE IF()
                                                                    ProductionMPDF(
                                                                            mid:
                                                                                4)
                                                                        .AMRP()
                                                                    //MACHINE 4 & STOCK
                                                                    : (reportValue ==
                                                                            "Stock")
                                                                        ? //ELSE IF()
                                                                        StockMPDF(mid: 4)
                                                                            .AMRS()
                                                                        //MACHINE 4 & STOCK
                                                                        : (reportValue == "Cost Price")
                                                                            ? //ELSE IF()
                                                                            CostMPDF(mid: 4).AMRCS()
                                                                            //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                                            : AwesomeDialog(
                                                                                context: context,
                                                                                animType: AnimType.leftSlide,
                                                                                dialogType: DialogType.warning,
                                                                                title: "Choose Report First!",
                                                                                useRootNavigator: true,
                                                                                autoHide: Duration(seconds: 2),
                                                                              ).show()
                                                        //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN MACHINE //ELSE ()
                                                        : AwesomeDialog(
                                                            context: context,
                                                            animType: AnimType
                                                                .leftSlide,
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            title:
                                                                "Choose Machine First!",
                                                            useRootNavigator:
                                                                true,
                                                            autoHide: Duration(
                                                                seconds: 2),
                                                          ).show();
                                  },
                                  icon: Icon(
                                    Icons.download,
                                    size: blockVertical * 3,
                                    color: Colors.black87,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.leftSlide,
                                      dialogType: DialogType.warning,
                                      title:"Your Authorities Do Not Have The Right To Perform This Action!",
                                      useRootNavigator: true,
                                      autoHide: Duration(seconds: 2),
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.download,
                                    size: blockVertical * 3,
                                    color: Colors.black87,
                                  ))
                        ],
                      ),
//---------------------------------------------ISI PREVIEW CONTENT-----------------------------------------------//
                      SizedBox(
                        height: blockVertical * 55,
                        child:
                            //-----------------------ALL MACHINE ------------------------//
                            (mesinValue == "All Machine") // IF()
                                ? (reportValue == "All Report") //IF()
                                    //All Machine & All Report
                                    ? allMachine(blockHorizontal, blockVertical)
                                    //ALL MACHINE & PARAMETER
                                    : (reportValue == "Parameter")
                                        ? //ELSE IF()
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Parameter",
                                                style: TextStyle(
                                                    fontSize:
                                                        blockVertical * 2.5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    tableParameter(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        //ALL MACHINE & OEE
                                        : (reportValue == "OEE")
                                            ? //ELSE IF()
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Overall Equipment Effectiveness",
                                                    style: TextStyle(
                                                        fontSize:
                                                            blockVertical * 2.5,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        tableOEE(),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            //ALL MACHINE & PRODUCTION
                                            : (reportValue == "Production")
                                                ? //ELSE IF()
                                                Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Production",
                                                        style: TextStyle(
                                                            fontSize:
                                                                blockVertical *
                                                                    2.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            tableProduction(),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                //ALL MACHINE & STOCK
                                                : (reportValue == "Stock")
                                                    ? //ELSE IF()
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Stock",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    blockVertical *
                                                                        2.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                tableStock(),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    //ALL MACHINE & STOCK
                                                    : (reportValue ==
                                                            "Cost Price")
                                                        ? //ELSE IF()
                                                        Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Cost Price",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        blockVertical *
                                                                            2.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    tableCost(),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                  "No Content",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          blockVertical *
                                                                              3),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                //-----------------------MACHINE 1------------------------//
                                : (mesinValue == "Machine 1") // ELSE IF()
                                    ? (reportValue == "All Report") //IF()
                                        //Machine 1 & All Report
                                        ? Center(
                                            child: Text(
                                              "Machine 1 All Report",
                                              style: TextStyle(
                                                  fontSize: blockVertical * 3),
                                            ),
                                          )
                                        //Machine 1 & PARAMETER
                                        : (reportValue == "Parameter")
                                            ? //ELSE IF()
                                            ParameterPDF(
                                                mid: 1,
                                              )
                                            //Machine 1 & OEE
                                            : (reportValue == "OEE")
                                                ? //ELSE IF()
                                                OEEPDF(
                                                    mid: 1,
                                                  )
                                                //Machine 1 & PRODUCTION
                                                : (reportValue == "Production")
                                                    ? //ELSE IF()
                                                    ProductionPDF(
                                                        mid: 1,
                                                      )
                                                    //Machine 1 & STOCK
                                                    : (reportValue == "Stock")
                                                        ? //ELSE IF()
                                                        StockPDF(
                                                            mid: 1,
                                                          )
                                                        //Machine 1 & STOCK
                                                        : (reportValue ==
                                                                "Cost Price")
                                                            ? //ELSE IF()
                                                            CostPDF(
                                                                mid: 1,
                                                              )
                                                            //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                            : Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Center(
                                                                    child: Text(
                                                                      "No Content",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              blockVertical * 3),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                    //-----------------------MACHINE 2------------------------//
                                    : (mesinValue == "Machine 2") // ELSE IF()
                                        ? (reportValue == "All Report") //IF()
                                            //Machine 2 & All Report
                                            ? Center(
                                                child: Text(
                                                  "Machine 2 All Report",
                                                  style: TextStyle(
                                                      fontSize:
                                                          blockVertical * 3),
                                                ),
                                              )
                                            //Machine 2 & PARAMETER
                                            : (reportValue == "Parameter")
                                                ? //ELSE IF()
                                                ParameterPDF(
                                                    mid: 2,
                                                  )
                                                //Machine 2 & OEE
                                                : (reportValue == "OEE")
                                                    ? //ELSE IF()
                                                    OEEPDF(
                                                        mid: 2,
                                                      )
                                                    //Machine 2 & PRODUCTION
                                                    : (reportValue ==
                                                            "Production")
                                                        ? //ELSE IF()
                                                        ProductionPDF(
                                                            mid: 2,
                                                          )
                                                        //Machine 2 & STOCK
                                                        : (reportValue ==
                                                                "Stock")
                                                            ? //ELSE IF()
                                                            StockPDF(
                                                                mid: 2,
                                                              )
                                                            //Machine 2 & STOCK
                                                            : (reportValue ==
                                                                    "Cost Price")
                                                                ? //ELSE IF()
                                                                CostPDF(
                                                                    mid: 2,
                                                                  )
                                                                //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                                : Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          "No Content",
                                                                          style:
                                                                              TextStyle(fontSize: blockVertical * 3),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                        //-----------------------MACHINE 3------------------------//
                                        : (mesinValue ==
                                                "Machine 3") // ELSE IF()
                                            ? (reportValue ==
                                                    "All Report") //IF()
                                                //Machine 3 & All Report
                                                ? Center(
                                                    child: Text(
                                                      "Machine 3 All Report",
                                                      style: TextStyle(
                                                          fontSize:
                                                              blockVertical *
                                                                  3),
                                                    ),
                                                  )
                                                //Machine 3 & PARAMETER
                                                : (reportValue == "Parameter")
                                                    ? //ELSE IF()
                                                    ParameterPDF(
                                                        mid: 3,
                                                      )
                                                    //Machine 3 & OEE
                                                    : (reportValue == "OEE")
                                                        ? //ELSE IF()
                                                        OEEPDF(
                                                            mid: 3,
                                                          )
                                                        //Machine 3 & PRODUCTION
                                                        : (reportValue ==
                                                                "Production")
                                                            ? //ELSE IF()
                                                            ProductionPDF(
                                                                mid: 3,
                                                              )
                                                            //Machine 3 & STOCK
                                                            : (reportValue ==
                                                                    "Stock")
                                                                ? //ELSE IF()
                                                                StockPDF(
                                                                    mid: 3,
                                                                  )
                                                                //Machine 3 & STOCK
                                                                : (reportValue ==
                                                                        "Cost Price")
                                                                    ? //ELSE IF()
                                                                    CostPDF(
                                                                        mid: 3,
                                                                      )
                                                                    //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                                    : Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              "No Content",
                                                                              style: TextStyle(fontSize: blockVertical * 3),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                            //-----------------------MACHINE 4------------------------//
                                            : (mesinValue ==
                                                    "Machine 4") // ELSE IF()
                                                ? (reportValue ==
                                                        "All Report") //IF()
                                                    //Machine 4 & All Report
                                                    ? Center(
                                                        child: Text(
                                                          "Machine 1 All Report",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  blockVertical *
                                                                      3),
                                                        ),
                                                      )
                                                    //Machine 4 & PARAMETER
                                                    : (reportValue ==
                                                            "Parameter")
                                                        ? //ELSE IF()
                                                        ParameterPDF(
                                                            mid: 4,
                                                          )
                                                        //Machine 4 & OEE
                                                        : (reportValue == "OEE")
                                                            ? //ELSE IF()
                                                            OEEPDF(
                                                                mid: 4,
                                                              )
                                                            //Machine 4 & PRODUCTION
                                                            : (reportValue ==
                                                                    "Production")
                                                                ? //ELSE IF()
                                                                ProductionPDF(
                                                                    mid: 4,
                                                                  )
                                                                //Machine 4 & STOCK
                                                                : (reportValue ==
                                                                        "Stock")
                                                                    ? //ELSE IF()
                                                                    StockPDF(
                                                                        mid: 4,
                                                                      )
                                                                    //Machine 4 & COST PRICE
                                                                    : (reportValue ==
                                                                            "Cost Price")
                                                                        ? //ELSE IF()
                                                                        CostPDF(
                                                                            mid:
                                                                                4,
                                                                          )
                                                                        //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN REPORT //ELSE ()
                                                                        : Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Center(
                                                                                child: Text(
                                                                                  "No Content",
                                                                                  style: TextStyle(fontSize: blockVertical * 3),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                //ELSE KONDISI DIMANA TIDAK TERPILIH SATU PUN MACHINE //ELSE ()
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          "No Content",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  blockVertical *
                                                                      3),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
//---------------------------------------------ISI PREVIEW CONTENT END-----------------------------------------------//
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //---------------------------ALL MACHINE CONTENT-----------------------------------//
  Widget allMachine(double blockHorizontal, double blockVertical) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Stock",
            style: TextStyle(
                fontSize: blockVertical * 2.5, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tableStock(),
              ],
            ),
          ),
          SizedBox(
            height: blockVertical * 1,
          ),
          Text(
            "Production",
            style: TextStyle(
                fontSize: blockVertical * 2.5, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tableProduction(),
              ],
            ),
          ),
          SizedBox(
            height: blockVertical * 1,
          ),
          Text(
            "Overall Equipment Effectiveness",
            style: TextStyle(
                fontSize: blockVertical * 2.5, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tableOEE(),
              ],
            ),
          ),
          SizedBox(
            height: blockVertical * 1,
          ),
          Text(
            "Parameter",
            style: TextStyle(
                fontSize: blockVertical * 2.5, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tableParameter(),
              ],
            ),
          ),
          SizedBox(
            height: blockVertical * 1,
          ),
          Text(
            "Cost Price",
            style: TextStyle(
                fontSize: blockVertical * 2.5, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tableCost(),
              ],
            ),
          ),
          SizedBox(
            height: blockVertical * 2,
          )
        ],
      ),
    );
  }
  //---------------------------ALL MACHINE CONTENT END-----------------------------------//

  //---------------------------PILIH MENU-----------------------------------//
  Widget Dropdown(double blockHorizontal, double blockVertical) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //-----------------DROPDOWN MENU--------------------//
        Text(
          " Choose Machine : ",
          style: TextStyle(
              fontSize: blockVertical * 2.5, fontWeight: FontWeight.bold),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: blockHorizontal * 5),
          height: blockVertical * 7,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            borderRadius: BorderRadius.circular(blockVertical * 1),
            border: Border.all(
              color: (mesinValue == null)
                  ? Color.fromARGB(255, 224, 224, 224)
                  : Color.fromARGB(255, 24, 142, 238),
            ),
          ),
          child: DropdownSearch<String>(
            enabled: (otoritas == "Admin" || otoritas == "User-Management")
                ? true
                : false,
            clearButtonProps: ClearButtonProps(
              isVisible: true,
            ),
            popupProps: PopupProps.menu(
              constraints: BoxConstraints(maxHeight: blockVertical * 30),
              showSelectedItems: true,
            ),
            items: mesin,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Choose Machine",
                hintText: "Machine",
              ),
            ),
            onChanged: (value) {
              setState(() {
                mesinValue = value;
              });
              print(mesinValue);
            },
          ),
        ),
        SizedBox(
          height: blockVertical * 1,
        ),
        Text(
          " Choose Report : ",
          style: TextStyle(
              fontSize: blockVertical * 2.5, fontWeight: FontWeight.bold),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: blockHorizontal * 5),
          height: blockVertical * 7,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            borderRadius: BorderRadius.circular(blockVertical * 1),
            border: Border.all(
              color: (reportValue == null)
                  ? Color.fromARGB(255, 224, 224, 224)
                  : Color.fromARGB(255, 24, 142, 238),
            ),
          ),
          child: DropdownSearch<String>(
            enabled: (mesinValue != null) ? true : false,
            clearButtonProps: ClearButtonProps(
              isVisible: true,
            ),
            popupProps: PopupProps.menu(
              constraints: BoxConstraints(maxHeight: blockVertical * 30),
              showSelectedItems: true,
              disabledItemFn: (mesinValue != "All Machine")
                  ? (String s) => s.startsWith('All')
                  : (String s) => s.startsWith('Zfafda'),
            ),
            items: report,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Choose Report",
                hintText: "Report",
              ),
            ),
            onChanged: (value) {
              setState(() {
                reportValue = value;
              });
              print(reportValue);
            },
          ),
        )
      ],
    );
    //---------------------------PILIH MENU END-----------------------------------//
  }
  //---------------------------PILIH MENU-----------------------------------//
}
