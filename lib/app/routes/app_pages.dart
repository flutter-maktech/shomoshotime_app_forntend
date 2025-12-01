import 'package:get/get.dart';

import '../modules/custom_bottom_navigation_bar/bindings/custom_bottom_navigation_bar_binding.dart';
import '../modules/custom_bottom_navigation_bar/views/custom_bottom_navigation_bar_view.dart';
import '../modules/audio_play_card/bindings/audio_play_card_binding.dart';
import '../modules/audio_play_card/views/audio_play_card_view.dart';
import '../modules/flash_cards/bindings/flash_cards_binding.dart';
import '../modules/flash_cards/views/flash_cards_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/practice/bindings/practice_binding.dart';
import '../modules/practice/views/practice_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/spi_fundamentals/bindings/spi_fundamentals_binding.dart';
import '../modules/spi_fundamentals/views/spi_fundamentals_view.dart';
import '../modules/study_guides/bindings/study_guides_binding.dart';
import '../modules/study_guides/views/study_guides_view.dart';
import '../modules/vascular_flashcards/bindings/vascular_flashcards_binding.dart';
import '../modules/vascular_flashcards/views/vascular_flashcards_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.STUDY_GUIDES;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_BOTTOM_NAVIGATION_BAR,
      page: () => const CustomBottomNavigationBarView(),
      binding: CustomBottomNavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.STUDY_GUIDES,
      page: () => StudyGuidesView(),
      binding: StudyGuidesBinding(),
    ),
    GetPage(
      name: _Paths.SPI_FUNDAMENTALS,
      page: () => const SpiFundamentalsView(),
      binding: SpiFundamentalsBinding(),
    ),
    GetPage(
      name: _Paths.FLASH_CARDS,
      page: () => const FlashCardsView(),
      binding: FlashCardsBinding(),
    ),
    GetPage(
      name: _Paths.VASCULAR_FLASHCARDS,
      page: () => const VascularFlashcardsView(),
      binding: VascularFlashcardsBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO_PLAY_CARD,
      page: () => const AudioPlayCardView(),
      binding: AudioPlayCardBinding(),
    ),
    GetPage(
      name: _Paths.PRACTICE,
      page: () => const PracticeView(),
      binding: PracticeBinding(),
    ),
  ];
}
