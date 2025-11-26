import 'package:get/get.dart';

import '../controllers/study_guides_controller.dart';

class StudyGuidesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudyGuidesController>(
      () => StudyGuidesController(),
    );
  }
}
