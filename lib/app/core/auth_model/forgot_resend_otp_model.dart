class ForgotResendOtpModel {
  final String token;
  final String email;

  ForgotResendOtpModel({
    required this.token,
    required this.email,
  });

  factory ForgotResendOtpModel.fromJson(Map<String, dynamic> json) {
    return ForgotResendOtpModel(
      token: json['token'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "email": email,
    };
  }

  @override
  String toString() {
    return 'ForgotResendOtpModel(token: $token, email: $email)';
  }
}
