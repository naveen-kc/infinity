import 'package:shared_preferences/shared_preferences.dart';

import '../network/BaseApiService.dart';
import '../network/NetworkApiService.dart';

class Controller{
  BaseApiService _apiService = NetworkApiService();
  String baseUrl='https://fakestoreapi.com/';
  String products='products/';
  String categories='categories';
  String category='category/';

  Future<dynamic> getProducts( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getResponse(baseUrl+products);
    List data = response;
      return data;
  }


  Future<dynamic> getCategories( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getResponse(baseUrl+products+categories);
    List data = response;
    return data;
  }

  Future<dynamic> getByType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getResponse(baseUrl+products+category+type);
    List data = response;
    return data;
  }

}