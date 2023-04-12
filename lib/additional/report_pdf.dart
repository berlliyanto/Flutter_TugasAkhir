import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_application_1/Services/costprice_service.dart';
import 'package:flutter_application_1/Services/oee_service.dart';
import 'package:flutter_application_1/Services/param_service.dart';
import 'package:flutter_application_1/Services/quality_service.dart';
import 'package:flutter_application_1/models/costprice_model.dart';
import 'package:flutter_application_1/models/oee_model.dart';
import 'package:flutter_application_1/models/param_model.dart';
import 'package:flutter_application_1/models/quality_model.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_application_1/Services/stock.services.dart';
import 'package:flutter_application_1/models/stock_model.dart';

//STOCK ALL
StreamController<List> streamStock = StreamController.broadcast();
List<allstockModel> stockList = [];
readStock getstockM1 = readStock();
Future<void> stockData() async {
  stockList = await getstockM1.getallStock();
  streamStock.add(stockList);
}

//PRODUCTION ALL
StreamController<List> streamProd = StreamController.broadcast();
List<dashQuality> QList = [];
dashQualityy Quality = dashQualityy();
Future<void> QualityData() async {
  QList = await Quality.dashQualityM();
  streamProd.add(QList);
}

//OEE ALL
StreamController<List> streamOEE = StreamController.broadcast();
List<OEEdashModel> OEEList = [];
getOEE OEE = getOEE();
Future<void> OEEData() async {
  OEEList = await OEE.dashOEE();
  streamOEE.add(OEEList);
}

//Parameter ALL
StreamController<List> streamParam = StreamController.broadcast();
List<paramReportModel> ParamList = [];
reportParam Param = reportParam();
Future<void> ParamData() async {
  ParamList = await Param.getParam();
  streamParam.add(ParamList);
}

//COST PRICE ALL
StreamController<List> streamCost = StreamController.broadcast();
List<getCostdashModel> CostList = [];
getDashCost Cost = getDashCost();
Future<void> CostData() async {
  CostList = await Cost.getCostDash();
  streamCost.add(CostList);
}

