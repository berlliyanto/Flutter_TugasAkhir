import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_1/models/oee_model.dart';

class getOEE{
  Future getResult(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getOEE?machine_id=$machine_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<getOEEModel> getoee = it.map((e) =>  getOEEModel.FromJSON(e)).toList();
        return getoee;
  }
  Future dashOEE() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getdashOEE");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<OEEdashModel> getoee = it.map((e) =>  OEEdashModel.FromJSON(e)).toList();
        return getoee;
  }
}

class OEEHistori{
    Future HistoryOEE(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getOEEHistori?machine_id=$machine_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<OEEHistoriModel> getoee = it.map((e) =>  OEEHistoriModel.FromJSON(e)).toList();
        return getoee;
  }
}

class trigOEE{
  static Future<trigOEE> triggerOEE(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse(
        "https://aplikasi-pms-berli.onrender.com/api/trigOEE");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $getToken'
        },
        body: jsonEncode({"machine_id": machine_id}));
    if (response.statusCode == 200) {
      print(response.statusCode);
    }
    return trigOEE();
  }
}

class resetOEE{
  static Future<resetOEE> resOEE(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse(
        "https://aplikasi-pms-berli.onrender.com/api/resetOEE");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $getToken'
        },
        body: jsonEncode({"machine_id": machine_id}));
    if (response.statusCode == 200) {
      print(response.statusCode);
    }
    return resetOEE();
  }
}