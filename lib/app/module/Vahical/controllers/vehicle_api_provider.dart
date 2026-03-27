import 'dart:convert';



import '../../../stores/app_exception.dart';
import '../../../stores/http_client.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/shared_prefernce.dart';
import '../models/vehicle_list_model.dart';

class VehicleAPIProvider {
  final HttpClient _httpClient = HttpClient();

  Future<VehicleListModel> getVehicleList(int limit, int page) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    final response = await _httpClient.get("${RestApisUrls.VehicleListAPI}?page=${page}&limit=${limit}&order=asc");
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final visitorsListModel = VehicleListModel.fromJson(jsonResponse);
      return visitorsListModel;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }
}
