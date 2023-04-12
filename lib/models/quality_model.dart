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
  late String? tipe,updatedAt;

  dashQuality({this.machine_id,this.state,this.good,this.defect,this.processed,this.tipe,this.updatedAt});

  factory dashQuality.fromJSON(Map<String, dynamic> json){
    return dashQuality(
      machine_id: json['machine_id'],
      tipe:json['tipe'],
      good: json['good'],
      defect: json['defect'],
      processed: json['processed'],
      updatedAt: json['updatedAt'],
      state: json['state'],
    );
  }
}

class recQuality{
  late int? machine_id,state,processed,good,defect;
  late String? tipe,createdAt;

  recQuality({this.machine_id,this.state,this.processed,this.tipe,this.createdAt,this.defect,this.good});

  factory recQuality.fromJSON(Map<String, dynamic> json){
    return recQuality(
      machine_id: json['machine_id'],
      tipe:json['tipe'],
      good: json['good'],
      defect: json['defect'],
      processed: json['processed'],
      createdAt: json['createdAt'],
      state: json['state'],
    );
  }
}