//----------------------------------ALL MACHINE & ALL REPORT---------------------------------------//
Future<void> allmachinePDF() async {
  await stockData();
  await QualityData();
  await OEEData();
  await ParamData();
  await CostData();

  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Text(
              "PRODUCTION MONITORING SYSTEM REPORT",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.Center(
            child: pw.Text(
              "4 MACHINE",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            "PRODUCTION",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
              cellStyle: pw.TextStyle(fontSize: 12),
              headerStyle:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              headerAlignment: pw.Alignment.center,
              cellAlignment: pw.Alignment.center,
              headers: [
                'Machine',
                'Latest Update',
                'Type',
                'Processed (unit)',
                'Good (unit)',
                'Defect (unit)',
              ],
              data: QList.map((e) => [
                    "${e.machine_id}",
                    (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .parse(e.updatedAt!)
                        .toLocal()
                        .toString()
                        .split(' ')[0]),
                    "${e.tipe}",
                    "${e.processed}",
                    "${e.good}",
                    "${e.defect}",
                  ]).toList()),
          pw.SizedBox(height: 10),
          pw.Text(
            "OVERALL EQUIPMENT EFFECTIVENESS",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
              cellStyle: pw.TextStyle(fontSize: 12),
              headerStyle:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              headerAlignment: pw.Alignment.center,
              cellAlignment: pw.Alignment.center,
              headers: [
                'Machine',
                'Latest Update',
                'Availability (%)',
                'Performance (%)',
                'Quality (%)',
                'OEE Result (%)'
              ],
              data: OEEList.map((e) => [
                    "${e.machine_id}",
                    (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .parse(e.updatedAt!)
                        .toLocal()
                        .toString()
                        .split(' ')[0]),
                    "${(e.availability * 100).toStringAsFixed(2)}",
                    "${(e.performance * 100).toStringAsFixed(2)}",
                    "${(e.quality * 100).toStringAsFixed(2)}",
                    "${(e.nilaioee * 100).toStringAsFixed(2)}",
                  ]).toList()),
          pw.SizedBox(height: 10),
          pw.Text(
            "PARAMETER",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
              cellStyle: pw.TextStyle(fontSize: 12),
              headerStyle:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              headerAlignment: pw.Alignment.center,
              cellAlignment: pw.Alignment.center,
              headers: [
                'Machine',
                'Latest Update',
                'Type',
                'Loading Time (menit)',
                'Cycle Time (menit)',
                'OEE Target (%)',
              ],
              data: ParamList.map((e) => [
                    "${e.machine_id}",
                    (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .parse(e.updatedAt!)
                        .toLocal()
                        .toString()
                        .split(' ')[0]),
                    "${e.tipe_benda}",
                    "${e.loading_time}",
                    "${e.cycle_time}",
                    "${e.oee_target}",
                  ]).toList()),
          pw.SizedBox(height: 10),
          pw.Text(
            "STOCK",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
              cellStyle: pw.TextStyle(fontSize: 12),
              headerStyle:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              headerAlignment: pw.Alignment.center,
              cellAlignment: pw.Alignment.center,
              headers: [
                'Machine',
                'Latest Update',
                'Type A (unit)',
                'Type B (unit)',
                'Type C (unit)',
              ],
              data: stockList
                  .map((e) => [
                        "${e.machine_id}",
                        (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                            .parse(e.updatedAt!)
                            .toLocal()
                            .toString()
                            .split(' ')[0]),
                        "${e.A}",
                        "${e.B}",
                        "${e.C}"
                      ])
                  .toList()),
          pw.SizedBox(height: 70),
          pw.Text(
            "COST PRICE",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
            cellStyle: pw.TextStyle(fontSize: 12),
            headerStyle:
                pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            headers: [
              'Machine',
              'Latest Update',
              'Type',
              'Good Processed',
              'Unit Price',
              'Total Price',
            ],
            data: CostList.map(
              (e) => [
                "${e.machine_id}",
                (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    .parse(e.updatedAt!)
                    .toLocal()
                    .toString()
                    .split(' ')[0]),
                "${e.tipe}",
                "${e.good}",
                "${e.harga_unit}",
                "${e.total_harga}",
              ],
            ).toList(),
          ),
        ];
      },
    ),
  ); // Page
  // SIMPAN
  Uint8List bytes = await pdf.save();

  // buat file kosong di directory
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/Production Monitoring Report.pdf');

  // timpa file kosong dengan file pdf
  await file.writeAsBytes(bytes);

  //open pdf
  await OpenFile.open(file.path);
}
//----------------------------------ALL MACHINE & ALL REPORT END---------------------------------------//

//----------------------------------ALL MACHINE REPORT PRODUCTION---------------------------------------//

Future<void> AMRP() async {
  await QualityData();
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Text(
              "PRODUCTION REPORT",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.Center(
            child: pw.Text(
              "4 MACHINE",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            "PRODUCTION",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
            cellStyle: pw.TextStyle(fontSize: 12),
            headerStyle:
                pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            headers: [
              'Machine',
              'Latest Update',
              'Type',
              'Processed (unit)',
              'Good (unit)',
              'Defect (unit)',
            ],
            data: QList.map(
              (e) => [
                "${e.machine_id}",
                (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    .parse(e.updatedAt!)
                    .toLocal()
                    .toString()
                    .split(' ')[0]),
                "${e.tipe}",
                "${e.processed}",
                "${e.good}",
                "${e.defect}",
              ],
            ).toList(),
          ),
        ];
      },
    ),
  ); // Page
  // SIMPAN
  Uint8List bytes = await pdf.save();

  // buat file kosong di directory
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/Production Report.pdf');

  // timpa file kosong dengan file pdf
  await file.writeAsBytes(bytes);

  //open pdf
  await OpenFile.open(file.path);
}

//----------------------------------ALL MACHINE REPORT OEE---------------------------------------//

Future<void> AMROEE() async {
  await OEEData();
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Text(
              "OEE REPORT",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.Center(
            child: pw.Text(
              "4 MACHINE",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            "OVERALL EQUIPMENT EFFECTIVENESS",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
            cellStyle: pw.TextStyle(fontSize: 12),
            headerStyle:
                pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            headers: [
              'Machine',
              'Latest Update',
              'Availability (%)',
              'Performance (%)',
              'Quality (%)',
              'OEE Result (%)'
            ],
            data: OEEList.map(
              (e) => [
                "${e.machine_id}",
                (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    .parse(e.updatedAt!)
                    .toLocal()
                    .toString()
                    .split(' ')[0]),
                "${(e.availability * 100).toStringAsFixed(2)}",
                "${(e.performance * 100).toStringAsFixed(2)}",
                "${(e.quality * 100).toStringAsFixed(2)}",
                "${(e.nilaioee * 100).toStringAsFixed(2)}",
              ],
            ).toList(),
          ),
        ];
      },
    ),
  ); // Page
  // SIMPAN
  Uint8List bytes = await pdf.save();

  // buat file kosong di directory
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/OEE Report.pdf');

  // timpa file kosong dengan file pdf
  await file.writeAsBytes(bytes);

  //open pdf
  await OpenFile.open(file.path);
}

