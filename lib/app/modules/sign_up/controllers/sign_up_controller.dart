import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  // visibility
  RxBool isVisiblePass = true.obs;
  RxBool isVisibleConfirmPass = true.obs;

  void isVisiblePassOnTap() {
    isVisiblePass.value = !isVisiblePass.value;
  }
  RxBool isVisible = true.obs;

  void isVisibleConfirmPassOnTap() {
    isVisibleConfirmPass.value = !isVisibleConfirmPass.value;
  }


  // validation controller
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();



}
