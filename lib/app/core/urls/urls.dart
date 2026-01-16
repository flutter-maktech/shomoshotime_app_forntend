class Urls {
  static String baseUrs = "https://shomoshotime.mtscorporate.com/api/v1";
  static String baseDomain = "https://shomoshotime.mtscorporate.com";

  static String signUpUrl = "$baseUrs/auth/register";
  static String logInUrl = "$baseUrs/auth/login";
  static String verifyOtp = "$baseUrs/auth/verify-otp";
  static String resendOtp = "$baseUrs/auth/resend-otp";
  static String changePassword = "$baseUrs/auth/change-password";
  static String forgotPassword = "$baseUrs/auth/forgot-password";
  static String forgotVerifyOtp = "$baseUrs/auth/forgot-verify-otp";
  static String forgotResendOtp = "$baseUrs/auth/forgot-resend-otp";
  static String resetPassword = "$baseUrs/auth/reset-password";
  static String studyGuideList = "$baseUrs/user/content/study-guides";
  static String nextPage = "$baseUrs/user/content/next-page";
  static String flashCardList = "$baseUrs/user/content/flash-cards";
  static String flashCardSetList = "$baseUrs/user/content/flash-cards/sets";
  static String nextFlashCard =
      "$baseUrs/user/content/flash-cards/next-question";
  static String userAnalytics = "$baseUrs/user/userAnalytics";
  static String praciceQuesionSet = "$baseUrs/user/question/sets";
  static String praciceQuesion = "$baseUrs/user/question/sets/questions";
  static String answerSubmit = "$baseUrs/user/question/submit-answer";
}
