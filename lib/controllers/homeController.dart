import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:infinity/network/NetworkEndpoints.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/BaseApiService.dart';
import '../network/NetworkApiService.dart';
import 'itemData.dart';

class Controller{
  BaseApiService _apiService = NetworkApiService();

  //Get products based on the limit api
  Future<dynamic> getProducts(BuildContext context) async {
    var itemInfo = Provider.of<ItemData>(context,listen: false);
    Map<String, String> queryParams = {
      'limit':itemInfo.getLimit()
    };
    Uri uri =
    Uri.parse(Endpoints.baseUrl + Endpoints.products);
    final finalUri = uri.replace(queryParameters: queryParams);
    var response = await _apiService.getResponse(finalUri.toString());
    List data = response;
      return data;
  }

//Get categories api
  Future<dynamic> getCategories( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getResponse(Endpoints.baseUrl+Endpoints.products+Endpoints.categories);
    List data = response;
    return data;
  }


  //Get the products by type
  Future<dynamic> getByType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getResponse(Endpoints.baseUrl+Endpoints.products+Endpoints.category+type);
    List data = response;
    return data;
  }

}