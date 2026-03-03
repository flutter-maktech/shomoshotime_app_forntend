import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/all_utils/log.dart';
import 'package:shomoshotime/app/all_utils/show_app_snack_bar.dart';
import 'package:shomoshotime/app/core/api_services/firebase_services.dart';
import 'package:shomoshotime/app/core/api_services/network_caller.dart';
import 'package:shomoshotime/app/core/urls/urls.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

class DeleteAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final NetworkCaller _networkCaller = NetworkCaller();

  RxBool isLoading = false.obs;
  RxBool isVisible = true.obs;

  Future<void> deleteAccount() async {
    if (isLoading.value) return;

    if (formKey.currentState?.validate() ?? false) {
      try {
        isLoading.value = true;
        final token = await AppPreference.getToken();
        final response = await _networkCaller.postRequest(Urls.deleteAccount, {
          "email": emailController.text.trim(),
          "password": passwordController.text,
        }, token: token);

        if (response['success'] == true) {
          await FirebaseAuthService().signOut();
          await AppPreference.clearAll();
          await AppPreference.clearCurrentPlan();
          await AppPreference.clearProfileImage();
          await AppPreference.clearToken();
          await AppPreference.clearUserId();

          showAppSnackBar(
            context: Get.context!,
            message: "Account deleted successfully",
          );
          Get.offAllNamed(Routes.signIn);
        } else {
          showAppSnackBar(
            context: Get.context!,
            message: response['message'] ?? "Failed to delete account",
          );
        }
      } catch (e) {
        showAppSnackBar(
          context: Get.context!,
          message: "Something went wrong: $e",
        );
        AppLogger.log(e);
      } finally {
        isLoading.value = false;
      }
    }
  }

  void visibleOnTap() {
    isVisible.toggle();
  }

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
