
import 'package:get/get.dart';
import 'package:home_safe/app/module/Vahical/controllers/vehicle_api_provider.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/helpers/dailog_helper.dart';
import '../../dashboard/screen/user_dashboard.dart';
import '../models/kids_list_model.dart';
import '../models/kids_search_model.dart';
import 'kids_api_provider.dart';
import 'package:flutter/material.dart';

class KidsController extends GetxController {
  var isLoading = false.obs; // Observable loading state
  var isLoadingKids = false.obs; // Observable loading state
  var errorMessage = ''.obs; // Observable error message
  var kidsListModel = KidsListModel().obs;// Observable for login response
  var kidsSearchModel = KidsSearchModel().obs;// Observable for login response
  var page = 1;
  var totalPages = 1;
  var isPaginationLoading = false.obs;

  final int limit = 10;

  final KidsAPIProvider apiProvider = KidsAPIProvider();
  // ================= INITIAL + REFRESH =================
  Future<void> getKidsList({bool isRefresh = false}) async {
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

      final response = await apiProvider.getKids(limit, page);

      if (page == 1) {
        // First page or refresh
        kidsListModel.value = response;
      } else {
        // Append data
        kidsListModel.update((val) {
          val?.data?.addAll(response.data ?? []);
        });
      }

      totalPages = response?.total ?? 1;

      page++;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
      DialogHelper.hideLoading();
    }
  }

  // ================= LOAD MORE =================
  void loadMore() {
    if (page <= totalPages) {
      getKidsList();
    }
  }

  // ================= PULL TO REFRESH =================
  Future<void> refreshList() async {
    await getKidsList(isRefresh: true);
  }

  Future<void> getKidsSearch(search) async {
    // DialogHelper.showLoading();
    kidsSearchModel.value = KidsSearchModel();
        isLoadingKids.value = true;
    errorMessage.value = '';
    try {
      kidsSearchModel.value = await apiProvider.getKidsSearchList(search);
      DialogHelper.hideLoading();
    } catch (e) {
      // DialogHelper.hideLoading();
      errorMessage.value = e.toString(); // Handle error
    } finally {
      isLoadingKids.value = false;
      DialogHelper.hideLoading();
    }
  }

  Future<void> addKid(kidName,age,gender,parentName,parentPhone,block,flat,floor,status,tenentId) async {
    try {
      isLoading.value = true;
      DialogHelper.showLoading();
      final response = await apiProvider.addKid(kidName,age,gender,parentName,parentPhone,block,flat,floor,status,tenentId);
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
      isLoading.value = false;
      isPaginationLoading.value = false;
      DialogHelper.hideLoading();
    }
  }

}
