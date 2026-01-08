import 'package:get/get.dart';

import '../controllers/forgot_enter_email_controller.dart';

class ForgotEnterEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotEnterEmailController>(
      () => ForgotEnterEmailController(),
    );
  }
}
