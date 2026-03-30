
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/helpers/dailog_helper.dart';
import '../../dashboard/screen/user_dashboard.dart';
import '../models/flat_search_model.dart';
import '../models/visitors_list_model.dart';
import '../models/visitors_mobile_list.dart';
import 'visitors_api_provider.dart';

class VisitorsController extends GetxController {
  var isLoading = false.obs; // Observable loading state
  var isLoadingVisitor = false.obs; // Observable loading state
  var isLoadingFlat = false.obs; // Observable loading state
  var errorMessage = ''.obs; // Observable error message
  var visitorsListModel = VisitorsListModel().obs;// Observable for login response
  var visitorsMobileSearch = VisitorsMobileSearch().obs;// Observable for login response
  var flatSearch = FlatSearch().obs;// Observable for login response
  var tenantsOwner = <Owner>[].obs;
  var tenantsOwnerSelected = <Owner>[].obs;
  var page = 1;
  var totalPages = 1;
  var isPaginationLoading = false.obs;

  final int limit = 10;

  final VisitorsPIProvider apiProvider = VisitorsPIProvider();
  // ================= INITIAL + REFRESH =================
  Future<void> getVisitorsList({bool isRefresh = false}) async {
    if (isLoading.value || isPaginationLoading.value) return;

    if (isRefresh) {
      page = 1;
      totalPages = 1;
    }

    try {
      if (page == 1) {
        DialogHelper.showLoading();
        isLoading.value = true;
      } else {
        isPaginationLoading.value = true;
      }

      final response = await apiProvider.getVisitorsList(limit, page);

      if (page == 1) {
        // First page or refresh
        visitorsListModel.value = response;
      } else {
        // Append data
        visitorsListModel.update((val) {
          val?.data?.addAll(response.data ?? []);
        });
      }

      totalPages = response.pagination?.totalPages ?? 1;

      page++;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
      DialogHelper.hideLoading();
    }
  }

  ///Search mobile
  Future<void> getVisistorsByMobile(mobile) async {
    isLoadingVisitor.value =  true;

    try {
      final response = await apiProvider.getVisitorsMobile(mobile);
    visitorsMobileSearch.value =  response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingVisitor.value = false;
      isPaginationLoading.value = false;
      DialogHelper.hideLoading();
    }
  }

  ///add Visitors
  Future<void> addVisitors(name,phone,nOfPerson,vehicleNo,guardName,List<File> image) async {
    isLoadingVisitor.value =  true;

    try {
      DialogHelper.showLoading();
      final response = await apiProvider.addVisitors(name,phone,nOfPerson,vehicleNo,guardName, image,tenantsOwnerSelected);
     print("reponse ${response}");
      if(response['success']){
        Get.snackbar("Sucess", "${response['message']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: DifeneceColors.thickGreen,
          colorText: Colors.white,
        );
        isLoading.value = false;
        DialogHelper.hideLoading();
        Get.offAll(  UserDashboard());

      }else{
        Get.snackbar("Error", "${response['message']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: DifeneceColors.appColor,
          colorText: Colors.white,
        );
      }
print("response ${response}");


    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingVisitor.value = false;
      isPaginationLoading.value = false;
      DialogHelper.hideLoading();
    }
  }
  ///Search flat
  Future<void> getFlatList(flat) async {
    isLoadingFlat.value =  true;
    tenantsOwner.clear();

    try {
      final response = await apiProvider.getFlatSearch(flat);
    flatSearch.value =  response;
    if(flatSearch.value.data != null && flatSearch.value.data!.owners.isNotEmpty){
      tenantsOwner.insertAll(tenantsOwner.length, flatSearch.value.data!.owners);

    }    if(flatSearch.value.data != null && flatSearch.value.data!.tenants.isNotEmpty){
      tenantsOwner.insertAll(tenantsOwner.length, flatSearch.value.data!.tenants);

    }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingFlat.value = false;
      DialogHelper.hideLoading();
    }
  }

  // ================= LOAD MORE =================
  void loadMore() {
    if (page <= totalPages) {
      getVisitorsList();
    }
  }

  // ================= PULL TO REFRESH =================
  Future<void> refreshList() async {
    await getVisitorsList(isRefresh: true);
  }

  Future<void> updateVisitorsStatuus(visitorsId,unitId,status) async {
    try {
      isLoading.value = true;
      DialogHelper.showLoading();
      final response = await apiProvider.updateVisitorsStatuus(visitorsId,unitId,status);
      print("reponse c${response['success']}");
      if(response['success']){
        print("reponse if ${response}");
        isLoading.value = false;
        DialogHelper.hideLoading();
        update();
        Get.snackbar("Sucess", "${response['message']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: DifeneceColors.thickGreen,
          colorText: Colors.white,
        );
        getVisitorsList(isRefresh: true);

      }else{
        Get.snackbar("Error", "${response['message']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: DifeneceColors.appColor,
          colorText: Colors.white,
        );
      }
      print("response ${response}");


    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
      DialogHelper.hideLoading();
    }
  }

  // Future<void> getVisitorsList(int limit, int page) async {
  //   DialogHelper.showLoading();
  //   isLoading.value = true;
  //   errorMessage.value = '';
  //   try {
  //     visitorsListModel.value = await apiProvider.getVisitorsList(limit, page);
  //     DialogHelper.hideLoading();
  //   } catch (e) {
  //     // DialogHelper.hideLoading();
  //     errorMessage.value = e.toString(); // Handle error
  //   } finally {
  //     isLoading.value = false;
  //     DialogHelper.hideLoading();
  //   }
  // }
}
