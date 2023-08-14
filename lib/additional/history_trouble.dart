import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/troubleshoot_service.dart';
import 'package:flutter_application_1/additional/report_trouble.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/models/troubleshoot_model.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class historiTB extends StatefulWidget {
  const historiTB(String av, {super.key});

  @override
  State<historiTB> createState() => _historiTBState();
}

class _historiTBState extends State<historiTB> {
  int m = 1;
  bool sort = true;
  late Timer timer;
  StreamController streamOrder = StreamController.broadcast();
  List<getTB> ListOrder = [];
  GetData orderList = GetData();
  Future<void> OrderData() async {
    ListOrder = await orderList.getRecTB(m);
    streamOrder.add(ListOrder);
  }

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
    OrderData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final timeZone = tz.getLocation('Asia/Jakarta');

  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;

    // UNTUK TINGGI TAMPILAN
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
                bottomRight: Radius.circular(15),
              ),
            ),
            toolbarHeight: blockVertical * 6,
            shadowColor: Colors.transparent,
            title: Text(
              "History Troubleshoot",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 2, 66, 87).withOpacity(0.5),
            leading: backbutton(context),
            actions: [
              IconButton(
                onPressed: () {
                  if (otoritas == "User-Management" || otoritas == "Admin") {
                    if (m == 1) {
                      reportTrouble(mid: 1).Trouble();
                    } else if (m == 2) {
                      reportTrouble(mid: 2).Trouble();
                    } else if (m == 3) {
                      reportTrouble(mid: 3).Trouble();
                    } else {
                      reportTrouble(mid: 4).Trouble();
                    }
                  } else {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            title: "You have no access to perform this action",
                            useRootNavigator: true,
                            autoHide: Duration(milliseconds: 1500))
                        .show();
                  }
                },
                icon: Icon(
                  Icons.picture_as_pdf,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.only(top: blockVertical * 12),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 32, 146, 184),
                    Color.fromARGB(255, 4, 44, 61),
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "History",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: blockVertical * 4,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: blockVertical * 3),
                  height: blockVertical * 80,
                  width: MediaQuerywidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: blockVertical * 67.2,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder(
                                stream: streamOrder.stream,
                                builder: (context, snapshot) {
                                  return DataTable(
                                    sortColumnIndex: 0,
                                    sortAscending: sort,
                                    headingRowColor:
                                        MaterialStateProperty.resolveWith<
                                            Color?>((Set<MaterialState> state) {
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
                                      borderRadius: BorderRadius.circular(
                                          blockVertical * 2),
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
                                          onSort: ((ColumnIndex, ascending) {
                                            setState(() {
                                              sort = !sort;
                                            });
                                            onSortId(ColumnIndex, ascending);
                                          }),
                                          label: Text(
                                            "No",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: blockVertical * 2),
                                          )),
                                      DataColumn(
                                          label: Text(
                                        "Id Order",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Machine",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Order From",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Order Date",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Done By",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Done Date",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Message",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Status",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Solved",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: blockVertical * 2),
                                      )),
                                    ],
                                    rows: ListOrder.map(
                                      (e) {
                                        //No
                                        int index = ListOrder.indexOf(e);
                                        String Number = (index + 1)
                                            .toString()
                                            .padLeft(ListOrder.length
                                                .toString()
                                                .length);
                                        //FORMAT TANGGAL ASIA/JAKARTA
                                        final TScreatedAt =
                                            DateTime.parse(e.createdAt!);
                                        final NowCreatedAt = tz.TZDateTime.from(
                                            TScreatedAt, timeZone);
                                        final TSupdatedAt =
                                            DateTime.parse(e.updatedAt!);
                                        final NowupdatedAt = tz.TZDateTime.from(
                                            TSupdatedAt, timeZone);
                                        final formatter =
                                            DateFormat('dd-MM-yyyy hh:mm:ss a');
                                        final createdAtFix =
                                            formatter.format(NowCreatedAt);
                                        final updatedAtFix =
                                            formatter.format(NowupdatedAt);
                                        return DataRow(cells: [
                                          DataCell(Text(
                                            Number,
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell(Text(
                                            "${e.idorder}",
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell(Text(
                                            "${e.machine_id}",
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell(Text(
                                            "${e.from} (${e.otoritas})",
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell(Text(
                                            createdAtFix,
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell(Text(
                                            (e.solved == true)
                                                ? "${e.to}"
                                                : "-",
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell(Text(
                                            (e.solved == true)
                                                ? updatedAtFix
                                                : "-",
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell(Text(
                                            "${e.message}",
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell(Text(
                                            "${e.keterangan}",
                                            style: TextStyle(
                                                fontSize: blockVertical * 2),
                                          )),
                                          DataCell((e.solved == true)
                                              ? Icon(
                                                  FontAwesomeIcons.check,
                                                  size: blockVertical * 2,
                                                  color: Colors.green,
                                                )
                                              : Icon(FontAwesomeIcons.x,
                                                  size: blockVertical * 2,
                                                  color: Colors.red)),
                                        ]);
                                      },
                                    ).toList(),
                                  );
                                }),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: blockVertical * 0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: blockVertical * 1.5,
                            left: blockVertical * 1.5),
                        child: Text(
                          "Machine : $m",
                          style: TextStyle(
                              fontSize: blockVertical * 3,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FabCircularMenu(
              fabOpenIcon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              fabCloseIcon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              fabColor: Color.fromARGB(255, 0, 83, 151),
              ringColor: Color.fromARGB(255, 211, 211, 211).withOpacity(0.1),
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.one,
                      color: Color.fromARGB(255, 34, 93, 122),
                    ),
                    onPressed: () async {
                      setState(() {
                        m = 1;
                      });
                      await OrderData();
                    }),
                IconButton(
                    icon: Icon(FontAwesomeIcons.two,
                        color: Color.fromARGB(255, 34, 93, 122)),
                    onPressed: () async {
                      setState(() {
                        m = 2;
                      });
                      await OrderData();
                    }),
                IconButton(
                    icon: Icon(FontAwesomeIcons.three,
                        color: Color.fromARGB(255, 34, 93, 122)),
                    onPressed: () async {
                      setState(() {
                        m = 3;
                      });
                      await OrderData();
                    }),
                IconButton(
                    icon: Icon(FontAwesomeIcons.four,
                        color: Color.fromARGB(255, 34, 93, 122)),
                    onPressed: () async {
                      setState(() {
                        m = 4;
                      });
                      await OrderData();
                    })
              ]),
        ));
  }

  onSortId(int ColumnIndex, bool ascending) {
    if (ColumnIndex == 0) {
      if (ascending) {
        ListOrder.sort((a, b) => a.idorder!.compareTo(b.idorder!));
      } else if (ascending == false) {
        ListOrder.sort((a, b) => b.idorder!.compareTo(a.idorder!));
      }
    }
  }
}
