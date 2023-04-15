// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/costprice_service.dart';
import 'package:flutter_application_1/Services/oee_service.dart';
import 'package:flutter_application_1/Services/param_service.dart';
import 'package:flutter_application_1/Services/quality_service.dart';
import 'package:flutter_application_1/models/costprice_model.dart';
import 'package:flutter_application_1/models/oee_model.dart';
import 'package:flutter_application_1/models/param_model.dart';
import 'package:flutter_application_1/models/quality_model.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/stock.services.dart';
import '../models/stock_model.dart';

//-------------------------------------------------ALL MACHINE---------------------------------------------------//
//---------------------------------------TABLE STOCK-----------------------------------------//
class tableStock extends StatefulWidget {
  const tableStock({super.key});

  @override
  State<tableStock> createState() => _tableStockState();
}

class _tableStockState extends State<tableStock> {
  StreamController<List> streamStock = StreamController.broadcast();
  List<allstockModel> stockList = [];
  readStock getstockM1 = readStock();
  Future<void> stockData() async {
    stockList = await getstockM1.getallStock();
    streamStock.add(stockList);
  }

  @override
  void initState() {
    stockData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder<Object>(
        stream: streamStock.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return DataTable(
            headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> state) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }),
            border: TableBorder(
              top: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              left: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              right: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              bottom: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(blockVertical * 2),
              verticalInside: BorderSide(
                width: blockVertical * 0.2,
                color: Colors.black.withOpacity(0.3),
              ),
              horizontalInside: BorderSide(
                width: 3,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            columns: [
              DataColumn(
                  label: Text(
                "Machine",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Latest Update",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Type A",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Type B",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Type C",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
            ],
            rows: stockList.map((e) {
              var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                  .parse(e.updatedAt!)
                  .toLocal()
                  .toString()
                  .split(' ')[0];
              return DataRow(cells: [
                DataCell(Text(
                  "Machine ${e.machine_id}",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  date,
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.A} Unit",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.B} Unit",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.C} Unit ",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
              ]);
            }).toList(),
          );
        });
  }
}

//---------------------------------------TABLE PRODUCTION-----------------------------------------//
class tableProduction extends StatefulWidget {
  const tableProduction({super.key});

  @override
  State<tableProduction> createState() => _tableProductionState();
}

class _tableProductionState extends State<tableProduction> {
  //PRODUCTION
  StreamController<List> streamProd = StreamController.broadcast();
  List<dashQuality> QList = [];
  dashQualityy Quality = dashQualityy();
  Future<void> QualityData() async {
    QList = await Quality.dashQualityM();
    streamProd.add(QList);
  }

  @override
  void initState() {
    QualityData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder(
        stream: streamProd.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return DataTable(
            headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> state) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }),
            border: TableBorder(
              top: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              left: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              right: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              bottom: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(blockVertical * 2),
              verticalInside: BorderSide(
                width: blockVertical * 0.2,
                color: Colors.black.withOpacity(0.3),
              ),
              horizontalInside: BorderSide(
                width: 3,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            columns: [
              DataColumn(
                  label: Text(
                "Machine",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Latest Update",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Type",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Processed",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Good Processed",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Defect Processed",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
            ],
            rows: QList.map((e) {
              var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                  .parse(e.updatedAt!)
                  .toLocal()
                  .toString()
                  .split(' ')[0];
              return DataRow(cells: [
                DataCell(Text(
                  "Machine ${e.machine_id}",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  date,
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.tipe}",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.processed} Unit",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.good} Unit ",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.defect} Unit ",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
              ]);
            }).toList(),
          );
        });
  }
}

//---------------------------------------TABLE OEE-----------------------------------------//
class tableOEE extends StatefulWidget {
  const tableOEE({super.key});

  @override
  State<tableOEE> createState() => _tableOEEState();
}

class _tableOEEState extends State<tableOEE> {
  //OEE
  StreamController<List> streamOEE = StreamController.broadcast();
  List<OEEdashModel> OEEList = [];
  getOEE OEE = getOEE();
  Future<void> OEEData() async {
    OEEList = await OEE.dashOEE();
    streamOEE.add(OEEList);
  }

