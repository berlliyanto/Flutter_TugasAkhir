class stockModel{
  late int? machine_id, A,B,C;
  late String? updatedAt;

  stockModel({this.machine_id,this.A,this.B,this.C,this.updatedAt});

  factory stockModel.fromJSON(Map<String, dynamic> json){
    return stockModel(
      machine_id: json["machine_id"],
      A: json["A"],
      B: json["B"],
      C: json["C"],
      updatedAt: json["updatedAt"]
    );
  }
}
//REPORT
class allstockModel{
  late int? machine_id, A,B,C;
  late String? updatedAt;

  allstockModel({this.machine_id,this.A,this.B,this.C,this.updatedAt});

  factory allstockModel.fromJSON(Map<String, dynamic> json){
    return allstockModel(
      machine_id: json["machine_id"],
      A: json["A"],
      B: json["B"],
      C: json["C"],
      updatedAt: json["updatedAt"]
    );
  }
}

class historiM1model{
  late String? id, tipe, dibuat,createdAt;
  late int? jumlah,machine_id;

  historiM1model({this.id, this.machine_id, this.dibuat, this.jumlah, this.tipe,this.createdAt});

  factory historiM1model.fromJSON(Map<String, dynamic> json){
    return historiM1model(
      id: json["_id"],
      machine_id: json["machine_id"],
      tipe: json["tipe"],
      dibuat: json["dibuat"],
      jumlah: json["jumlah"],
      createdAt: json["createdAt"]
    );
  }
}