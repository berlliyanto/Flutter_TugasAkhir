import 'dart:ui';
import 'dart:core';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Maintenance {
  Maintenance(this.date, this.subject, this.color, this.isAllDay);

  DateTime date;
  String subject;
  Color color;
  bool isAllDay;
}

class MaintenanceDataSource extends CalendarDataSource {
  MaintenanceDataSource(List<Maintenance> getDataSource) {
    appointments = <Maintenance>[];
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].date;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].date.add(Duration(hours: 2));
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class preventiveMessageModel{
  late String? message,keterangan,createdAt,updatedAt;
  late int? machine_id,idpreventive;
  late bool? solved;

  preventiveMessageModel({this.machine_id,this.message,this.keterangan,this.solved,this.createdAt,this.updatedAt,this.idpreventive});

  factory preventiveMessageModel.fromJSON(Map<String, dynamic> json){
    return preventiveMessageModel(
      machine_id: json['machine_id'],
      idpreventive: json['idpreventive'],
      message: json['message'],
      keterangan: json['keterangan'],
      solved: json['solved'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }
}

class preventiveScheduleModel{
  late String? jam,menit,hari;
  late int? machine_id;

  preventiveScheduleModel({this.machine_id,this.hari,this.jam,this.menit});

  factory preventiveScheduleModel.fromJSON(Map<String, dynamic>json){
    return preventiveScheduleModel(
      machine_id: json['machine_id'],
      hari: json['hari'],
      jam: json['jam'],
      menit: json['menit']
    );
  }
}