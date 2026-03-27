
import 'package:get/get.dart';

import '../../../utils/helpers/dailog_helper.dart';
import '../models/guard_dashboard.dart';
import 'dashboard_api_provider.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs; // Observable loading state
  var errorMessage = ''.obs; // Observable error message
  var guardDashbord = GuardDashbord().obs;// Observable for login response
  var uniDate = DateTime.now().obs;

  final DashboardAPIProvider apiProvider = DashboardAPIProvider();

  Future<void> getGuardDashboard(String date) async {
    DialogHelper.showLoading();
    isLoading.value = true;
    errorMessage.value = '';
    try {
      guardDashbord.value = await apiProvider.getDashboard(date);
    } catch (e) {
      // DialogHelper.hideLoading();
      errorMessage.value = e.toString(); // Handle error
    } finally {
      isLoading.value = false;
      DialogHelper.hideLoading();
    }
  }
}
