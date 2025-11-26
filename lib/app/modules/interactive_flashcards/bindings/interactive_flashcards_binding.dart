import 'package:get/get.dart';

import '../controllers/interactive_flashcards_controller.dart';

class InteractiveFlashcardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InteractiveFlashcardsController>(
      () => InteractiveFlashcardsController(),
    );
  }
}
