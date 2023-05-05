import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/preventive_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class calendar extends StatelessWidget {
  const calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: myCalendar(),
    );
  }
}

class myCalendar extends StatefulWidget {
  const myCalendar({super.key});

  @override
  State<myCalendar> createState() => _myCalendarState();
}
class _myCalendarState extends State<myCalendar> {
    List<Maintenance> _getDataSource(){
    final List<Maintenance> preventiveData = <Maintenance>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year,today.month,today.day,9,0,0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    preventiveData.add(Maintenance(startTime, "Maintenance", Color.fromARGB(255, 15, 134, 4), false));
    return preventiveData;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: SfCalendar(
                    dataSource: MaintenanceDataSource(_getDataSource()),
                    monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.indicator,
                        showAgenda: true),
                    cellBorderColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    view: CalendarView.month,
                    blackoutDates: [
                      DateTime.now().subtract(Duration(hours: 48)),
                      DateTime.now().subtract(Duration(hours: 24)),
                    ],
                    
                  ),
    );
  }
}