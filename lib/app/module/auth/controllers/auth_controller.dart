
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/helpers/dailog_helper.dart';
import '../../../utils/helpers/flutter_navigation.dart';
import '../../../utils/widgets/global_widgets.dart';
import '../../dashboard/screen/user_dashboard.dart';
import '../models/auth_model.dart';
import '../screen/auth_screen.dart';
import 'login_api_provider.dart';

class LoginController extends GetxController {
  var isLoading = false.obs; // Observable loading state
  var errorMessage = ''.obs; // Observable error message
  var loginResponse = LoginResponse().obs;// Observable for login response

  final LoginApiProvider apiProvider = LoginApiProvider();

  Future<void> login(String userName, String password,BuildContext context) async {
    DialogHelper.showLoading();
    isLoading.value = true;
    errorMessage.value = '';
    try {
      loginResponse.value = await apiProvider.userLogin(userName, password);
      DialogHelper.hideLoading();
      if (loginResponse.value.success == false) {
        isLoading.value = false;
        DialogHelper.hideLoading();
        errorMessage.value = loginResponse.value.message ?? "Login failed";
        flutterToast(
            message: "Login Error" "${errorMessage.value}",
            bgColor: DifeneceColors.RedColor);
      }else{
        isLoading.value = false;
        DialogHelper.hideLoading();
        Get.offAll(  UserDashboard());
      }
    } catch (e) {
      // DialogHelper.hideLoading();
      errorMessage.value = e.toString(); // Handle error
    } finally {
      isLoading.value = false;
      DialogHelper.hideLoading();
    }
  }
}
