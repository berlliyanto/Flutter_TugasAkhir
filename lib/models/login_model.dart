// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

import 'dart:convert';


class loginRequestModel{
  late String? username, password;

  loginRequestModel({this.username, this.password});

  loginRequestModel.fromJSON(Map<String, dynamic> json){
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
		data['username'] = username;
		data['password'] = password;
		return data;
  }
}

loginResponseModel LoginResponseJson(String str) =>
loginResponseModel.fromJson(json.decode(str));

class loginResponseModel{
  late String? message;
  late Data? data;

  loginResponseModel({this.message, this.data});

  loginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  late String? username;
  late String? name;
  late String? otoritas;
  late String? noHp;
  late String? id;
  late String? token;

  Data(
      {required this.username,
      required this.name,
      required this.otoritas,
      required this.noHp,
      required this.id,
      required this.token});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    otoritas = json['otoritas'];
    noHp = json['noHp'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['name'] = name;
    data['otoritas'] = otoritas;
    data['noHp'] = noHp;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}

class loginDataModel{
  late String? name,otoritas;

  loginDataModel({this.name,this.otoritas});

  factory loginDataModel.fromJSON(Map<String, dynamic> json){
      return loginDataModel(
        name: json['name'],
        otoritas: json['_otoritas'],
      );
  }
  Map<String, dynamic> toJson() {
    final dataParameter = <String, dynamic>{};
    dataParameter['name'] = name;
    dataParameter['_otoritas'] = otoritas;
    return dataParameter;
  }
}