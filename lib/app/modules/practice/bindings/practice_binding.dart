import 'package:get/get.dart';
import '../../spi_practice_bank_ans/controllers/spi_practice_bank_ans_controller.dart';

import '../../spi_practice_bank_qus/controllers/spi_practice_bank_qus_controller.dart';
import '../controllers/practice_controller.dart';

class PracticeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PracticeController>(
      () => PracticeController(),
    );
    Get.lazyPut(()=>SpiPracticeBankQusController());
    Get.lazyPut(()=>SpiPracticeBankAnsController());
  }
}
