import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/stock_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

//Read Data Stock M1
class readStockM1{
    Future getStockM1() async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/stockM1");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<stockModel> StockList = it.map((e) =>  stockModel.fromJSON(e)).toList();
        return StockList;
  }
}

//Tambah Stock M1
class addStockM1{
  late int? A,B,C,machine_id;
  late String? id;

  addStockM1({this.A,this.B,this.C,this.id,this.machine_id});

  static Future<addStockM1> putStockM1(int A, int B, int C) async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/addstockM1");

    var hasilResponsePut = await http.put(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    },
    body: jsonEncode({
      "A": A,
      "B": B,
      "C": C
    }),
    );
    var dataPut = (json.decode(hasilResponsePut.body) as Map<String, dynamic>)['data'];
    if(hasilResponsePut.statusCode == 200){
      print(hasilResponsePut.statusCode);
    }else{
      print(hasilResponsePut.statusCode);
    }
    return addStockM1(
      id: dataPut["_id"],
      machine_id: dataPut["machine_id"],
      A: dataPut["A"],
      B: dataPut["B"],
      C: dataPut["C"],
    );
  }
  
}
