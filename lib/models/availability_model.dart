
class avaiModelM{
  late int? machine_id,state,operationtime,downtime,runningtime;
  late dynamic availabilityrate;

  avaiModelM({this.machine_id,this.state,this.operationtime,this.downtime,this.runningtime,this.availabilityrate});

  factory avaiModelM.fromJSON(Map<String, dynamic> json){
    return avaiModelM(
      machine_id: json['machine_id'],
      operationtime: json['operationtime'],
      downtime: json['downtime'],
      runningtime: json['runningtime'],
      availabilityrate: json['availabilityrate'],
      state: json['state'],
    );
  }
}