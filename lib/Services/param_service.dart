import 'dart:convert';

import 'package:flutter_application_1/models/param_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//INPUT PARAMETER
class inputParameter {
  late String? machine_id, loading_time, cycle_time, oee_target, harga_perUnit;
  late String? tipe_benda;

  inputParameter(
      {this.machine_id,
      this.loading_time,
      this.cycle_time,
      this.oee_target,
      this.harga_perUnit,
      this.tipe_benda});

  static Future<inputParameter> insertParam(
      String machine_id,
      String loading_time,
      String cycle_time,
      String oee_target,
      String harga_perUnit,
      String tipe_benda,
      int state) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/inputParam");

    var hasilResponsePost = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json', 'Authorization': 'Basic $getToken' },
        body: jsonEncode({
          "machine_id": machine_id,
          "loading_time": loading_time,
          "cycle_time": cycle_time,
          "oee_target": oee_target,
          "harga_perUnit": harga_perUnit,
          "tipe_benda": tipe_benda,
          "state": state
        }));
    print(hasilResponsePost.statusCode);
    var dataParameter =(json.decode(hasilResponsePost.body) as Map<String, dynamic>)['data'];
    shared.setString('tipeParamM1', dataParameter['tipe_benda']);
    shared.setInt('stateParamM1', dataParameter['state']);
    print(dataParameter);
    return inputParameter();
  }
}

// RESET PARAMATER
class resetParam {
  late int? state;

  resetParam({this.state});

  static Future<resetParam> putParam(int state) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
        shared.setInt('stateParamM1',state);
    Uri urlput = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/resetParamM1");

    var hasilResponsePut = await http.put(
      urlput,
      headers: <String, String>{'Content-Type': 'application/json','Authorization': 'Basic $getToken'},
      body: jsonEncode(
        {
          "state": state,
        },
      ),
    );
    var dataPut = (jsonDecode(hasilResponsePut.body) as Map<String, dynamic>)['data'];
    
    return resetParam(
      state: dataPut['state']
    );
  }
}

//READ LATEST INPUT PARAMETER M1
class readLatestParamM1 {
  Future getParamM1() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/latestParamM1");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    Iterable it =
        (json.decode(hasilResponseGet.body) as Map<String, dynamic>)["data"];
    List<ParamModel> paramList = it.map((e) => ParamModel.fromJSON(e)).toList();
    print(paramList);
    return paramList;
  }
}

//READ LATEST INPUT PARAMETER M2
class readLatestParamM2 {
  Future getParamM2() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/latestParamM2");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    Iterable it =
        (json.decode(hasilResponseGet.body) as Map<String, dynamic>)["data"];
    List<ParamModel2> paramList =
        it.map((e) => ParamModel2.fromJSON(e)).toList();
    print(paramList);
    return paramList;
  }
}
