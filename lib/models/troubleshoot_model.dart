class getTB{
  late String? from,otoritas,to,message,keterangan,id,updatedAt,createdAt;
  late bool? solved;
  late int? machine_id,idorder;

  getTB({this.from,this.keterangan,this.machine_id,this.message,this.otoritas,this.solved,this.to,this.idorder,this.id,this.createdAt,this.updatedAt});

  factory getTB.fromJSON(Map<String, dynamic> json){
    return getTB(
      id: json["_id"],
      idorder: json["idorder"],
      machine_id: json['machine_id'],
      from: json['from'],
      otoritas: json['otoritas'],
      to: json['to'],
      message: json['message'],
      keterangan: json['keterangan'],
      solved: json['solved'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }
}