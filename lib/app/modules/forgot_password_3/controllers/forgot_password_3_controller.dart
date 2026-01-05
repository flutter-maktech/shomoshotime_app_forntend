import 'package:get/get.dart';

class ForgotPassword3Controller extends GetxController {
  RxBool isVisibleAddPass = true.obs;
  RxBool isVisibleConfirmPass = true.obs;

  void isVisibleAddPassOnTap() {
    isVisibleAddPass.value = !isVisibleAddPass.value;
  }

  void isVisibleConfirmPassOnTap() {
    isVisibleConfirmPass.value = !isVisibleConfirmPass.value;
  }
}
