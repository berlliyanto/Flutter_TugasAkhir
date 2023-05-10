import 'dart:convert';

import 'package:flutter_application_1/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//CLASS Login User--------------------------------------------------------------------------
class LoginService{
  static var client = http.Client();
  
  static Future<bool> login(loginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("https://berli.aplikasipms.com/api/login");

    var responseLogin  = await client.post(url,
     headers: requestHeaders, 
     body: jsonEncode(model.toJson()),);
     var data = json.decode(responseLogin.body)['data'];
     print(data);
     if(responseLogin.statusCode==200){
      // Shared
      final SharedPreferences sharedData = await SharedPreferences.getInstance();
      sharedData.setString("name", data['name'] );
      sharedData.setString("otoritas", data['otoritas']);
      sharedData.setString("token", data['token']);
      return true;
     }else{
      return false;
     }
  }
}

