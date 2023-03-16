
import 'dart:convert';
import 'package:flutter_application_1/models/pressure_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class getPressureGauge{
   Future getValue() async{
    final shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/pressureGauge");

    var response = await http.get(url, headers: <String, String>{'Content-Type': 'application/json','Authorization': 'Basic $getToken'},);
    Iterable it = (json.decode(response.body)as Map<String, dynamic>)["data"];
    List<pressureGauge> GaugeData = it.map((e) =>  pressureGauge.fromJSON(e)).toList();
    return GaugeData;
  }
}