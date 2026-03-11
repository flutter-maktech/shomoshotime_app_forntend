import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../all_utils/app_preference.dart';
import '../../../all_utils/show_app_snack_bar.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/auth_model/otp_verify_model.dart';
import '../../../core/auth_model/resent_otp.dart';
import '../../../core/urls/urls.dart';
import '../../../routes/app_pages.dart';

class SignUpOtpController extends GetxController {
  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // otp controller
  final TextEditingController otpController = TextEditingController();

  // api
  final NetworkCaller _networkCaller = NetworkCaller();

  // state
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // resend timer
  RxInt secondsRemaining = 29.obs;
  RxBool enableResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  // TIMER
  void _startTimer() {
    secondsRemaining.value = 29; // reset to 10 seconds
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

  // VERIFY OTP
  Future<void> verifyOtp() async {
    // validate form first
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final token = await AppPreference.getToken();
      if (token == null || token.isEmpty) {
        throw Exception("Token not found. Please signup again.");
      }

      final model = OtpVerifyModel(otp: int.parse(otpController.text));

      final response = await _networkCaller.postRequest(
        Urls.verifyOtp,
        model.toJson(),
        token: token,
      );

      isLoading.value = false;

      if (response is Map && response['success'] == true) {
        // OTP correct, go to next page
        Get.offAllNamed(Routes.onboarding);
        showAppSnackBar(
          context: Get.context!,
          message: "Sign up successfully",
          backgroundColor: AppColors.greenColor,
        );
      } else {
        // OTP wrong
        errorMessage.value = response['message'] ?? "OTP is wrong";
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
        // message: "OTP is wrong \n ${errorMessage.value}" ,
        message: "OTP is wrong",
        backgroundColor: AppColors.readColor,
      );
    }
  }

  // RESEND OTP
  Future<void> resendOtp() async {
    if (!enableResend.value) return; // check first

    final token = await AppPreference.getToken();
    if (token == null || token.isEmpty) {
      showAppSnackBar(
        context: Get.context!,
        message: "Token not found. Please signup again.",
      );
      return;
    }

    isLoading.value = true;

    try {
      final model = ResentOtpModel(otp: 100);
      final response = await _networkCaller.postRequest(
        Urls.resendOtp,
        model.toJson(),
        token: token,
      );

      isLoading.value = false;

      if (response['success'] == true) {
        showAppSnackBar(
          context: Get.context!,
          // message: response['message'] ?? "OTP resent successfully",
          message: "OTP resent successfully",
          backgroundColor: AppColors.greenColor,
        );
        _startTimer(); // restart countdown
      } else {
        showAppSnackBar(
          context: Get.context!,
          // message: response['message'] ?? "Resend OTP failed",
          message: "Resend OTP failed",
          backgroundColor: AppColors.readColor,
        );
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(
        context: Get.context!,
        message: "Something went wrong. Try again.",
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
