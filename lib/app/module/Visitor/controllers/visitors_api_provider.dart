import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart' as d;
import 'package:http/http.dart' as http;
import '../../../stores/app_exception.dart';
import '../../../stores/http_client.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/shared_prefernce.dart';
import '../models/flat_search_model.dart';
import '../models/visitors_list_model.dart';
import '../models/visitors_mobile_list.dart';
import 'package:dio/dio.dart' as a;
class VisitorsPIProvider {
  final HttpClient _httpClient = HttpClient();

  Future<VisitorsListModel> getVisitorsList(int limit, int page) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    final response = await _httpClient.get("${RestApisUrls.VisitorsListAPI}?page=${page}&limit=${limit}&sortBy=createdAt&order=as");
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final visitorsListModel = VisitorsListModel.fromJson(jsonResponse);
      return visitorsListModel;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }

  Future<VisitorsMobileSearch> getVisitorsMobile(mobile) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    final response = await _httpClient.get("${RestApisUrls.SearchVisitors}?phone=${mobile}");
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final visitorsMobileSearch = VisitorsMobileSearch.fromJson(jsonResponse);
      return visitorsMobileSearch;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }

  Future<dynamic> addVisitors(name,phone,nOfPerson,vehicleNo,guardName,List<File>? image,List<Owner> unitsList) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    a.Dio dio = d.Dio();
    String guard = await SPManager.instance
        .getStringItem("USER_NAME");
    print("g anme ${guard}");
    Map<String, dynamic> fields = {
      "name": name,
      "phone": phone,
      "noOfPersons": nOfPerson,
      "vehicleNo": vehicleNo,
      "guardName": "${guard}",
      "inTime": DateTime.now().toUtc().toIso8601String(),
      "outTime": DateTime.now().toUtc().toIso8601String(),
    };

    // 🔹 Add units like screenshot
    for (int i = 0; i < unitsList.length; i++) {
      fields["units[$i][tenantId]"] = unitsList[i].tenantId ?? "";
      fields["units[$i][ownerId]"] = unitsList[i].ownerId ?? "";
      fields["units[$i][block]"] = unitsList[i].block ?? "";
      fields["units[$i][floor]"] = unitsList[i].floor ?? "";
      fields["units[$i][flat]"] = unitsList[i].flat ?? "";
    }

    // 🔹 Add image (must match EXACT name in screenshot)
    if (image!=null && image!.isNotEmpty) {
      fields["visitorImage"] = await d.MultipartFile.fromFile(
        image![0].path,
        filename: image[0].path.split('/').last,
      );
    }


    print("from data ${fields}");
    // 🔹 Convert to FormData
    d.FormData formData = d.FormData.fromMap(fields);
    final response = await _httpClient.multipartForm(endPoint: "${RestApisUrls.addVisitors}",
        // fields: fields, files: image
      fromData: formData
    );
    print("inside provide re ${response}");
  return jsonDecode(response);;;
  }

  Future<FlatSearch> getFlatSearch(flatNo) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    final response = await _httpClient.get("${RestApisUrls.SearchFlat}?flat=${flatNo}");
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final flatSearch = FlatSearch.fromJson(jsonResponse);
      return flatSearch;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }

  Future<dynamic> updateVisitorsStatuus(visitorsId,unitId,status) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    String guardName = await SPManager.instance
        .getStringItem("USER_NAME");
    print("g anme ${guardName}");
    Map<String, dynamic> fields = {
      "unitId": unitId,
      "inStatus": status

    };

    String endURl= "/api/v1/visitors/${visitorsId}/unit-in-status";

    d.FormData formData = d.FormData.fromMap(fields);
    final response = await _httpClient.patch( endURl,
        fields
    );
    print("inside provide re ${response}");
    return  jsonDecode(response);;
  }
}
