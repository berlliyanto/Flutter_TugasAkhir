

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/energy_model.dart';

class Energy{
  final url = 'https://berlliyantoaji.onrender.com/api/latestEnergy';

  Future getEnergy() async{
    try {
      var responseGetAll = await http.get(Uri.parse(url));
      if(responseGetAll.statusCode==200){
        Iterable it = (json.decode(responseGetAll.body)as Map<String, dynamic>)["data"];
        List<energyModel> energyList = it.map((e) => energyModel.fromJSON(e)).toList();
        return energyList;
      }
    } catch (e) {
      print(e.toString());
      
    }
  }
}