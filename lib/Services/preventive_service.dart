import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_1/models/preventive_model.dart';

class updatePreventiveMessage{
  static Future<updatePreventiveMessage> updateMessage(int machine_id,int id) async {
     final SharedPreferences shared = await SharedPreferences.getInstance();
      var getToken = shared.getString("token");
    Uri url = Uri.parse("https://berli.aplikasipms.com/api/updatePrevStatus?machine_id=$machine_id");
    var response = await http.put(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    },body: jsonEncode({
      "keterangan": "Solved",
      "idpreventive":id,
    }));
    if(response.statusCode==200){
      print(response.statusCode);
    }else{
      print(response.statusCode);
    }
    return updatePreventiveMessage();
  }
}

class updateJadwalPreventive{
  static Future<updateJadwalPreventive> updateJadwal(int machine_id,String hari,String jam,String menit) async {
     final SharedPreferences shared = await SharedPreferences.getInstance();
      var getToken = shared.getString("token");
    Uri url = Uri.parse("https://berli.aplikasipms.com/api/updateJadwalPrev");
    var response = await http.put(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    },body: jsonEncode({
      "machine_id": machine_id,
      "hari": hari,
      "jam": jam,
      "menit": menit,
    }));
    if(response.statusCode==200){
      print(response.statusCode);
    }else{
      print(response.statusCode);
    }
    return updateJadwalPreventive();
  }
}

class getJadwalPrev{
  Future getJadwal() async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
      var getToken = shared.getString("token");
    Uri url = Uri.parse("https://berli.aplikasipms.com/api/getJadwalPrev");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<preventiveScheduleModel> prevSchedule = it.map((e) =>  preventiveScheduleModel.fromJSON(e)).toList();
        return prevSchedule;
  }

  Future getSingleJadwal()async{
     final SharedPreferences shared = await SharedPreferences.getInstance();
      var getToken = shared.getString("token");
    Uri url = Uri.parse("https://berli.aplikasipms.com/api/getJadwalPrev");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    var hasilResponse = json.decode(hasilResponseGet.body)['data'];
    return hasilResponse;
  }
}

class getPreventive{
  Future getPrev(int machine_id) async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
      var getToken = shared.getString("token");
    Uri url = Uri.parse("https://berli.aplikasipms.com/api/getPreventive?machine_id=$machine_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<preventiveMessageModel> prevMessage = it.map((e) =>  preventiveMessageModel.fromJSON(e)).toList();
        return prevMessage;
  }
}