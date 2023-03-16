class pressureGauge{
  late dynamic value;

  pressureGauge({this.value});

  factory pressureGauge.fromJSON(Map<String, dynamic> json){
    return pressureGauge(
      value: json['value']
    );
  }
}