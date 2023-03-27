class currentQuality{
  late int? machine_id,state,good,defect,processed;
  late String? tipe;
  late dynamic qualityrate;

  currentQuality({this.machine_id,this.state,this.good,this.defect,this.processed,this.qualityrate,this.tipe});

  factory currentQuality.fromJSON(Map<String, dynamic> json){
    return currentQuality(
      machine_id: json['machine_id'],
      tipe:json['tipe'],
      good: json['good'],
      defect: json['defect'],
      processed: json['processed'],
      qualityrate: json['qualityrate'],
      state: json['state'],
    );
  }
}

class dashQuality{
  late int? machine_id,state,good,defect,processed;
  late String? tipe;

  dashQuality({this.machine_id,this.state,this.good,this.defect,this.processed,this.tipe});

  factory dashQuality.fromJSON(Map<String, dynamic> json){
    return dashQuality(
      machine_id: json['machine_id'],
      tipe:json['tipe'],
      good: json['good'],
      defect: json['defect'],
      processed: json['processed'],
      state: json['state'],
    );
  }
}