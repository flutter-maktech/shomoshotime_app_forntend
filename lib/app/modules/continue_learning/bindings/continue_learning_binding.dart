import 'package:get/get.dart';

import '../controllers/continue_learning_controller.dart';

class ContinueLearningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContinueLearningController>(
      () => ContinueLearningController(),
    );
  }
}
