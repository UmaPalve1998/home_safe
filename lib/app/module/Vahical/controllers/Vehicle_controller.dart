
import 'package:get/get.dart';
import 'package:home_safe/app/module/Vahical/controllers/vehicle_api_provider.dart';
import 'package:home_safe/app/module/Vahical/models/vehicle_list_model.dart';

import '../../../utils/helpers/dailog_helper.dart';

class VahicleController extends GetxController {
  var isLoading = false.obs; // Observable loading state
  var errorMessage = ''.obs; // Observable error message
  var vehicleListModel = VehicleListModel().obs;// Observable for login response
  var page = 1;
  var totalPages = 1;
  var isPaginationLoading = false.obs;

  final int limit = 10;

  final VehicleAPIProvider apiProvider = VehicleAPIProvider();
  // ================= INITIAL + REFRESH =================
  Future<void> getVehicleList({bool isRefresh = false}) async {
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

      final response = await apiProvider.getVehicleList(limit, page);

      if (page == 1) {
        // First page or refresh
        vehicleListModel.value = response;
      } else {
        // Append data
        vehicleListModel.update((val) {
          val?.data?.addAll(response.data ?? []);
        });
      }

      totalPages = response?.totalPages ?? 1;

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
      getVehicleList();
    }
  }

  // ================= PULL TO REFRESH =================
  Future<void> refreshList() async {
    await getVehicleList(isRefresh: true);
  }

}
