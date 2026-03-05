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

    final bool isSuccess = response['success'] == true;
    final String message = response['message'] ?? 'Something went wrong';

    if (isSuccess) {
      final token = response['data']?['token'];

      if (token != null) {
        await AppPreference.saveToken(token);
      }
    }

    if (isSuccess) {
      showAppSnackBar(
        context: Get.context!,
        message: message,
        backgroundColor: AppColors.greenColor,
      );
      Get.toNamed(
        Routes.forgotEnterCode,
        arguments: {'email': emailController.text},
      );
    } else {
      showAppSnackBar(
        context: Get.context!,
        message: message,
        backgroundColor: AppColors.readColor,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
