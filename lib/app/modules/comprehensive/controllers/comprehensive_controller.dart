import 'dart:async';
import 'package:get/get.dart';
import '../../../data/image_path.dart';


class ComprehensiveController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<String> titles = [
    'Elevate Your World.',
    'Beyond First Class.',
    'Live Exceptionally.',
  ];

  final List<String> subtitles = [
    'Supercars that turn heads. Yachts that rule the seas.',
    'Curated Luxury Travel and elite Entertainment for your every desire.',
    'Tailored Lifestyle Services and discreet Professional Support, anytime, anywhere.',
  ];

  final List<String> images = [
    ImagePath.comprehensiveStudy,
    ImagePath.interactive,
  ];

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentIndex.value < images.length - 1) {
        currentIndex.value++;
      } else {
        currentIndex.value = 0;
      }
    });
  }

  /// Stop the auto slide timer
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void onDotTap(int index) {
    stopTimer();
    currentIndex.value = index;
  }

  void onNext() {
    stopTimer();
    if (currentIndex.value < images.length - 1) {
      currentIndex.value++;
    } else {
      // Get.to(() => OnboardingScreen());
    }
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }
}

