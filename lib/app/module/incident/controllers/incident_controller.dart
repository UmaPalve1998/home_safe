
import 'package:get/get.dart';

import '../../../utils/helpers/dailog_helper.dart';
import '../models/incident_model.dart';
import 'incident_api_provider.dart';

class IncidentController extends GetxController {
  var isLoading = false.obs; // Observable loading state
  var errorMessage = ''.obs; // Observable error message
  var incidentListModel = IncidentListModel().obs;// Observable for login response
  var page = 1;
  var totalPages = 1;
  var isPaginationLoading = false.obs;

  final int limit = 10;

  final IncidentApIProvider apiProvider = IncidentApIProvider();
  // ================= INITIAL + REFRESH =================
  Future<void> getIncidentList({bool isRefresh = false}) async {
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

      final response = await apiProvider.getIncidentList(limit, page);

      if (page == 1) {
        // First page or refresh
        incidentListModel.value = response;
      } else {
        // Append data
        incidentListModel.update((val) {
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
      getIncidentList();
    }
  }

  // ================= PULL TO REFRESH =================
  Future<void> refreshList() async {
    await getIncidentList(isRefresh: true);
  }
}
