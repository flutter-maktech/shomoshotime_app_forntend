import 'package:get/get.dart';

import '../controllers/spi_practice_bank_ans_controller.dart';

class SpiPracticeBankAnsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpiPracticeBankAnsController>(
      () => SpiPracticeBankAnsController(),
    );
  }
}
