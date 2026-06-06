import 'package:get/get.dart';

import '../controllers/spi_fundamentals_controller.dart';

class SpiFundamentalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpiFundamentalsController>(
      () => SpiFundamentalsController(),
    );
  }
}
