import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'BaseApiService.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    url;
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      log("$url");
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(
      String baseUrl, String url, Map<String, dynamic> JsonBody) async {
    dynamic responseJson;
    log("$baseUrl$url$JsonBody");


    try {
      final response =
      await http.post(Uri.parse(baseUrl + url), body: JsonBody);
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    print(responseJson);
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    if (response.statusCode==200) {

      dynamic responseJson = jsonDecode(response.body);
      return responseJson;

    }
    else{

      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    }

  }
}
