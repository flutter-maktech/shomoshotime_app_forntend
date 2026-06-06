import 'package:get/get.dart';
import '../controllers/forgot_enter_password_controller.dart';

class ForgotEnterPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotEnterPasswordController>(
      () => ForgotEnterPasswordController(),
    );
  }
}
