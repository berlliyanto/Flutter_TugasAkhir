class getPerformanceModel{
  late int? machine_id,state,processed,operationtime;
  late dynamic cycle_time,performancerate;

  getPerformanceModel({this.machine_id,this.cycle_time,this.operationtime,this.performancerate,this.processed,this.state});

  factory getPerformanceModel.fromJSON(Map<String, dynamic> json){
    return getPerformanceModel(
      machine_id: json["machine_id"],
      processed: json["processed"],
      operationtime: json["operationtime"],
      cycle_time: json["cycle_time"],
      performancerate: json["performancerate"],
      state: json["state"]
    );
  }
}