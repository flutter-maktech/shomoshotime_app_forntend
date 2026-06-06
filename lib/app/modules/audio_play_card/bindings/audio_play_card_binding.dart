import 'package:get/get.dart';

import '../controllers/audio_play_card_controller.dart';

class AudioPlayCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioPlayCardController>(
      () => AudioPlayCardController(),
    );
  }
}
