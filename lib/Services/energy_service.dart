import 'package:collection/collection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/energy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Energy {
  final url = 'https://aplikasi-pms-berli.onrender.com/api/latestEnergy';

  Future getEnergy() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    try {
      var responseGetAll = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
      if (responseGetAll.statusCode == 200) {
        Iterable it =
            (json.decode(responseGetAll.body) as Map<String, dynamic>)["data"];
        List<energyModel> energyList =
            it.map((e) => energyModel.fromJSON(e)).toList();
        return energyList;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class chartperEnergy {
  final url = 'https://aplikasi-pms-berli.onrender.com/api/grafikEnergy';

  //VOLTAGE
  Future getVolt() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    var responseGetAll = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    if (responseGetAll.statusCode == 200) {
      Iterable it =
          (json.decode(responseGetAll.body) as Map<String, dynamic>)["data"];
      List<voltModel> voltlist = it.map((e) => voltModel.fromJSON(e)).toList();
      return voltlist;
    }
  }
  //CURRENT
  Future getCurrent() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    var responseGetAll = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    if (responseGetAll.statusCode == 200) {
      Iterable it =
          (json.decode(responseGetAll.body) as Map<String, dynamic>)["data"];
      List<currentModel> currentlist = it.map((e) => currentModel.fromJSON(e)).toList();
      return currentlist;
    }
  }
  //POWER
  Future getPower() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    var responseGetAll = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    if (responseGetAll.statusCode == 200) {
      Iterable it =
          (json.decode(responseGetAll.body) as Map<String, dynamic>)["data"];
      List<powerModel> powerlist = it.map((e) => powerModel.fromJSON(e)).toList();
      return powerlist;
    }
  }
  //ENERGY
  Future getEnergi() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    var responseGetAll = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    if (responseGetAll.statusCode == 200) {
      Iterable it =
          (json.decode(responseGetAll.body) as Map<String, dynamic>)["data"];
      List<energiModel> energilist = it.map((e) => energiModel.fromJSON(e)).toList();
      return energilist;
    }
  }
  //FREQUENCY
  Future getFrequency() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    var responseGetAll = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    if (responseGetAll.statusCode == 200) {
      Iterable it =
          (json.decode(responseGetAll.body) as Map<String, dynamic>)["data"];
      List<frequencyModel> frequencylist = it.map((e) => frequencyModel.fromJSON(e)).toList();
      return frequencylist;
    }
  }
  //POWER FACTOR
  Future getPf() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
        var getToken = shared.getString("token");
    var responseGetAll = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $getToken'
    });
    if (responseGetAll.statusCode == 200) {
      Iterable it =
          (json.decode(responseGetAll.body) as Map<String, dynamic>)["data"];
      List<pfModel> pflist = it.map((e) => pfModel.fromJSON(e)).toList();
      return pflist;
    }
  }
}
