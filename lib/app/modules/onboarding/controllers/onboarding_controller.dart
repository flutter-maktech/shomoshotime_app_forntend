import 'package:get/get.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  var currentIndex = 0.obs;

  final images = [
    ImagePath.comprehensiveStudy,
    ImagePath.interactive,
    ImagePath.practice,
    ImagePath.realistic,
  ];

  final titles = [
    'Comprehensive Study Guides',
    'Interactive Flashcards',
    'Practice Questions',
    'Realistic Mock Exams',
  ];

  final subtitles = [
    'Access detailed study materials for SPI, Vascular, OB/GYN, and Abdomen specialties',
    'Master key concepts with our smart flashcard system and track your progress.',
    'Test your knowledge With thousands of practic Questions',
    'Simulate the real exam experience and build your confidence',
  ];

  void nextSlide() {
    if (currentIndex < 3) {
      currentIndex++;
    } else {
      // Last slide → Move to check premium status
      Get.offAllNamed(Routes.APP_GATE);
    }
  }
}
