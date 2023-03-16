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

    var url = Uri.parse("https://aplikasi-pms-berli.onrender.com/api/login");

    var responseLogin  = await client.post(url,
     headers: requestHeaders, 
     body: jsonEncode(model.toJson()),);
     var data = json.decode(responseLogin.body)['data'];
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
  //Authorization------------------------------------------------------------
  // static Future<String> getProfile() async {
  //   var loginDetails = await SharedService.loginDetails();
    // Map<String, String> requestHeaders = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Basic ${loginDetails!.data?.token}'
    // };

  //   var url = Uri.parse("http://192.168.1.13:5000/api/user-profile");

  //   var responseLogin  = await client.get(url,
  //    headers: requestHeaders, 
  //    );
  //    if(responseLogin.statusCode==200){
  //     return (responseLogin.body);
  //    }else{
  //     return '';
  //    }
  // }
}