  @override
  void initState() {
    OEEData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder(
        stream: streamOEE.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return DataTable(
            headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> state) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }),
            border: TableBorder(
              top: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              left: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              right: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              bottom: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(blockVertical * 2),
              verticalInside: BorderSide(
                width: blockVertical * 0.2,
                color: Colors.black.withOpacity(0.3),
              ),
              horizontalInside: BorderSide(
                width: 3,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            columns: [
              DataColumn(
                  label: Text(
                "Machine",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Latest Update",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Availability",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Performance",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Quality",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "OEE Result",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
            ],
            rows: OEEList.map((e) {
              var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                  .parse(e.updatedAt!)
                  .toLocal()
                  .toString()
                  .split(' ')[0];
              return DataRow(cells: [
                DataCell(Text(
                  "Machine ${e.machine_id}",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  date,
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${(e.availability * 100).toStringAsFixed(2)} %",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${(e.performance * 100).toStringAsFixed(2)} % ",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${(e.quality * 100).toStringAsFixed(2)} % ",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${(e.nilaioee * 100).toStringAsFixed(2)} % ",
                  style: TextStyle(
                      fontSize: blockVertical * 2,
                      color: (e.nilaioee * 100 >= 85)
                          ? Color.fromARGB(255, 8, 230, 15)
                          : Color.fromARGB(255, 243, 16, 0)),
                )),
              ]);
            }).toList(),
          );
        });
  }
}

//---------------------------------------TABLE PARAMETER-----------------------------------------//
class tableParameter extends StatefulWidget {
  const tableParameter({super.key});

  @override
  State<tableParameter> createState() => _tableParameterState();
}

class _tableParameterState extends State<tableParameter> {
  //Parameter
  StreamController<List> streamParam = StreamController.broadcast();
  List<paramReportModel> ParamList = [];
  reportParam Param = reportParam();
  Future<void> ParamData() async {
    ParamList = await Param.getParam();
    streamParam.add(ParamList);
  }

  @override
  void initState() {
    ParamData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder(
        stream: streamParam.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return DataTable(
            headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> state) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }),
            border: TableBorder(
              top: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              left: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              right: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              bottom: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(blockVertical * 2),
              verticalInside: BorderSide(
                width: blockVertical * 0.2,
                color: Colors.black.withOpacity(0.3),
              ),
              horizontalInside: BorderSide(
                width: 3,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            columns: [
              DataColumn(
                  label: Text(
                "Machine",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Latest Update",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Type",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Loading Time",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Cycle Time",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "OEE Target",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
            ],
            rows: ParamList.map((e) {
              var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                  .parse(e.updatedAt!)
                  .toLocal()
                  .toString()
                  .split(' ')[0];
              return DataRow(cells: [
                DataCell(Text(
                  "Machine ${e.machine_id}",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  date,
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.tipe_benda}",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.loading_time} Menit ",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.cycle_time} Menit ",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text("${e.oee_target} % ",
                    style: TextStyle(
                      fontSize: blockVertical * 2,
                    ))),
              ]);
            }).toList(),
          );
        });
  }
}

//---------------------------------------TABLE COST PRICE-----------------------------------------//
class tableCost extends StatefulWidget {
  const tableCost({super.key});

  @override
  State<tableCost> createState() => _tableCostState();
}

class _tableCostState extends State<tableCost> {
  //Cost
  StreamController<List> streamCost = StreamController.broadcast();
  List<getCostdashModel> CostList = [];
  getDashCost Cost = getDashCost();
  Future<void> CostData() async {
    CostList = await Cost.getCostDash();
    streamCost.add(CostList);
  }

  @override
  void initState() {
    CostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder(
        stream: streamCost.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return DataTable(
            headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> state) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }),
            border: TableBorder(
              top: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              left: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              right: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              bottom: BorderSide(
                  width: blockVertical * 0.2,
                  color: Colors.black.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(blockVertical * 2),
              verticalInside: BorderSide(
                width: blockVertical * 0.2,
                color: Colors.black.withOpacity(0.3),
              ),
              horizontalInside: BorderSide(
                width: 3,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            columns: [
              DataColumn(
                  label: Text(
                "Machine",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Latest Update",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Type",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Good Processed",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Unit Price",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
              DataColumn(
                  label: Text(
                "Total Price",
                style:
                    TextStyle(color: Colors.black, fontSize: blockVertical * 2),
              )),
            ],
            rows: CostList.map((e) {
              var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                  .parse(e.updatedAt!)
                  .toLocal()
                  .toString()
                  .split(' ')[0];
              return DataRow(cells: [
                DataCell(Text(
                  "Machine ${e.machine_id}",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  date,
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.tipe}",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "${e.good} Unit",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text(
                  "Rp.${e.harga_unit},-",
                  style: TextStyle(fontSize: blockVertical * 2),
                )),
                DataCell(Text("Rp.${e.total_harga},-",
                    style: TextStyle(
                      fontSize: blockVertical * 2,
                    ))),
              ]);
            }).toList(),
          );
        });
  }
}
//---------------------------------------------------ALL MACHINE END-----------------------------------------------//

