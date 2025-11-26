import 'package:get/get.dart';

import '../modules/comprehensive/bindings/comprehensive_binding.dart';
import '../modules/comprehensive/views/comprehensive_view.dart';
import '../modules/enter_code/bindings/enter_code_binding.dart';
import '../modules/enter_code/views/enter_code_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/forgot_password_2/bindings/forgot_password_2_binding.dart';
import '../modules/forgot_password_2/views/forgot_password_2_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/interactive_flashcards/bindings/interactive_flashcards_binding.dart';
import '../modules/interactive_flashcards/views/interactive_flashcards_view.dart';
import '../modules/practice/bindings/practice_binding.dart';
import '../modules/practice/views/practice_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/realistic/bindings/realistic_binding.dart';
import '../modules/realistic/views/realistic_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/sign_up_otp/bindings/sign_up_otp_binding.dart';
import '../modules/sign_up_otp/views/sign_up_otp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN;

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
      name: _Paths.COMPREHENSIVE,
      page: () => const ComprehensiveView(),
      binding: ComprehensiveBinding(),
    ),
    GetPage(
      name: _Paths.INTERACTIVE_FLASHCARDS,
      page: () => const InteractiveFlashcardsView(),
      binding: InteractiveFlashcardsBinding(),
    ),
    GetPage(
      name: _Paths.PRACTICE,
      page: () => const PracticeView(),
      binding: PracticeBinding(),
    ),
    GetPage(
      name: _Paths.REALISTIC,
      page: () => const RealisticView(),
      binding: RealisticBinding(),
    ),
  ];
}
