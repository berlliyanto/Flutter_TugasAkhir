class ParamModel{
  late  int? machine_id,oee_target,harga_perUnit,state;
  late dynamic  cycle_time,loading_time;
  late String? tipe_benda,id;

  ParamModel({this.machine_id, this.loading_time, this.cycle_time, this.oee_target, this.harga_perUnit,this.state, this.tipe_benda,this.id});

  factory ParamModel.fromJSON(Map<String, dynamic> json){
      return ParamModel(
        machine_id: json['machine_id'],
        loading_time: json['loading_time'],
        cycle_time: json['cycle_time'],
        oee_target: json['oee_target'],
        harga_perUnit: json['harga_perUnit'],
        tipe_benda: json['tipe_benda'],
        state:json['state'],
        id: json['_id'],
      );
  }

  Map<String, dynamic> toJson() {
    final dataParameter = <String, dynamic>{};
    dataParameter['machine_id'] = machine_id;
    dataParameter['loading_time'] = loading_time;
    dataParameter['cycle_time'] = cycle_time;
    dataParameter['oee_target'] = oee_target;
    dataParameter['harga_perUnit'] = harga_perUnit;
    dataParameter['tipe_benda'] = tipe_benda;
    dataParameter['state'] = state;
    dataParameter['_id'] = id;
    return dataParameter;
  }
}

class ParamModel2{
  late  int? machine_id,oee_target,harga_perUnit;
  late dynamic loading_time, cycle_time;
  late String? tipe_benda,id;

  ParamModel2({this.machine_id, this.loading_time, this.cycle_time, this.oee_target, this.harga_perUnit, this.tipe_benda,this.id});

  factory ParamModel2.fromJSON(Map<String, dynamic> json){
      return ParamModel2(
        machine_id: json['machine_id'],
        loading_time: json['loading_time'],
        cycle_time: json['cycle_time'],
        oee_target: json['oee_target'],
        harga_perUnit: json['harga_perUnit'],
        tipe_benda: json['tipe_benda'],
        id: json['_id'],
      );
  }

  Map<String, dynamic> toJson() {
    final dataParameter = <String, dynamic>{};
    dataParameter['machine_id'] = machine_id;
    dataParameter['loading_time'] = loading_time;
    dataParameter['cycle_time'] = cycle_time;
    dataParameter['oee_target'] = oee_target;
    dataParameter['harga_perUnit'] = harga_perUnit;
    dataParameter['tipe_benda'] = tipe_benda;
    dataParameter['_id'] = id;
    return dataParameter;
  }
}