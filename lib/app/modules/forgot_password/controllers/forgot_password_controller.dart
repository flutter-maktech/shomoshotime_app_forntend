import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  void forgotSendCode() {
    final isValid = formKey.currentState!.validate();
    if(isValid){
      Get.toNamed(Routes.FORGOT_PASSWORD_2);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }


}
