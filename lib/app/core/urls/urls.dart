class Urls {

 static String baseUrs = "http://127.0.0.1:8000/api/v1";
 static String signUpUrl = "$baseUrs/auth/register";
 static String logInUrl = "$baseUrs/auth/login";
 static String otpUrl = "$baseUrs/auth/verify-otp";
 static String resendOtpUrl = "$baseUrs/auth/resend-otp";
 static String changePasswordUrl = "$baseUrs/auth/change-password";
 static String forgotPasswordUrl = "$baseUrs/auth/forgot-password";
 static String forgotResendOtpUrl = "$baseUrs/auth/forgot-resend-otp";
 static String forgotVerifyOtpUrl = "$baseUrs/auth/forgot-verify-otp";
 static String resetPasswordUrl = "$baseUrs/auth/reset-password";

}
