import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/core/api_services/network_caller.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/utils/show_app_snack_bar.dart';
import '../../../core/auth_model/sign_in_model.dart';
import '../../../core/urls/urls.dart';
import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  // Password visibility
  RxBool isVisible = true.obs;

  void visibleOnTap() {
    isVisible.toggle();
  }

  // Form validation
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // API
  final NetworkCaller networkCaller = NetworkCaller();

  RxBool isLoading = false.obs;
  RxString message = ''.obs;

  // Sign in button action
  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) return;

    final model = SignInModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      fcmToken: "dummy_fcm_token",
    );

    final success = await loginUser(model);

    if (success) {
      Get.offAllNamed(Routes.CUSTOM_BOTTOM_NAVIGATION_BAR);
    } else {
      showAppSnackBar(
        context: Get.context!,
        message: message.value,
        backgroundColor: AppColors.profileFailed,
      );
    }
  }

  // Login API call
  Future<bool> loginUser(SignInModel model) async {
    try {
      isLoading.value = true;

      final response = await networkCaller.postRequest(
        Urls.logInUrl,
        model.toJson(),
      );

      Map<String, dynamic> data;

      if (response is String) {
        data = jsonDecode(response);
      } else if (response is Map) {
        data = Map<String, dynamic>.from(response);
      } else {
        message.value = 'Invalid server response';
        return false;
      }

      if (data['success'] == true) {
        message.value = data['message'] ?? 'Login successful';
        return true;
      } else {
        message.value = data['message'] ?? 'Login failed';
        return false;
      }
    } catch (e) {
      message.value = 'Something went wrong';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
