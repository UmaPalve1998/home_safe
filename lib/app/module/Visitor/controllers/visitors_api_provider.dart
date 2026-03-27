import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import '../../../stores/app_exception.dart';
import '../../../stores/http_client.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/shared_prefernce.dart';
import '../models/flat_search_model.dart';
import '../models/visitors_list_model.dart';
import '../models/visitors_mobile_list.dart';

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
    Map<String, String> fields = {
      "name": '${name}',
      "phone": '${phone}',
      "noOfPersons": '${nOfPerson}',
      "vehicleNo": '${vehicleNo}',
      "guardName": 'mano',
    };

    for (int i = 0; i < unitsList.length; i++) {
      fields['units[$i][ownerId]'] =
          unitsList[i].ownerId ?? '';

      fields['units[$i][firstName]'] =
          unitsList[i].firstName ?? '';

      fields['units[$i][phone]'] =
          unitsList[i].phone ?? '';

      fields['units[$i][block]'] =
          unitsList[i].block ?? '';

      fields['units[$i][floor]'] =
          unitsList[i].floor ?? '';

      fields['units[$i][flat]'] =
          unitsList[i].flat ?? '';

      fields['units[$i][role]'] =
          unitsList[i].role ?? '';

      fields['units[$i][tenantId]'] =
          unitsList[i].tenantId ?? '';
    }
    final response = await _httpClient.multipartForm(endPoint: "${RestApisUrls.addVisitors}",
        fields: fields, files: image);
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);

      return jsonResponse;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
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
}
