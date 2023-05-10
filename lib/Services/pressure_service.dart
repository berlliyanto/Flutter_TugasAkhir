
import 'dart:convert';
import 'package:flutter_application_1/models/pressure_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class getPressureGauge{
   Future getValue() async{
    final shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse("https://berli.aplikasipms.com/api/pressureGauge");

    var response = await http.get(url, headers: <String, String>{'Content-Type': 'application/json','Authorization': 'Basic $getToken'},);
    Iterable it = (json.decode(response.body)as Map<String, dynamic>)["data"];
    List<pressureGauge> GaugeData = it.map((e) =>  pressureGauge.fromJSON(e)).toList();
    return GaugeData;
  }
}

class getPressureChart{
  Future getPressure() async {
    Uri url = Uri.parse("https://berli.aplikasipms.com/api/pressureChart");
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    var responseGetAll = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    if (responseGetAll.statusCode == 200) {
      Iterable it =
          (json.decode(responseGetAll.body) as Map<String, dynamic>)["data"];
      List<pressureModel> voltlist = it.map((e) => pressureModel.fromJSON(e)).toList();
      return voltlist;
    }
  }
}