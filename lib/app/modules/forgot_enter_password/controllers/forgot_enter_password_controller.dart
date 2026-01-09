import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../all_utils/app_preference.dart';
import '../../../all_utils/show_app_snack_bar.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/auth_model/forgot_reset_password_model.dart';
import '../../../core/urls/urls.dart';
import '../../../data/app_colors.dart';
import '../../../routes/app_pages.dart';

class ForgotEnterPasswordController extends GetxController {
  // Visibility
  RxBool isVisibleAddPass = true.obs;
  RxBool isVisibleConfirmPass = true.obs;

  void toggleAddPassVisibility() {
    isVisibleAddPass.value = !isVisibleAddPass.value;
  }

  void toggleConfirmPassVisibility() {
    isVisibleConfirmPass.value = !isVisibleConfirmPass.value;
  }

  // Text controllers
  final addNewPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Loading state
  RxBool isLoading = false.obs;

  // Save new password
  Future<void> saveNewPass(String email) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      // Get token and email from AppPreference
      final token = await AppPreference.getToken();

      if (token == null) {
        throw Exception("Token or Email not found");
      }

      final model = ForgotResetPasswordModel(
        token: token,
        email: email,
        password: addNewPassController.text.trim(),
        passwordConfirmation: confirmPassController.text.trim(),
      );

      final response = await NetworkCaller().postRequest(
        Urls.resetPassword,
        model.toJson(),
      );

      isLoading.value = false;

      if (response['success'] == true) {
        showAppSnackBar(
          context: Get.context!,
          // message: response['message'] ?? "Password reset successfully",
          message: "Password reset successfully",
          backgroundColor: AppColors.greenColor,
        );
        Get.offAllNamed(Routes.SIGN_IN);
      } else {
        showAppSnackBar(
          context: Get.context!,
          // message: response['message'] ?? "Reset password failed",
          message: "Reset password failed",
          backgroundColor: AppColors.readColor,
        );
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(
        context: Get.context!,
        message: "Error: ${e.toString()}",
        backgroundColor: AppColors.readColor,
      );
    }
  }

  @override
  void onClose() {
    addNewPassController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }
}
