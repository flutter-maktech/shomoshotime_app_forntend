import 'package:get/get.dart';

import '../controllers/sign_up_otp_controller.dart';

class SignUpOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpOtpController>(
      () => SignUpOtpController(),
    );
  }
}
