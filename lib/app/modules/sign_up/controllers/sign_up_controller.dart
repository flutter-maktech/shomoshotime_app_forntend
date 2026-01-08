import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/core/api_services/network_caller.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import '../../../all_utils/app_preference.dart';
import '../../../all_utils/show_app_snack_bar.dart';
import '../../../core/auth_model/sign_up_model.dart';
import '../../../core/urls/urls.dart';
import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  // ===== Password Visibility =====
  RxBool isVisiblePass = true.obs;
  RxBool isVisibleConfirmPass = true.obs;

  void isVisiblePassOnTap() {
    isVisiblePass.toggle();
  }

  void isVisibleConfirmPassOnTap() {
    isVisibleConfirmPass.toggle();
  }

  // ===== Form Validation =====
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ===== API =====
  final NetworkCaller networkCaller = NetworkCaller();

  RxBool isLoading = false.obs;
  RxString message = ''.obs;

  // ===== SIGN UP BUTTON ACTION =====
  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    final model = SignupModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      passwordConfirmation: confirmPasswordController.text.trim(),
      fcmToken: "Test Token1",
    );

    final success = await registerUser(model);

    if (success) {
      Get.offAllNamed(Routes.SIGN_UP_OTP);
    } else {
      showAppSnackBar(
        context: Get.context!,
        message: message.value,
        backgroundColor: AppColors.profileFailed,
      );
    }
  }

  // ===== REGISTER USER API CALL =====
  Future<bool> registerUser(SignupModel model) async {
    try {
      isLoading.value = true;

      final response = await networkCaller.postRequest(
        Urls.signUpUrl,
        model.toJson(),
      );

      print("API Response: $response");

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
        /// ✅ TOKEN EXTRACT
        final String token = data['data']?['token'] ?? '';

        /// ✅ TOKEN SAVE
        if (token.isNotEmpty) {
          await AppPreference.saveToken(token);
          print('Token saved: $token');
        }

        message.value = data['message'] ?? 'Registration successful';
        return true;
      } else {
        message.value = data['message'] ?? 'Registration failed';
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