//---------------------------------------------------SINGLE MACHINE-----------------------------------------------//
//---------------PRODUCTION--------------//
class ProductionPDF extends StatefulWidget {
  late int? mid;
  ProductionPDF({super.key, this.mid});

  @override
  State<ProductionPDF> createState() => _ProductionPDFState();
}

class _ProductionPDFState extends State<ProductionPDF> {
  int i = 1;
  StreamController<List> streamProcessed = StreamController.broadcast();
  List<recQuality> stockProcessed = [];
  recordQuality getStockprocessed = recordQuality();
  Future<void> processedData() async {
    stockProcessed = await getStockprocessed.getrecQuality(widget.mid!);
    streamProcessed.add(stockProcessed);
  }

  @override
  void initState() {
    processedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder<Object>(
        stream: streamProcessed.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Production Machine ${widget.mid}",
                  style: TextStyle(
                      fontSize: blockVertical * 2.5,
                      fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DataTable(
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> state) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          }),
                          border: TableBorder(
                            top: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            left: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            right: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            bottom: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            borderRadius:
                                BorderRadius.circular(blockVertical * 2),
                            verticalInside: BorderSide(
                              width: blockVertical * 0.2,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            horizontalInside: BorderSide(
                              width: 3,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          columns: [
                            DataColumn(
                                label: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Latest Update",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Processed",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Good Processed",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Defect Processed",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                          ],
                          rows: stockProcessed.map((e) {
                            var date =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(e.createdAt!)
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];
                            return DataRow(cells: [
                              DataCell(Text(
                                "${i++}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                date,
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.tipe}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.processed} Unit",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.good} Unit ",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.defect} Unit ",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                            ]);
                          }).toList(),
                        )
                      ]),
                ),
              ],
            ),
          );
        });
  }
}

//---------------STOCK--------------//
class StockPDF extends StatefulWidget {
  late int? mid;
  StockPDF({super.key, this.mid});

  @override
  State<StockPDF> createState() => _StockPDFState();
}

class _StockPDFState extends State<StockPDF> {
  int i = 1;
  StreamController<List> streamRiwayatStock = StreamController.broadcast();
  List<historimodel> riwayatStockList = [];
  getriwayat getriwayatstockM1 = getriwayat();
  Future<void> riwayatstockData() async {
    riwayatStockList = await getriwayatstockM1.gethistori(widget.mid!);
    streamRiwayatStock.add(riwayatStockList);
  }

  @override
  void initState() {
    riwayatstockData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder<Object>(
        stream: streamRiwayatStock.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "History Stock In Machine ${widget.mid}",
                  style: TextStyle(
                      fontSize: blockVertical * 2.5,
                      fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DataTable(
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> state) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          }),
                          border: TableBorder(
                            top: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            left: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            right: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            bottom: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            borderRadius:
                                BorderRadius.circular(blockVertical * 2),
                            verticalInside: BorderSide(
                              width: blockVertical * 0.2,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            horizontalInside: BorderSide(
                              width: 3,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          columns: [
                            DataColumn(
                                label: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Latest Update",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Stock In",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                          ],
                          rows: riwayatStockList.map((e) {
                            var date =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(e.createdAt!)
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];
                            return DataRow(cells: [
                              DataCell(Text(
                                "${i++}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                date,
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.tipe}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.jumlah} Unit",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                            ]);
                          }).toList(),
                        )
                      ]),
                ),
              ],
            ),
          );
        });
  }
}

//---------------COST PRICE--------------//
class CostPDF extends StatefulWidget {
  late int? mid;
  CostPDF({super.key, this.mid});

  @override
  State<CostPDF> createState() => _CostPDFState();
}

class _CostPDFState extends State<CostPDF> {
  int i = 1;
  StreamController streamCostH = StreamController.broadcast();
  List<getCostHModel> listCostH = [];
  getCostHistori latestCostH = getCostHistori();
  Future<void> CostHData() async {
    listCostH = await latestCostH.getCostH(widget.mid!);
    streamCostH.add(listCostH);
  }

  @override
  void initState() {
    CostHData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder(
        stream: streamCostH.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "History Cost Price Machine ${widget.mid}",
                  style: TextStyle(
                      fontSize: blockVertical * 2.5,
                      fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DataTable(
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> state) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          }),
                          border: TableBorder(
                            top: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            left: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            right: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            bottom: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            borderRadius:
                                BorderRadius.circular(blockVertical * 2),
                            verticalInside: BorderSide(
                              width: blockVertical * 0.2,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            horizontalInside: BorderSide(
                              width: 3,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          columns: [
                            DataColumn(
                                label: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Latest Update",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Good Processed",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Unit Price (Rp)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Total Price (Rp)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                          ],
                          rows: listCostH.map((e) {
                            var date =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(e.updatedAt!)
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];

                            return DataRow(cells: [
                              DataCell(Text(
                                "${i++}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                date,
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.tipe}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.good} Unit",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.harga_unit},-",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.total_harga},-",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                            ]);
                          }).toList(),
                        )
                      ]),
                ),
              ],
            ),
          );
        });
  }
}

