class lifetimeModel{
  late int? machine_id,timevalue;

  lifetimeModel({this.machine_id,this.timevalue});

  factory lifetimeModel.fromJSON(Map<String, dynamic> json){
    return lifetimeModel(
      machine_id: json['machine_id'],
      timevalue: json['timevalue']
    );
    
  }
}