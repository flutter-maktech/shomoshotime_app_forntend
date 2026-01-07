import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/utils/show_app_snack_bar.dart';

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
  RxInt secondsRemaining = 30.obs;
  RxBool enableResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  // ================= TIMER =================
  void _startTimer() {
    secondsRemaining.value = 30;
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

  // ================= VERIFY OTP =================
  Future<void> verifyOtp() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final model = OtpVerifyModel(
      otp: int.parse(otpController.text),
    );

    final response = await _networkCaller.postRequest(
      Urls.verifyOtp,
      model.toJson(),
    );

    isLoading.value = false;

    if (response.isSuccess) {
      Get.offAllNamed(Routes.ONBOARDING);
    } else {
      showAppSnackBar(context: Get.context!, message: "OTP verification failed");
    }
  }

  // ================= RESEND OTP =================
  Future<void> resendOtp() async {
    if (!enableResend.value) return;

    isLoading.value = true;

    final model = ResentOtpModel(
      otp: int.parse(otpController.text),
    );

    final response = await _networkCaller.postRequest(
      Urls.resendOtp,
      model.toJson(),
    );

    isLoading.value = false;

    if (response.isSuccess) {
      _startTimer();
      showAppSnackBar(context: Get.context!, message: "OTP resent successfully");
    } else {
      showAppSnackBar(context: Get.context!, message: "Resend OTP failed");

    }
  }

  @override
  void onClose() {
    otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
