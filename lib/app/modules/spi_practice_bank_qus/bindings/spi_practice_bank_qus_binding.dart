import 'package:get/get.dart';

import '../controllers/spi_practice_bank_qus_controller.dart';

class SpiPracticeBankQusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpiPracticeBankQusController>(
      () => SpiPracticeBankQusController(),
    );
  }
}
