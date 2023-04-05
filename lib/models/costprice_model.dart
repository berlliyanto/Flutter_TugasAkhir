class getPriceModel {
  late String? tipe, Nbaku1, Nbaku2, Nbaku3;
  late int? Pbaku1, Pbaku2, Pbaku3, Ptotal;

  getPriceModel(
      {this.tipe,
      this.Nbaku1,
      this.Nbaku2,
      this.Nbaku3,
      this.Pbaku1,
      this.Pbaku2,
      this.Pbaku3,
      this.Ptotal});

  factory getPriceModel.FromJSON(Map<String, dynamic> json){
    return getPriceModel(
      tipe: json['tipe'],
      Nbaku1: json['name_baku1'],
      Nbaku2: json['name_baku2'],
      Nbaku3: json['name_baku3'],
      Pbaku1: json['price_baku1'],
      Pbaku2: json['price_baku2'],
      Pbaku3: json['price_baku3'],
      Ptotal: json['price_total']
    );
  }
}

class getCostModel {
  late int? machine_id,good,total_harga,harga_unit,state;
  late String? tipe,tanggal;

  getCostModel({this.machine_id,this.good,this.harga_unit,this.state,this.tanggal,this.tipe,this.total_harga});

  factory getCostModel.FromJSON(Map<String, dynamic> json){
    return getCostModel(
      machine_id: json['machine_id'],
      good: json['good'],
      harga_unit: json['harga_unit'],
      total_harga: json['total_harga'],
      tanggal: json['tanggal'],
      tipe: json['tipe'],
      state: json['state']
    );
  }
}
