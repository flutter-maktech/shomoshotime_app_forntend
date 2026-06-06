import 'package:get/get.dart';

import '../controllers/explore_plan_controller.dart';

class ExplorePlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExplorePlanController>(
      () => ExplorePlanController(),
    );
  }
}
