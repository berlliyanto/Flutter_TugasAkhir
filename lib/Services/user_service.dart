
import 'package:flutter_application_1/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



//class INSERT DATA ------------------------------------------------------------------------------------------------------------------
class HttpUserPost {
  late String? username, password, name, id, otoritas, noHp;

  HttpUserPost(
      {this.username, this.password, this.name, this.otoritas, this.noHp});
  static Future<HttpUserPost> connectAPIPost(String username, String password,
      String name, String otoritas, String noHp) async {
        final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
        Uri url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/register");

    var hasilResponsePost = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json','Authorization': 'Basic $getToken'},
        body: jsonEncode({
          "username": username,
          "password": password,
          "name": name,
          "otoritas": otoritas,
          "noHp": noHp
        }));
    print(hasilResponsePost.statusCode);
    var dataUser = (json.decode(hasilResponsePost.body) as Map<String, dynamic>);
    return HttpUserPost(
        username: dataUser["username"],
        password: dataUser["password"],
        name: dataUser["name"],
        otoritas: dataUser["otoritas"],
        noHp: dataUser["noHp"]);
  }
}

//class GET SINGLE DATA ------------------------------------------------------------------------------------------------------------------
class HttpUserGet {
  late String? username, password, name, id, otoritas, noHp;

  HttpUserGet(
      {this.username,
      this.password,
      this.name,
      this.id,
      this.otoritas,
      this.noHp});

  static Future<HttpUserGet> connectAPIGet(String id) async {
    Uri urlpost = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/users/$id");

    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    var hasilResponseGet = await http.get(urlpost,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    var dataGet = (json.decode(hasilResponseGet.body) as Map<String, dynamic>)["data"];
    print(dataGet);
    return HttpUserGet(
        id: dataGet["id"],
        username: dataGet["username"],
        password: dataGet["password"],
        name: dataGet["name"],
        otoritas: dataGet["otoritas"],
        noHp: dataGet["noHp"]);
  }
}
//class GET ALL DATA untuk di menu daftar akun--------------------------------------------------------------------------------------------------------------------
class allUserGet{
  final url = 'https://aplikasi-pms-berli.onrender.com/api/users';
  Future connectAPIGetAll() async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getToken = shared.getString("token");
    try {
      var responseGetAll = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
      if(responseGetAll.statusCode==200){
        Iterable it = (json.decode(responseGetAll.body)as Map<String, dynamic>)["data"];
        List<userModel> userList = it.map((e) => userModel.fromJSON(e)).toList();
        print(userList);
        return userList;
      }
    } catch (e) {
      print(e.toString());
      
    }
  }
}

//class UPDATE DATA---------------------------------------------------------------------------------------------------------------------
class HttpUserPut {
  late String? username, password, name, id, otoritas, noHp;

  HttpUserPut(
      {this.username,
      this.name,
      this.id,
      this.otoritas,
      this.noHp});

  static Future<HttpUserPut> connectAPIPut(String id, String username,
      String name, String otoritas, String noHp) async {
        final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri urlput = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/users/$id");

    var hasilResponsePut = await http.put(urlput,
        headers: <String, String>{'Content-Type': 'application/json','Authorization': 'Basic $getToken'},
        body: jsonEncode({
          "username": username,
          "name": name,
          "otoritas": otoritas,
          "noHp": noHp
        }));
    var dataPut = (json.decode(hasilResponsePut.body) as Map<String, dynamic>)["data"];
    if(hasilResponsePut.statusCode== 200){
      print("Succes");
    }else{
      print("Fail");
    }

    return HttpUserPut(
        id: dataPut["id"],
        username: dataPut["username"],
        name: dataPut["name"],
        otoritas: dataPut["otoritas"],
        noHp: dataPut["noHp"].toString());
  }
}

// class DELETE DATA
class HttpUserDelete {
  late Uri urlDel;

  static Future connectAPIDelete(String id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    Uri urlDel = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/users/$id");

    var hasilResponseDel = await http.delete(urlDel,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    print(hasilResponseDel.statusCode);
    if(hasilResponseDel.statusCode == 200){
      print("Success delete");
    }else{
      print("Fail delete");
    }
  }
}
