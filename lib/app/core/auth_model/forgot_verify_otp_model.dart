class ForgotVerifyOtpModel {
  final String email;
  final String token;
  final String otp;

  ForgotVerifyOtpModel({
    required this.email,
    required this.token,
    required this.otp,
  });
  factory ForgotVerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return ForgotVerifyOtpModel(
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      otp: json['otp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "token": token,
      "otp": otp,
    };
  }

  @override
  String toString() {
    return 'ForgotVerifyOtpModel(email: $email, token: $token, otp: $otp)';
  }
}
