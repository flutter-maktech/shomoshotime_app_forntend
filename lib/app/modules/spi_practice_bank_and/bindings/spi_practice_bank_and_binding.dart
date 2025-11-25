import 'package:get/get.dart';

import '../controllers/spi_practice_bank_and_controller.dart';

class SpiPracticeBankAndBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpiPracticeBankAndController>(
      () => SpiPracticeBankAndController(),
    );
  }
}
