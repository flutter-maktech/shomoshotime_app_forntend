import 'package:get/get.dart';
import '../modules/category_progress/bindings/category_progress_binding.dart';
import '../modules/category_progress/views/category_progress_view.dart';
import '../modules/continue_learning/bindings/continue_learning_binding.dart';
import '../modules/continue_learning/views/continue_learning_view.dart';
import '../modules/add_card/bindings/add_card_binding.dart';
import '../modules/add_card/views/add_card_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/custom_bottom_navigation_bar/bindings/custom_bottom_navigation_bar_binding.dart';
import '../modules/custom_bottom_navigation_bar/views/custom_bottom_navigation_bar_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/payment_methods/bindings/payment_methods_binding.dart';
import '../modules/payment_methods/views/payment_methods_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/spi_practice_bank_ans/bindings/spi_practice_bank_ans_binding.dart';
import '../modules/spi_practice_bank_ans/views/spi_practice_bank_ans_view.dart';
import '../modules/spi_practice_bank_qus/bindings/spi_practice_bank_qus_binding.dart';
import '../modules/spi_practice_bank_qus/views/spi_practice_bank_qus_view.dart';
import '../modules/subscription_plan/bindings/subscription_plan_binding.dart';
import '../modules/subscription_plan/views/subscription_plan_view.dart';

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
      name: _Paths.CUSTOM_BOTTOM_NAVIGATION_BAR,
      page: () => const CustomBottomNavigationBarView(),
      binding: CustomBottomNavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION_PLAN,
      page: () => const SubscriptionPlanView(),
      binding: SubscriptionPlanBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHODS,
      page: () => const PaymentMethodsView(),
      binding: PaymentMethodsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CARD,
      page: () => const AddCardView(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: _Paths.SPI_PRACTICE_BANK_QUS,
      page: () => const SpiPracticeBankQusView(),
      binding: SpiPracticeBankQusBinding(),
    ),
    GetPage(
      name: _Paths.SPI_PRACTICE_BANK_ANS,
      page: () => const SpiPracticeBankAnsView(),
      binding: SpiPracticeBankAnsBinding(),
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
