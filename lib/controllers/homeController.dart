import 'dart:developer';https://teams.microsoft.com/l/meetup-join/19%3ameeting_MjIwOTA3YmEtMDQ1MS00NWYzLThiNDEtYjNiODgxMjJkMzMw%40thread.v2/0?context=%7b%22Tid%22%3a%2276a2ae5a-9f00-4f6b-95ed-5d33d77c4d61%22%2c%22Oid%22%3a%2275b46dc4-0d0a-4f38-89b3-3437c48ab17c%22%7d

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
