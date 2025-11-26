import 'package:get/get.dart';

import '../modules/category_progress/bindings/category_progress_binding.dart';
import '../modules/category_progress/views/category_progress_view.dart';
import '../modules/continue_learning/bindings/continue_learning_binding.dart';
import '../modules/continue_learning/views/continue_learning_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/spi_practice_bank_and/bindings/spi_practice_bank_and_binding.dart';
import '../modules/spi_practice_bank_and/views/spi_practice_bank_and_view.dart';
import '../modules/spi_practice_bank_qus/bindings/spi_practice_bank_qus_binding.dart';
import '../modules/spi_practice_bank_qus/views/spi_practice_bank_qus_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPI_PRACTICE_BANK_QUS;

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
      name: _Paths.SPI_PRACTICE_BANK_QUS,
      page: () => const SpiPracticeBankQusView(),
      binding: SpiPracticeBankQusBinding(),
    ),
    GetPage(
      name: _Paths.SPI_PRACTICE_BANK_AND,
      page: () => const SpiPracticeBankAndView(),
      binding: SpiPracticeBankAndBinding(),
    ),
    GetPage(
      name: _Paths.CONTINUE_LEARNING,
      page: () => const ContinueLearningView(),
      binding: ContinueLearningBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_PROGRESS,
      page: () => const CategoryProgressView(),
      binding: CategoryProgressBinding(),
    ),
  ];
}
