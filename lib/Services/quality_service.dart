import 'dart:convert';

import 'package:flutter_application_1/models/quality_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class trigQuality {
  late int? machine_id;
  late String? tipe;

  trigQuality({this.machine_id, this.tipe});

  static Future<trigQuality> TriggerQuality(int machine_id, String tipe) async {
    Uri url =
        Uri.parse('https://aplikasi-pms-berli.onrender.com/api/trigQuality');
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");

    var trigResponse = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $getToken'
      },
      body: jsonEncode(
        {
          "machine_id": machine_id,
          "tipe": tipe,
        },
      ),
    );
    var hasilresponse = (json.decode(trigResponse.body)as Map<String, dynamic>)['data'];
    return trigQuality(
      machine_id: hasilresponse['machine_id'],
      tipe: hasilresponse['tipe'],
    );
  }
}

class getQuality{
  late String? tipe;
  getQuality({this.tipe});
  
  Future getQualityM(int machine_id, String tipe) async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
      var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getQualityData?m_id=$machine_id&tipe=$tipe");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<currentQuality> QualityM1_A = it.map((e) =>  currentQuality.fromJSON(e)).toList();
        return QualityM1_A;
  }
}

class dashQualityy{
  Future dashQualityM() async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/dashboardQuality");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<dashQuality> dashQualityM = it.map((e) =>  dashQuality.fromJSON(e)).toList();
        return dashQualityM;
  }
}

class recordQuality{
  Future getrecQuality(int machine_id)async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getRecQuality?m_id=$machine_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<recQuality> reqQyalityM = it.map((e) =>  recQuality.fromJSON(e)).toList();
        return reqQyalityM;
  }
}

class inputDefect{
  late int? defect,machine_id;
  late String? tipe;
  inputDefect({this.defect});

  static Future<inputDefect> defectQuality(int defect, int machine_id, String tipe) async {
    Uri url =
        Uri.parse('https://aplikasi-pms-berli.onrender.com/api/defect?m_id=$machine_id&tipe=$tipe');
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");

    var defectresponse = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $getToken'
      },
      body: jsonEncode(
        {
          "defect": defect,
        },
      ),
    );
    var hasilresponse = (json.decode(defectresponse.body)as Map<String, dynamic>)['data'];
    return inputDefect(
      defect: hasilresponse['defect']
    );
  }
}

class resetQuality{
  late int? machine_id;

  resetQuality({this.machine_id});
  static Future<resetQuality> reset(int machine_id) async {
    Uri url =
        Uri.parse('https://aplikasi-pms-berli.onrender.com/api/resetQuality?m_id=$machine_id');
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    var resetResponse = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $getToken'
      },

    );
    var hasilresponse = (json.decode(resetResponse.body)as Map<String, dynamic>)['data'];
    return resetQuality(
      machine_id: hasilresponse['machine_id']
    );
  }
}
