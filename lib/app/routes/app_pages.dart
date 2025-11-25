import 'package:get/get.dart';

import '../modules/flash_cards/bindings/flash_cards_binding.dart';
import '../modules/flash_cards/views/flash_cards_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/spi_fundamentals/bindings/spi_fundamentals_binding.dart';
import '../modules/spi_fundamentals/views/spi_fundamentals_view.dart';
import '../modules/study_guides/bindings/study_guides_binding.dart';
import '../modules/study_guides/views/study_guides_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPI_FUNDAMENTALS;

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
      name: _Paths.STUDY_GUIDES,
      page: () => const StudyGuidesView(),
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
  ];
}
