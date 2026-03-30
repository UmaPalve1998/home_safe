import 'dart:convert';



import 'package:dio/dio.dart' as d;

import '../../../stores/app_exception.dart';
import '../../../stores/http_client.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/shared_prefernce.dart';
import '../models/kids_list_model.dart';
import '../models/kids_search_model.dart';

class KidsAPIProvider {
  final HttpClient _httpClient = HttpClient();

  Future<KidsListModel> getKids(int limit, int page) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    final response = await _httpClient.get("${RestApisUrls.KidsList}?page=${page}&limit=${limit}&order=asc");
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final kidsModel = KidsListModel.fromJson(jsonResponse);
      return kidsModel;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }

  Future<KidsSearchModel> getKidsSearchList(String txt) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    var body = RegExp(r'^[0-9]+$').hasMatch(txt)?{
      "flat": txt,
    }:{
      "name": txt
    };
    final response = await _httpClient.post(RestApisUrls.KidsSearch,body
        );
    if (response != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final kidsSearchModel = KidsSearchModel.fromJson(jsonResponse);
      return kidsSearchModel;
    } else {
      throw FetchDataException("Failed to login", RestApisUrls.authURL);
    }
  }

  Future<dynamic> addKid(kidName,age,gender,parentName,parentPhone,block,flat,floor,status,tenentId) async {
    var pushCode = await _httpClient.setFirebaseNotification();
    String guardName = await SPManager.instance
        .getStringItem("USER_NAME");
    print("g anme ${guardName}");
    Map<String, dynamic> fields = {
    "name": kidName,
    "age": age,
    "gender": gender,
    "parentName": parentName,
    "phone": parentPhone,
    "block": block,
    "floor": floor,
    "flat": flat,
    "status": status,
    "tenantId": tenentId,
    "guardName": "${guardName}",
      "time": DateTime.now().toUtc().toIso8601String(),
    };


    d.FormData formData = d.FormData.fromMap(fields);
    final response = await _httpClient.post( "${RestApisUrls.KidsList}",
       fields
    );
    print("inside provide re ${response}");
    return  jsonDecode(response);;
  }



}
