import 'dart:convert';


import '../../../stores/app_exception.dart';
import '../../../stores/http_client.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/shared_prefernce.dart';
import '../models/incident_model.dart';

class IncidentApIProvider {
  final HttpClient _httpClient = HttpClient();

  Future<IncidentListModel> getIncidentList(int limit, int page) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    final response = await _httpClient.get("${RestApisUrls.IncidentListAPI}?page=${page}&limit=${limit}&order=asc");
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final incidentListModel = IncidentListModel.fromJson(jsonResponse);
      return incidentListModel;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }
}
