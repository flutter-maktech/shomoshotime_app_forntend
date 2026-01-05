import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ForgotPassword3Controller extends GetxController {

  // visibility
  RxBool isVisibleAddPass = true.obs;
  RxBool isVisibleConfirmPass = true.obs;

  void isVisibleAddPassOnTap() {
    isVisibleAddPass.value = !isVisibleAddPass.value;
  }

  void isVisibleConfirmPassOnTap() {
    isVisibleConfirmPass.value = !isVisibleConfirmPass.value;
  }



  // validation

  final TextEditingController addNewPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  void saveNewPass (){
    final isValid = formKey.currentState!.validate();
    if(isValid){
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }

  @override

  void onClose (){
    addNewPassController.dispose();
    confirmPassController.dispose();
  }


}
