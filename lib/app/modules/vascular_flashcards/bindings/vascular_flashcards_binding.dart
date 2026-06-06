import 'package:get/get.dart';

import '../controllers/vascular_flashcards_controller.dart';

class VascularFlashcardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlashcardsSetController>(() => FlashcardsSetController());
  }
}
