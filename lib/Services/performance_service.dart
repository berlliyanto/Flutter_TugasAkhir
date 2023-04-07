import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/performance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class trigPerformance {
  static Future<trigPerformance> triggerPerformance(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse(
        "https://aplikasi-pms-berli.onrender.com/api/trigPerformance");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $getToken'
        },
        body: jsonEncode({"machine_id": machine_id}));
    if (response.statusCode == 200) {
      print(response.statusCode);
    }
    return trigPerformance();
  }
}

class resetPerformance {
  static Future<resetPerformance> resPerformance(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse(
        "https://aplikasi-pms-berli.onrender.com/api/resetPerformance");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $getToken'
        },
        body: jsonEncode({"machine_id": machine_id}));
    if (response.statusCode == 200) {
      print(response.statusCode);
    }
    return resetPerformance();
  }
}

class getPerformance{
  Future getPerform(int machine_id) async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/latestPerformance?machine_id=$machine_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<getPerformanceModel> getPerformm = it.map((e) =>  getPerformanceModel.fromJSON(e)).toList();
        return getPerformm;
  }
}