import 'dart:developer';

import 'package:infinity/network/NetworkEndpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/BaseApiService.dart';
import '../network/NetworkApiService.dart';

class Controller{
  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> getProducts( ) async {
    log("Called api");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getResponse(Endpoints.baseUrl+Endpoints.products);
    List data = response;
      return data;
  }


  Future<dynamic> getCategories( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getResponse(Endpoints.baseUrl+Endpoints.products+Endpoints.categories);
    List data = response;
    return data;
  }

  Future<dynamic> getByType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getResponse(Endpoints.baseUrl+Endpoints.products+Endpoints.category+type);
    List data = response;
    return data;
  }

}