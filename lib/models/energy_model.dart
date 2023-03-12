// ignore: depend_on_referenced_packages

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

//CHART ENERGY USAGE
//VOLTAGE
class voltPoint{
  late final double x;
  late final double y;
  voltPoint({required this.x, required this.y});
}
class voltModel{
  late dynamic voltage;

  voltModel({this.voltage,});

  factory voltModel.fromJSON(Map<String,  dynamic> json){
    return voltModel(
      voltage: json['voltage'],
    );
  }
}

//CURRENT
class currentPoint{
  late final double x;
  late final double y;
  currentPoint({required this.x, required this.y});
}
class currentModel{
  late dynamic current;

  currentModel({this.current,});

  factory currentModel.fromJSON(Map<String,  dynamic> json){
    return currentModel(
      current: json['current'],
    );
  }
}

//POWER
class powerPoint{
  late final double x;
  late final double y;
  powerPoint({required this.x, required this.y});
}
class powerModel{
  late dynamic power;

  powerModel({this.power,});

  factory powerModel.fromJSON(Map<String,  dynamic> json){
    return powerModel(
      power: json['power'],
    );
  }
}

//ENERGY
class energyPoint{
  late final double x;
  late final double y;
  energyPoint({required this.x, required this.y});
}
class energiModel{
  late double? energy;

  energiModel({this.energy,});

  factory energiModel.fromJSON(Map<String,  dynamic> json){
    return energiModel(
      energy: json['energy'],
    );
  }
}

//FREQUENCY
class frequencyPoint{
  late final double x;
  late final double y;
  frequencyPoint({required this.x, required this.y});
}
class frequencyModel{
  late dynamic frequency;

  frequencyModel({this.frequency,});

  factory frequencyModel.fromJSON(Map<String,  dynamic> json){
    return frequencyModel(
      frequency: json['frequency'],
    );
  }
}

//POWER FACTOR
class pfPoint{
  late final double x;
  late final double y;
  pfPoint({required this.x, required this.y});
}
class pfModel{
  late dynamic pf;

  pfModel({this.pf,});

  factory pfModel.fromJSON(Map<String,  dynamic> json){
    return pfModel(
      pf: json['pf'],
    );
  }
}