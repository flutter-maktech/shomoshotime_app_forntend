import 'package:get/get.dart';

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

  static const INITIAL = Routes.HOME;

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
  ];
}
