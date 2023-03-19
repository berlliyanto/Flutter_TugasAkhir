class pressureGauge{
  late dynamic value;

  pressureGauge({this.value});

  factory pressureGauge.fromJSON(Map<String, dynamic> json){
    return pressureGauge(
      value: json['value']
    );
  }
}

class pressureChart{
  late dynamic value;

  pressureChart({this.value});

  factory pressureChart.fromJSON(Map<String, dynamic> json){
    return pressureChart(
      value: json['value']
    );
  }
}