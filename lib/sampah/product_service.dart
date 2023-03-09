// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter_application_1/sampah/Config.dart';
import 'package:flutter_application_1/sampah/product_model.dart';
import 'package:http/http.dart' as http;


class APIService{
  static var client = http.Client();

  static Future<List<ProductModel>?> getProducts() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/jsom'};

    var url = Uri.http(Config.url, Config.productUrl);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);

      return productFromJson(data["data"]);
    }else {
      return null;
    }
  }

  static Future<bool> saveProduct(
    ProductModel model, 
    bool isEditMode,
  ) async {
    var producURL = Config.productUrl;

    if(isEditMode) {
      producURL = "$producURL/${model.id}";
    }

    var url = Uri.http(Config.url, Config.productUrl);

    var requestMethod  = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["productName"] = model.productName!;
    request.fields["productPrice"] = model.productPrice!.toString();

    var response = await request.send();

    if (response.statusCode == 200){
      return true;
    }else {
      return false;
    }
  }

  static Future<bool> deleteProducts(productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.url, "${Config.productUrl}/" + productId);

    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200){
      return true;
    }else {
      return false;
    }
  }
  
}