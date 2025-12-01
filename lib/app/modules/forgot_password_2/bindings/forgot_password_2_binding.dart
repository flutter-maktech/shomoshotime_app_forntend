import 'package:get/get.dart';

import '../controllers/forgot_password_2_controller.dart';

class ForgotPassword2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPassword2Controller>(
      () => ForgotPassword2Controller(),
    );
  }
}
