import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/models/availability_model.dart';


class getAvailability{
  Future availabilityM(int machine_id)async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/latestAvailability?machine_id=$machine_id");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    Iterable it = (json.decode(response.body)as Map<String, dynamic>)["data"];
    List<avaiModelM> QualityM1_A = it.map((e) =>  avaiModelM.fromJSON(e)).toList();
    return QualityM1_A;
  }
  
  Future getState(int machine_id) async{
     final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/latestAvailability?machine_id=$machine_id");
    var response = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    final data = (json.decode(response.body)as Map<String, dynamic>)['data'];
    final int state = data[0]['state'];
    return state;
  }
  
}

class trigAvailability{
  static Future triggerAvai(int machine_id, int state)async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/trigAvailability");
    var response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    },body: jsonEncode({
      "machine_id": machine_id,
      "state": state,
    }),
    );
    if(response.statusCode==200){
      print(response.statusCode);
    }else{
      print("Gagal");
    }
  }
}

class resetAvailability{
  static Future resetAvai(int machine_id)async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/resetAvailability");
    var response = await http.put(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    },body: jsonEncode({
      "machine_id": machine_id,
    }),
    );
    if(response.statusCode==200){
      print(response.statusCode);
    }else{
      print("Gagal");
    }
  }
}

