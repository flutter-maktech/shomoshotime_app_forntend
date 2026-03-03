import 'package:get/get.dart';

import '../modules/about_us/bindings/about_us_binding.dart';
import '../modules/about_us/views/about_us_view.dart';
import '../modules/add_card/bindings/add_card_binding.dart';
import '../modules/add_card/views/add_card_view.dart';
import '../modules/app_gate/bindings/app_gate_binding.dart';
import '../modules/app_gate/views/app_gate_view.dart';
import '../modules/audio_play_card/bindings/audio_play_card_binding.dart';
import '../modules/audio_play_card/views/audio_play_card_view.dart';
import '../modules/category_progress/bindings/category_progress_binding.dart';
import '../modules/category_progress/views/category_progress_view.dart';
import '../modules/continue_learning/bindings/continue_learning_binding.dart';
import '../modules/continue_learning/views/continue_learning_view.dart';
import '../modules/custom_bottom_navigation_bar/bindings/custom_bottom_navigation_bar_binding.dart';
import '../modules/custom_bottom_navigation_bar/views/custom_bottom_navigation_bar_view.dart';
import '../modules/delete_account/bindings/delete_account_binding.dart';
import '../modules/delete_account/views/delete_account_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/explore_plan/bindings/explore_plan_binding.dart';
import '../modules/explore_plan/views/explore_plan_view.dart';
import '../modules/flash_cards/bindings/flash_cards_binding.dart';
import '../modules/flash_cards/views/flash_cards_view.dart';
import '../modules/forgot_enter_code/bindings/forgot_enter_code_binding.dart';
import '../modules/forgot_enter_code/views/forgot_enter_code_view.dart';
import '../modules/forgot_enter_email/bindings/forgot_enter_email_binding.dart';
import '../modules/forgot_enter_email/views/forgot_enter_email_view.dart';
import '../modules/forgot_enter_password/bindings/forgot_enter_password_binding.dart';
import '../modules/forgot_enter_password/views/forgot_enter_password_view.dart';
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
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/session_expired/bindings/session_expired_binding.dart';
import '../modules/session_expired/views/session_expired_view.dart';
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
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/study_guides/bindings/study_guides_binding.dart';
import '../modules/study_guides/views/study_guides_view.dart';
import '../modules/subscription_plan/bindings/subscription_plan_binding.dart';
import '../modules/subscription_plan/views/subscription_plan_view.dart';
import '../modules/terms_and_conditions/bindings/terms_and_conditions_binding.dart';
import '../modules/terms_and_conditions/views/terms_and_conditions_view.dart';
import '../modules/vascular_flashcards/bindings/vascular_flashcards_binding.dart';
import '../modules/vascular_flashcards/views/vascular_flashcards_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.customBottomNavigationBar,
      page: () => const CustomBottomNavigationBarView(),
      binding: CustomBottomNavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.studyGuides,
      page: () => StudyGuidesView(),
      binding: StudyGuidesBinding(),
    ),
    GetPage(
      name: _Paths.spiFundamentals,
      page: () => const SpiFundamentalsView(),
      binding: SpiFundamentalsBinding(),
    ),
    GetPage(
      name: _Paths.flashCards,
      page: () => const FlashCardsView(),
      binding: FlashCardsBinding(),
    ),
    GetPage(
      name: _Paths.vascularFlashcards,
      page: () => const VascularFlashcardsView(),
      binding: VascularFlashcardsBinding(),
    ),
    GetPage(
      name: _Paths.audioPlayCard,
      page: () => const AudioPlayCardView(),
      binding: AudioPlayCardBinding(),
    ),
    GetPage(
      name: _Paths.practice,
      page: () => const PracticeView(),
      binding: PracticeBinding(),
    ),
    GetPage(
      name: _Paths.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.subscriptionPlan,
      page: () => const SubscriptionPlanView(),
      binding: SubscriptionPlanBinding(),
    ),
    GetPage(
      name: _Paths.paymentMethods,
      page: () => const PaymentMethodsView(),
      binding: PaymentMethodsBinding(),
    ),
    GetPage(
      name: _Paths.addCard,
      page: () => const AddCardView(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: _Paths.spiPracticeBankQus,
      page: () => const SpiPracticeBankQusView(),
      binding: SpiPracticeBankQusBinding(),
    ),
    GetPage(
      name: _Paths.spiPracticeBankAns,
      page: () => const SpiPracticeBankAnsView(),
      binding: SpiPracticeBankAnsBinding(),
    ),
    GetPage(
      name: _Paths.continueLearning,
      page: () => const ContinueLearningView(),
      binding: ContinueLearningBinding(),
    ),
    GetPage(
      name: _Paths.categoryProgress,
      page: () => const CategoryProgressView(),
      binding: CategoryProgressBinding(),
    ),
    GetPage(
      name: _Paths.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.signUp,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.signUpOtp,
      page: () => const SignUpOtpView(),
      binding: SignUpOtpBinding(),
    ),
    GetPage(
      name: _Paths.mockExams,
      page: () => const MockExamsView(),
      binding: MockExamsBinding(),
    ),
    GetPage(
      name: _Paths.notification,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.forgotEnterCode,
      page: () => const ForgotEnterCodeView(),
      binding: ForgotEnterCodeBinding(),
    ),
    GetPage(
      name: _Paths.forgotEnterEmail,
      page: () => const ForgotEnterEmailView(),
      binding: ForgotEnterEmailBinding(),
    ),
    GetPage(
      name: _Paths.forgotEnterPassword,
      page: () => const ForgotEnterPasswordView(),
      binding: ForgotEnterPasswordBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.explorePlan,
      page: () => const ExplorePlanView(),
      binding: ExplorePlanBinding(),
    ),
    GetPage(
      name: _Paths.appGate,
      page: () => const AppGateView(),
      binding: AppGateBinding(),
    ),
    GetPage(
      name: _Paths.sessionExpired,
      page: () => const SessionExpiredView(),
      binding: SessionExpiredBinding(),
    ),
    GetPage(
      name: _Paths.termsAndConditions,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.aboutUs,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.privacyPolicy,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.deleteAccount,
      page: () => const DeleteAccountView(),
      binding: DeleteAccountBinding(),
    ),
  ];
}
