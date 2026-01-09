import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import '../../../all_utils/app_preference.dart';
import '../../../routes/app_pages.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../core/auth_model/forgot_email_model.dart';
import '../../../all_utils/show_app_snack_bar.dart';

class ForgotEnterEmailController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  Future<void> forgotSendCode() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    _isLoading.value = true;

    final model = ForgotEmailModel(email: emailController.text.trim());

    final NetworkCaller networkCaller = NetworkCaller();

    // API call
    final response = await networkCaller.postRequest(
      Urls.forgotPassword,
      model.toJson(),
    );

    _isLoading.value = false;

    // Response handle
    final bool isSuccess = response['success'] == true;
    final String message = response['message'] ?? 'Something went wrong';
    final token = response['data']['token'];

    AppPreference.saveToken(token);

    if (isSuccess) {
      showAppSnackBar(
        context: Get.context!,
        message: message,
        backgroundColor: AppColors.greenColor,
      );

      // Small delay to ensure snack bar is shown
      await Future.delayed(Duration(milliseconds: 300));

      Get.toNamed(Routes.FORGOT_ENTER_CODE,arguments: {'email': emailController.text});
    } else {
      showAppSnackBar(
        context: Get.context!,
        message: message,
        backgroundColor: AppColors.grey,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
