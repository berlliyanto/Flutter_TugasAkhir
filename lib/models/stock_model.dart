class stockModel{
  late int? machine_id, A,B,C;

  stockModel({this.machine_id,this.A,this.B,this.C});

  factory stockModel.fromJSON(Map<String, dynamic> json){
    return stockModel(
      machine_id: json["machine_id"],
      A: json["A"],
      B: json["B"],
      C: json["C"],
    );
  }

    Map<String, dynamic> toJson() {
    final dataStock = <String, dynamic>{};
    dataStock['machine_id'] = machine_id;
    dataStock['A'] = A;
    dataStock['B'] = B;
    dataStock['C'] = C;
    return dataStock;
  }
}