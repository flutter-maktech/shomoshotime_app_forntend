import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';

import '../controllers/custom_bottom_navigation_bar_controller.dart';

class CustomBottomNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomBottomNavigationBarController>(
      () => CustomBottomNavigationBarController(),
    );
  }
}
