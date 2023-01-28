import 'dart:developer';

import 'package:infinity/network/NetworkEndpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/BaseApiService.dart';
import '../network/NetworkApiService.dart';

class LoginController {
  BaseApiService _apiService = NetworkApiService();

//User login api integration
  Future<dynamic> login(username,password) async {
    log("Called Login api");

    var response = await _apiService.postResponse(Endpoints.baseUrl ,Endpoints.login,{
      'username':username,
      'password':password,
    });
    var data = response;
    return data;
  }

}