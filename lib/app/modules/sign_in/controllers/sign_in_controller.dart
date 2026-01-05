import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  // visible controller
  RxBool isVisible = true.obs;

  void visibleOnTap() {
    isVisible.value = !isVisible.value;
  }

  // validation controller
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // signIn logic
  void signIn() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      Get.offAllNamed(Routes.CUSTOM_BOTTOM_NAVIGATION_BAR);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
