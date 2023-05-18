import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_application_1/Services/troubleshoot_service.dart';
import 'package:flutter_application_1/models/troubleshoot_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class reportTrouble {
  late int? mid;
  reportTrouble({this.mid});

  int i = 1;
  final timeZone = tz.getLocation('Asia/Jakarta');
  StreamController streamOrder = StreamController.broadcast();
  List<getTB> ListOrder = [];
  GetData orderList = GetData();
  Future<void> OrderData() async {
    ListOrder = await orderList.getRecTB(mid!);
    streamOrder.add(ListOrder);
  }

  Future<void> Trouble() async {
    await OrderData();
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Text(
                "Troubleshoot Report",
                softWrap: true,
                style:
                    pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "MACHINE $mid",
                softWrap: true,
                style:
                    pw.TextStyle(fontBold: pw.Font.courierBold(), fontSize: 16),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "History Trouble",
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
                  'No',
                  'Id Order',
                  'Order From',
                  'Order Date',
                  'Done By',
                  'Done Date',
                  'Message',
                  'Status'
                ],
                data: ListOrder.map((e) {
                  //FORMAT TANGGAL ASIA/JAKARTA
                  final TScreatedAt = DateTime.parse(e.createdAt!);
                  final NowCreatedAt =
                      tz.TZDateTime.from(TScreatedAt, timeZone);
                  final TSupdatedAt = DateTime.parse(e.updatedAt!);
                  final NowupdatedAt =
                      tz.TZDateTime.from(TSupdatedAt, timeZone);
                  final formatter = DateFormat('dd-MM-yyyy hh:mm:ss a');
                  final createdAtFix = formatter.format(NowCreatedAt);
                  final updatedAtFix = formatter.format(NowupdatedAt);
                  return [
                    '${i++}',
                    '${e.idorder}',
                    '${e.from}',
                    createdAtFix,
                    '${e.to}',
                    updatedAtFix,
                    '${e.message}',
                    '${e.keterangan}',
                  ];
                }).toList()),
          ];
        },
      ),
    ); // Page
    // SIMPAN
    Uint8List bytes = await pdf.save();

    // buat file kosong di directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Trouble Machine $mid.pdf');

    // timpa file kosong dengan file pdf
    await file.writeAsBytes(bytes);

    //open pdf
    await OpenFile.open(file.path);
  }
}
