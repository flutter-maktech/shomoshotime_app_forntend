import 'package:get/get.dart';

import '../controllers/forgot_password_3_controller.dart';

class ForgotPassword3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPassword3Controller>(
      () => ForgotPassword3Controller(),
    );
  }
}
