import 'dart:convert';

import 'package:flutter_application_1/models/costprice_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class getPrice{
  Future getPriceList() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getPrice");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    Iterable it =(json.decode(hasilResponseGet.body) as Map<String, dynamic>)["data"];
    List<getPriceModel> pricelist = it.map((e) => getPriceModel.FromJSON(e)).toList();
    return pricelist;
  }
}

class triggCost{
  static Future<triggCost> trigCost(int machine_id) async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/trigCost");
    var hasilResponseGet = await http.post(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    },body: {
      machine_id: machine_id,
    });
    if(hasilResponseGet.statusCode==200){
      print(200);
    }
    return triggCost();
  }
}

class getLatestCost{
  Future getCostList(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getCost?machine_id=$machine_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    Iterable it =(json.decode(hasilResponseGet.body) as Map<String, dynamic>)["data"];
    List<getCostModel> Costlist = it.map((e) => getCostModel.FromJSON(e)).toList();
    return Costlist;
  }
}

class getCostHistori{
  Future getCostH(int machine_id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getCostHistori?machine_id=$machine_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    Iterable it =(json.decode(hasilResponseGet.body) as Map<String, dynamic>)["data"];
    List<getCostHModel> Costlist = it.map((e) => getCostHModel.FromJSON(e)).toList();
    return Costlist;
  }
}