//---------------PARAMETER--------------//
class ParameterPDF extends StatefulWidget {
  late int? mid;
  ParameterPDF({super.key, this.mid});

  @override
  State<ParameterPDF> createState() => _ParameterPDFState();
}

class _ParameterPDFState extends State<ParameterPDF> {
  int i = 1;
  StreamController streamParamH = StreamController.broadcast();
  List<paramReportModel> listParamH = [];
  HistoriParam latestParamH = HistoriParam();
  Future<void> ParamHData() async {
    listParamH = await latestParamH.getParam(widget.mid!);
    streamParamH.add(listParamH);
  }

  @override
  void initState() {
    ParamHData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder(
        stream: streamParamH.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "History Parameter Machine ${widget.mid}",
                  style: TextStyle(
                      fontSize: blockVertical * 2.5,
                      fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DataTable(
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> state) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          }),
                          border: TableBorder(
                            top: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            left: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            right: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            bottom: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            borderRadius:
                                BorderRadius.circular(blockVertical * 2),
                            verticalInside: BorderSide(
                              width: blockVertical * 0.2,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            horizontalInside: BorderSide(
                              width: 3,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          columns: [
                            DataColumn(
                                label: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Latest Update",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Loading Time (Minute)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Cycle Time (Minute)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "OEE Target (%)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                          ],
                          rows: listParamH.map((e) {
                            var date =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(e.updatedAt!)
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];

                            return DataRow(cells: [
                              DataCell(Text(
                                "${i++}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                date,
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.tipe_benda}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.loading_time}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.cycle_time}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${e.oee_target}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                            ]);
                          }).toList(),
                        )
                      ]),
                ),
              ],
            ),
          );
        });
  }
}

//---------------OEE--------------//
class OEEPDF extends StatefulWidget {
  late int? mid;
  OEEPDF({super.key, this.mid});

  @override
  State<OEEPDF> createState() => _OEEPDFState();
}

class _OEEPDFState extends State<OEEPDF> {
  int i = 1;
  StreamController streamOEEH = StreamController.broadcast();
  List<OEEHistoriModel> listOEEH = [];
  OEEHistori latestOEEH = OEEHistori();
  Future<void> OEEHData() async {
    listOEEH = await latestOEEH.HistoryOEE(widget.mid!);
    streamOEEH.add(listOEEH);
  }

  @override
  void initState() {
    OEEHData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return StreamBuilder(
        stream: streamOEEH.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "History Parameter Machine ${widget.mid}",
                  style: TextStyle(
                      fontSize: blockVertical * 2.5,
                      fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DataTable(
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> state) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          }),
                          border: TableBorder(
                            top: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            left: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            right: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            bottom: BorderSide(
                                width: blockVertical * 0.2,
                                color: Colors.black.withOpacity(0.3)),
                            borderRadius:
                                BorderRadius.circular(blockVertical * 2),
                            verticalInside: BorderSide(
                              width: blockVertical * 0.2,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            horizontalInside: BorderSide(
                              width: 3,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          columns: [
                            DataColumn(
                                label: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Latest Update",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Availability (%)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Performance (%)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "Quality (%)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                            DataColumn(
                                label: Text(
                              "OEE Result (%)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: blockVertical * 2),
                            )),
                          ],
                          rows: listOEEH.map((e) {
                            var date =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(e.updatedAt!)
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];

                            return DataRow(cells: [
                              DataCell(Text(
                                "${i++}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                date,
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${(e.availability * 100).toStringAsFixed(2)}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${(e.performance * 100).toStringAsFixed(2)}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${(e.quality * 100).toStringAsFixed(2)}",
                                style: TextStyle(fontSize: blockVertical * 2),
                              )),
                              DataCell(Text(
                                "${(e.nilaioee * 100).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: blockVertical * 2,
                                    color: (e.nilaioee * 100 >= 85)
                                        ? Color.fromARGB(255, 8, 230, 15)
                                        : Color.fromARGB(255, 243, 16, 0)),
                              )),
                            ]);
                          }).toList(),
                        )
                      ]),
                ),
              ],
            ),
          );
        });
  }
}
//---------------------------------------------------SINGLE MACHINE END-----------------------------------------------//