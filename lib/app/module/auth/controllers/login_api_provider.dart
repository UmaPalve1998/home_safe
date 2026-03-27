import 'dart:convert';


import '../../../stores/app_exception.dart';
import '../../../stores/http_client.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/shared_prefernce.dart';
import '../models/auth_model.dart';

class LoginApiProvider {
  final HttpClient _httpClient = HttpClient();

  Future<LoginResponse> userLogin(String userName, String password) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    final response = await _httpClient.post(RestApisUrls.authURL, {
      "email": userName,
      "password": password,
    });
    print("Oject res ${response}");
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final loginResponse = LoginResponse.fromJson(jsonResponse);
      print("FCM code $pushCode");
      if (loginResponse.success != null && loginResponse.success != false) {
        await SPManager.instance
            .setToken(loginResponse.accessToken.toString()!); // Example of saving the token
      }

      return loginResponse;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }
}
