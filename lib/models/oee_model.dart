class getOEEModel{
  late String? tanggal;
  late int? machine_id,state;
  late dynamic quality,availability,performance,nilaioee;

  getOEEModel({this.availability,this.machine_id,this.nilaioee,this.performance,this.quality,this.state,this.tanggal});

  factory getOEEModel.FromJSON(Map<String, dynamic> json){
    return getOEEModel(
      tanggal: json['tanggal'],
      machine_id: json['machine_id'],
      quality: json['quality'],
      availability: json['availability'],
      performance: json['performance'],
      nilaioee: json['nilaioee'],
    );
  }
}