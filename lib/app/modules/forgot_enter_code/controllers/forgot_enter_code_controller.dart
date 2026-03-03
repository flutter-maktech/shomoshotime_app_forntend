import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import '../../../all_utils/app_preference.dart';
import '../../../all_utils/show_app_snack_bar.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/auth_model/forgot_verify_otp_model.dart';
import '../../../core/urls/urls.dart';
import '../../../routes/app_pages.dart';

class ForgotEnterCodeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  final NetworkCaller networkCaller = NetworkCaller();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxInt secondsRemaining = 29.obs;
  RxBool enableResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  void _startTimer() {
    secondsRemaining.value = 29;
    enableResend.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        timer.cancel();
      }
    });
  }

  // Verify OTP API call
  Future<void> verifyOtp(String email) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final token = await AppPreference.getToken();

      if (token == null) {
        throw Exception('Token or Email not found. Please resend OTP.');
      }

      final model = ForgotVerifyOtpModel(
        email: email,
        token: token,
        otp: otpController.text.trim(),
      );

      final response = await networkCaller.postRequest(
        Urls.forgotVerifyOtp,
        model.toJson(),
      );

      isLoading.value = false;

      if (response['success'] == true) {
        Get.offAllNamed(Routes.forgotEnterPassword, arguments: {'email' : email});
        showAppSnackBar(
          context: Get.context!,
          message: response['message'] ?? 'OTP verified successfully',
          backgroundColor: AppColors.greenColor,
        );
      } else {
        errorMessage.value = response['message'] ?? 'Invalid OTP';
        showAppSnackBar(
          context: Get.context!,
          message: errorMessage.value,
          backgroundColor: AppColors.readColor,
        );
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      showAppSnackBar(
        context: Get.context!,
        message: "Error verifying OTP:\n${errorMessage.value}",
        backgroundColor: AppColors.readColor,
      );
    }
  }

  //Resend OTP API call
  Future<void> resendOtp(String email) async {
    if (!enableResend.value) return;

    final token = await AppPreference.getToken();

    if (token == null) {
      showAppSnackBar(
        context: Get.context!,
        message: 'Token or Email not found. Please resend OTP.',
        backgroundColor: AppColors.readColor,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await networkCaller.postRequest(
        Urls.forgotResendOtp,
        {
          'email': email,
          'token': token,
        },
      );

      isLoading.value = false;

      if (response['success'] == true) {
        showAppSnackBar(
          context: Get.context!,
          message: response['message'] ?? 'OTP resent successfully',
          backgroundColor: AppColors.greenColor,
        );
        _startTimer(); // restart countdown
      } else {
        showAppSnackBar(
          context: Get.context!,
          message: response['message'] ?? 'Resend OTP failed',
          backgroundColor: AppColors.readColor,
        );
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(
        context: Get.context!,
        message: 'Error resending OTP:\n${e.toString()}',
        backgroundColor: AppColors.readColor,
      );
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
