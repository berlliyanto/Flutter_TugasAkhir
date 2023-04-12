import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/stock_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

//Read Data Stock M
class readStock{
    Future getStock(int machine_id) async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/getStock?machine_id=$machine_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    
    Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
    List<stockModel> StockList = it.map((e) =>  stockModel.fromJSON(e)).toList();
    return StockList;
  }
  //REPORT
    Future getallStock() async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/allStock");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    
    Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
    List<allstockModel> StockList = it.map((e) =>  allstockModel.fromJSON(e)).toList();
    return StockList;
  }
}

//Tambah Stock M1
class addStock{
  late int? A,B,C,machine_id;
  late String? id;

  addStock({this.A,this.B,this.C,this.id,this.machine_id});

  static Future<addStock> putStock(int A, int B, int C,int machine_id) async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/addStock?m_id=$machine_id");

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
    return addStock(
      id: dataPut["_id"],
      machine_id: dataPut["machine_id"],
      A: dataPut["A"],
      B: dataPut["B"],
      C: dataPut["C"],
    );
  }
  
}
//RIWAYAT STOCK------------------------------------------------------------------------
class addriwayatStock {
  late int? jumlah,machine_id;
  late String? id,tipe;

  addriwayatStock(
      {this.jumlah,this.machine_id, this.id, this.tipe});
  static Future<addriwayatStock> connectAPIPost(int machine_id,String tipe, int jumlah) async {
        final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
        Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/inputStock");

    var hasilResponsePost = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json','Authorization': 'Basic $getToken'},
        body: jsonEncode({
          "machine_id": machine_id,
          "tipe": tipe,
          "jumlah": jumlah,
        }));
    print(hasilResponsePost.statusCode);
    var data = (json.decode(hasilResponsePost.body) as Map<String, dynamic>);
    return addriwayatStock(
        machine_id: data["machine_id"],
        tipe: data["tipe"],
        jumlah: data["jumlah"],
        id: data["_id"]
    );
  }
}

class getriwayat{
    Future gethistori(int m_id) async {
      final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/historiStock?m_id=$m_id");
    var hasilResponseGet = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
   Iterable it = (json.decode(hasilResponseGet.body)as Map<String, dynamic>)["data"];
        List<historiM1model> historiM1List = it.map((e) =>  historiM1model.fromJSON(e)).toList();
        return historiM1List;
  }
}