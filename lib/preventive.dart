// ignore_for_file: unused_local_variable

// ignore: depend_on_referenced_packages
import 'package:flutter_application_1/constant.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class preventive extends StatefulWidget {
  static const nameRoute = '/preventive';

  const preventive(String h, {super.key});

  @override
  State<preventive> createState() => _preventiveState();
}

class _preventiveState extends State<preventive> {
  late MaintenanceDataSource _events;
  late List<Appointment> _MTCollection;
  bool state = true;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(blockHorizontal*2, blockVertical*12, blockHorizontal*2, blockVertical*2),
                width: MediaQuerywidth,
                height: blockVertical*20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(blockVertical*2)
                ),
              ),
              SfCalendar(
                backgroundColor: Colors.white,
                view: CalendarView.timelineWorkWeek,
                firstDayOfWeek: 1,
                timeSlotViewSettings: TimeSlotViewSettings(startHour: 8, endHour: 17),
              )
            ],  
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

}
class MaintenanceDataSource extends CalendarDataSource{
  MaintenanceDataSource(List<Appointment> MTCollection){
    appointments = MTCollection;
  }
}