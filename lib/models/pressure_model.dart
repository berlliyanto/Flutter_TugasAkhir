class pressureGauge{
  late dynamic value;

  pressureGauge({this.value});

  factory pressureGauge.fromJSON(Map<String, dynamic> json){
    return pressureGauge(
      value: json['value']
    );
  }
}

class pressurePoint{
  late final double x;
  late final double y;
  pressurePoint({required this.x, required this.y});
}
class pressureModel{
  late dynamic value;

  pressureModel({this.value,});

  factory pressureModel.fromJSON(Map<String,  dynamic> json){
    return pressureModel(
      value: json['value'],
    );
  }
}