//----------------------------------ALL MACHINE REPORT PARAMETER---------------------------------------//

Future<void> AMRPARAM() async {
  await ParamData();
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Text(
              "PARAMETER REPORT",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.Center(
            child: pw.Text(
              "4 MACHINE",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            "PARAMETER",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
            cellStyle: pw.TextStyle(fontSize: 12),
            headerStyle:
                pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            headers: [
              'Machine',
              'Latest Update',
              'Type',
              'Loading Time (menit)',
              'Cycle Time (menit)',
              'OEE Target (%)',
            ],
            data: ParamList.map(
              (e) => [
                "${e.machine_id}",
                (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    .parse(e.updatedAt!)
                    .toLocal()
                    .toString()
                    .split(' ')[0]),
                "${e.tipe_benda}",
                "${e.loading_time}",
                "${e.cycle_time}",
                "${e.oee_target}",
              ],
            ).toList(),
          ),
        ];
      },
    ),
  ); // Page
  // SIMPAN
  Uint8List bytes = await pdf.save();

  // buat file kosong di directory
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/Parameter Report.pdf');

  // timpa file kosong dengan file pdf
  await file.writeAsBytes(bytes);

  //open pdf
  await OpenFile.open(file.path);
}

//----------------------------------ALL MACHINE REPORT STOCK---------------------------------------//

Future<void> AMRS() async {
  await stockData();
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Text(
              "STOCK REPORT",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.Center(
            child: pw.Text(
              "4 MACHINE",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            "STOCK",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
            cellStyle: pw.TextStyle(fontSize: 12),
            headerStyle:
                pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            headers: [
              'Machine',
              'Latest Update',
              'Type A (unit)',
              'Type B (unit)',
              'Type C (unit)',
            ],
            data: stockList
                .map(
                  (e) => [
                    "${e.machine_id}",
                    (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .parse(e.updatedAt!)
                        .toLocal()
                        .toString()
                        .split(' ')[0]),
                    "${e.A}",
                    "${e.B}",
                    "${e.C}"
                  ],
                )
                .toList(),
          ),
        ];
      },
    ),
  ); // Page
  // SIMPAN
  Uint8List bytes = await pdf.save();

  // buat file kosong di directory
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/Stock Report.pdf');

  // timpa file kosong dengan file pdf
  await file.writeAsBytes(bytes);

  //open pdf
  await OpenFile.open(file.path);
}
//----------------------------------ALL MACHINE REPORT COST PRICE---------------------------------------//

Future<void> AMRCS() async {
  await CostData();
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Text(
              "COST PRICE REPORT",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.Center(
            child: pw.Text(
              "4 MACHINE",
              softWrap: true,
              style:
                  pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            "COST PRICE",
            softWrap: true,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Table.fromTextArray(
            cellStyle: pw.TextStyle(fontSize: 12),
            headerStyle:
                pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            headers: [
              'Machine',
              'Latest Update',
              'Type',
              'Good Processed',
              'Unit Price',
              'Total Price',
            ],
            data: CostList
                .map(
                  (e) => [
                    "${e.machine_id}",
                    (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .parse(e.updatedAt!)
                        .toLocal()
                        .toString()
                        .split(' ')[0]),
                    "${e.tipe}",
                    "${e.good}",
                    "${e.harga_unit}",
                    "${e.total_harga}"
                  ],
                )
                .toList(),
          ),
        ];
      },
    ),
  ); // Page
  // SIMPAN
  Uint8List bytes = await pdf.save();

  // buat file kosong di directory
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/Cost Price Report.pdf');

  // timpa file kosong dengan file pdf
  await file.writeAsBytes(bytes);

  //open pdf
  await OpenFile.open(file.path);
}
