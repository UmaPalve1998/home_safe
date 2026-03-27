import 'dart:convert';


import '../../../stores/app_exception.dart';
import '../../../stores/http_client.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/shared_prefernce.dart';
import '../models/guard_dashboard.dart';

class DashboardAPIProvider {
  final HttpClient _httpClient = HttpClient();

  Future<GuardDashbord> getDashboard(String date) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    final response = await _httpClient.get(RestApisUrls.GuardDashbord+"?date=$date", );
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final guardDashbord = GuardDashbord.fromJson(jsonResponse);

      return guardDashbord;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }
}
