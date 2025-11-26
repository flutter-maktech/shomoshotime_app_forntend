import 'package:get/get.dart';

import '../controllers/comprehensive_controller.dart';

class ComprehensiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComprehensiveController>(
      () => ComprehensiveController(),
    );
  }
}
