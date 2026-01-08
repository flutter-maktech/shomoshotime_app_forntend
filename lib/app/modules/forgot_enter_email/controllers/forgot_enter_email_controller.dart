import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ForgotEnterEmailController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  void forgotSendCode() {
    final isValid = formKey.currentState!.validate();
    if(isValid){
      Get.toNamed(Routes.FORGOT_ENTER_CODE);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
