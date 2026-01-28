import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';
import 'package:shomoshotime/app/modules/mock_exams/controllers/mock_exams_controller.dart';
import 'package:shomoshotime/app/modules/practice/controllers/practice_controller.dart';

import '../../flash_cards/controllers/flash_cards_controller.dart';
import '../../spi_practice_bank_ans/controllers/spi_practice_bank_ans_controller.dart';
import '../../spi_practice_bank_qus/controllers/spi_practice_bank_qus_controller.dart';
import '../../notification/controllers/notification_controller.dart';
import '../../study_guides/controllers/study_guides_controller.dart';
import '../controllers/custom_bottom_navigation_bar_controller.dart';

class CustomBottomNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CustomBottomNavigationBarController>(
      CustomBottomNavigationBarController(),
      permanent: true,
    );

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut(() => StudyGuidesController());
    Get.lazyPut(() => FlashCardsController());
    Get.lazyPut(() => PracticeController());
    Get.lazyPut(() => MockExamsController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => SpiPracticeBankQusController());
    Get.lazyPut(() => SpiPracticeBankAnsController());
  }
}
