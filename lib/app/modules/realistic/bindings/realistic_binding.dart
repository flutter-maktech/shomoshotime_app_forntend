import 'package:get/get.dart';

import '../controllers/realistic_controller.dart';

class RealisticBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RealisticController>(
      () => RealisticController(),
    );
  }
}
