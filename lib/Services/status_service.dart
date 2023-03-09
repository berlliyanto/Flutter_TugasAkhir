import 'dart:convert';

import 'package:flutter_application_1/models/status_model.dart';
import 'package:http/http.dart' as http;

class getStatusM1{
  late int? machine_id,status;

  getStatusM1({this.machine_id, this.status});

  static Future readStatM1() async {
    Uri url = Uri.parse("https://berlliyantoaji.onrender.com/api/getStatusM1");

    var hasilResponseGet = await http.get(url);
    Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
    List<statusModel> statusList = it.map((e) =>  statusModel.fromJSON(e)).toList();
    return statusList;
  }
}
class getStatusM2{
  late int? machine_id,status;

  getStatusM2({this.machine_id, this.status});

  static Future readStatM2() async {
    Uri url = Uri.parse("https://berlliyantoaji.onrender.com/api/getStatusM2");

    var hasilResponseGet = await http.get(url);
    Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<status2Model> statusList = it.map((e) =>  status2Model.fromJSON(e)).toList();
        return statusList;
  }
}
class getStatusM3{
  late int? machine_id,status;

  getStatusM3({this.machine_id, this.status});

  static Future readStatM3() async {
    Uri url = Uri.parse("https://berlliyantoaji.onrender.com/api/getStatusM3");

    var hasilResponseGet = await http.get(url);
    Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<status3Model> statusList = it.map((e) =>  status3Model.fromJSON(e)).toList();
        return statusList;
  }
}
class getStatusM4{
  late int? machine_id,status;

  getStatusM4({this.machine_id, this.status});

  static Future readStatM4() async {
    Uri url = Uri.parse("https://berlliyantoaji.onrender.com/api/getStatusM4");

    var hasilResponseGet = await http.get(url);
    Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<status4Model> statusList = it.map((e) =>  status4Model.fromJSON(e)).toList();
        return statusList;
  }
}