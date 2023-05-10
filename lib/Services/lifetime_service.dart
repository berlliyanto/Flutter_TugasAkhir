import 'dart:convert';

import 'package:flutter_application_1/models/lifetime_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class getOneLT{
  Future getOne(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse(
        "https://berli.aplikasipms.com/api/getOneLT?machine_id=$machine_id");
    var hasilResponseGet = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    final data = (json.decode(hasilResponseGet.body) as Map<String, dynamic>)["data"];
    final int LT = data['timevalue'];
    return LT;
  }
}

class getAllLT{
  Future getAll() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse(
        "https://berli.aplikasipms.com/api/getAllLT");
    var hasilResponseGet = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    Iterable it =
        (json.decode(hasilResponseGet.body) as Map<String, dynamic>)["data"];
    List<lifetimeModel> LTList =
        it.map((e) => lifetimeModel.fromJSON(e)).toList();
    return LTList;
  }
}