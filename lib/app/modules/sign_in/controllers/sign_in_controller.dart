import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  // Submit logic
  void submit() {
    if (formKey.currentState!.validate()) {
      // all validation completed
      Get.snackbar('Success', 'Form validation successful');
    } else {
      Get.snackbar('Error', 'Please fix the errors');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }


}
