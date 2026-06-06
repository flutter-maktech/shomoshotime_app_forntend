import 'package:get/get.dart';

import '../controllers/category_progress_controller.dart';

class CategoryProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryProgressController>(
      () => CategoryProgressController(),
    );
  }
}
