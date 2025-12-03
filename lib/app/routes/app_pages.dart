import 'package:get/get.dart';
import '../modules/add_card/bindings/add_card_binding.dart';
import '../modules/add_card/views/add_card_view.dart';
import '../modules/audio_play_card/bindings/audio_play_card_binding.dart';
import '../modules/audio_play_card/views/audio_play_card_view.dart';
import '../modules/category_progress/bindings/category_progress_binding.dart';
import '../modules/category_progress/views/category_progress_view.dart';
import '../modules/continue_learning/bindings/continue_learning_binding.dart';
import '../modules/continue_learning/views/continue_learning_view.dart';
import '../modules/custom_bottom_navigation_bar/bindings/custom_bottom_navigation_bar_binding.dart';
import '../modules/custom_bottom_navigation_bar/views/custom_bottom_navigation_bar_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/enter_code/bindings/enter_code_binding.dart';
import '../modules/enter_code/views/enter_code_view.dart';
import '../modules/flash_cards/bindings/flash_cards_binding.dart';
import '../modules/flash_cards/views/flash_cards_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/forgot_password_2/bindings/forgot_password_2_binding.dart';
import '../modules/forgot_password_2/views/forgot_password_2_view.dart';
import '../modules/forgot_password_3/bindings/forgot_password_3_binding.dart';
import '../modules/forgot_password_3/views/forgot_password_3_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/mock_exams/bindings/mock_exams_binding.dart';
import '../modules/mock_exams/views/mock_exams_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/payment_methods/bindings/payment_methods_binding.dart';
import '../modules/payment_methods/views/payment_methods_view.dart';
import '../modules/practice/bindings/practice_binding.dart';
import '../modules/practice/views/practice_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/sign_up_otp/bindings/sign_up_otp_binding.dart';
import '../modules/sign_up_otp/views/sign_up_otp_view.dart';
import '../modules/spi_fundamentals/bindings/spi_fundamentals_binding.dart';
import '../modules/spi_fundamentals/views/spi_fundamentals_view.dart';
import '../modules/spi_practice_bank_ans/bindings/spi_practice_bank_ans_binding.dart';
import '../modules/spi_practice_bank_ans/views/spi_practice_bank_ans_view.dart';
import '../modules/spi_practice_bank_qus/bindings/spi_practice_bank_qus_binding.dart';
import '../modules/spi_practice_bank_qus/views/spi_practice_bank_qus_view.dart';
import '../modules/study_guides/bindings/study_guides_binding.dart';
import '../modules/study_guides/views/study_guides_view.dart';
import '../modules/subscription_plan/bindings/subscription_plan_binding.dart';
import '../modules/subscription_plan/views/subscription_plan_view.dart';
import '../modules/vascular_flashcards/bindings/vascular_flashcards_binding.dart';
import '../modules/vascular_flashcards/views/vascular_flashcards_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

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
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ENTER_CODE,
      page: () => const EnterCodeView(),
      binding: EnterCodeBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_2,
      page: () => const ForgotPassword2View(),
      binding: ForgotPassword2Binding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_OTP,
      page: () => const SignUpOtpView(),
      binding: SignUpOtpBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_3,
      page: () => const ForgotPassword3View(),
      binding: ForgotPassword3Binding(),
    ),
    GetPage(
      name: _Paths.MOCK_EXAMS,
      page: () => const MockExamsView(),
      binding: MockExamsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
