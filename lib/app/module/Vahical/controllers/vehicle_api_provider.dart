import 'dart:convert';



import '../../../stores/app_exception.dart';
import '../../../stores/http_client.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/shared_prefernce.dart';
import '../models/vehicle_list_model.dart';
import '../models/vehicle_search_model.dart';

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


  Future<VehicleSearchModel> getVehicleSearch(String txt) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    var body = {
      "digits": txt
    };
    final response = await _httpClient.post(RestApisUrls.vehicleSearch,body
    );
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final kidsSearchModel = VehicleSearchModel.fromJson(jsonResponse);
      return kidsSearchModel;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }

  Future<dynamic> addVehicle(vehicleNo,name,phone,block,floor,flat,status,ownerId) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    String guardName = await SPManager.instance
        .getStringItem("USER_NAME");
    print("g anme ${guardName}");
    Map<String, dynamic> fields = {
      "vehicleNo": vehicleNo,
      "name": name,
      "phone": phone,
      "block": block,
      "floor": floor,
      "flat": flat,
      "guardName": guardName,
      "status": status,
      "time": "${DateTime.now()}",
      "ownerId": ownerId
    };


    final response = await _httpClient.post( "${RestApisUrls.VehicleListAPI}",
        fields
    );
    print("inside provide re ${response}");
    return  jsonDecode(response);;
  }
}
