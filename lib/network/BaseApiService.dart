abstract class BaseApiService {
  Future<dynamic> getResponse(String url);

  Future<dynamic> postResponse(String baseUrl, String url, Map<String, dynamic> jsonBody);
}
