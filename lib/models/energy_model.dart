class energyModel{
  late String? id;
  late dynamic voltage,current,power,energy,frequency, pf;

  energyModel({this.voltage,this.current,this.power,this.energy,this.pf,this.frequency,this.id});

  factory energyModel.fromJSON(Map<String,  dynamic> json){
    return energyModel(
      id: json['_id'],
      voltage: json['voltage'],
      current: json['current'],
      power: json['power'],
      energy: json['energy'],
      frequency: json['frequency'],
      pf: json['pf']
    );
  }
}