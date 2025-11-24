import 'package:get/get.dart';

import '../controllers/enter_code_controller.dart';

class EnterCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterCodeController>(
      () => EnterCodeController(),
    );
  }
}
