// ignore_for_file: unused_local_variable

// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:flutter_application_1/Services/lifetime_service.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/lifetime_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class preventive extends StatefulWidget {
  static const nameRoute = '/preventive';

  const preventive(String h, {super.key});

  @override
  State<preventive> createState() => _preventiveState();
}

class _preventiveState extends State<preventive> {
  late Timer timer;
  StreamController streamLT = StreamController.broadcast();
  List<lifetimeModel> listLT = [];
  getAllLT lifetime = getAllLT();
  Future<void> lifetimeData() async {
    listLT = await lifetime.getAll();
    streamLT.add(listLT);
  }

  late MaintenanceDataSource _events;
  late List<Appointment> _MTCollection;
  bool state = true;

  @override
  void initState() {
    lifetimeData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      lifetimeData();
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
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
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
            "Preventive Maintenance",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 49, 65).withOpacity(0.5),
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
                icon: Icon(FontAwesomeIcons.house)),
          ],
        ),
        drawer: drawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 5, 180, 238),
                  Color.fromARGB(255, 1, 37, 53),
                ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(blockVertical * 1),
                  margin: EdgeInsets.fromLTRB(blockHorizontal * 2,
                      blockVertical * 12, blockHorizontal * 2, blockVertical * 2),
                  width: MediaQuerywidth,
                  height: blockVertical * 20,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(blockVertical * 2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Life Time Machine",
                        style: TextStyle(
                            fontSize: blockVertical * 3,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: blockVertical*1.5,),
                      StreamBuilder(
                        stream: streamLT.stream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: listLT.map((e) {
                                  return Lifetime(blockVertical, blockHorizontal, "Machine ${e.machine_id}", "${e.timevalue}",(e.timevalue!>=10000)?Colors.green:Colors.red);
                                }).toList()
                              ),
                            );
                          }else if(snapshot.connectionState==ConnectionState.waiting){
                            return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                LifetimeShimmmer(blockVertical, blockHorizontal),
                                LifetimeShimmmer(blockVertical, blockHorizontal),
                                LifetimeShimmmer(blockVertical, blockHorizontal),
                                LifetimeShimmmer(blockVertical, blockHorizontal),
                              ],
                            ),
                          );
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               Lifetime(blockVertical, blockHorizontal, "Machine 1", "-",Colors.black),
                               Lifetime(blockVertical, blockHorizontal, "Machine 2", "-",Colors.black),
                               Lifetime(blockVertical, blockHorizontal, "Machine 3", "-",Colors.black),
                               Lifetime(blockVertical, blockHorizontal, "Machine 4", "-",Colors.black),
                              ],
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
                SfCalendar(
                  backgroundColor: Colors.white,
                  view: CalendarView.timelineWorkWeek,
                  firstDayOfWeek: 1,
                  timeSlotViewSettings:
                      TimeSlotViewSettings(startHour: 8, endHour: 17),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          String mongodbTimestamp = '2023-03-26T04:45:48.348+00:00';
          DateTime dateTime = DateTime.parse(mongodbTimestamp);

          var formatter = DateFormat('yyyy-MM-dd');
          String formattedDate = formatter.format(dateTime);

          print(formattedDate); // Output: 2023-03-26
        }),
      ),
    );
  }

  Widget Lifetime(double blockVertical, double blockHorizontal, String title,
      String value, Color colors) {
    return Container(
      margin: EdgeInsets.only(right: blockHorizontal*5),
      padding: EdgeInsets.only(
          top: blockVertical * 0.5,
          left: blockVertical * 1,
          right: blockVertical * 1),
      height: blockVertical * 12.5,
      width: blockHorizontal * 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(blockVertical * 1),
          color: Color.fromARGB(255, 212, 212, 212).withOpacity(0.3),
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
                FontAwesomeIcons.heartPulse,
                size: blockVertical * 2,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: blockVertical * 2.5, fontWeight: FontWeight.bold,),
          ),
          SizedBox(height: blockVertical*3,),
          Text("$value Sec", style: TextStyle(fontSize: blockVertical*2.5, fontWeight: FontWeight.bold,color: colors),)
        ],
      ),
    );
  }
  Widget LifetimeShimmmer(double blockVertical, double blockHorizontal,) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 211, 211, 211),
      highlightColor: Colors.white,
      child: Container(
        margin: EdgeInsets.only(right: blockHorizontal*5),
        padding: EdgeInsets.only(
            top: blockVertical * 0.5,
            left: blockVertical * 1,
            right: blockVertical * 1),
        height: blockVertical * 12.5,
        width: blockHorizontal * 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(blockVertical * 1),
            color: Color.fromARGB(255, 211, 211, 211).withOpacity(0.3),
          ),
      ),
    );
  }
}

class MaintenanceDataSource extends CalendarDataSource {
  MaintenanceDataSource(List<Appointment> MTCollection) {
    appointments = MTCollection;
  }
}
