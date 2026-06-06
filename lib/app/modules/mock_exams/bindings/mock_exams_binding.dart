import 'package:get/get.dart';

import '../controllers/mock_exams_controller.dart';

class MockExamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MockExamsController>(
      () => MockExamsController(),
    );
  }
}
