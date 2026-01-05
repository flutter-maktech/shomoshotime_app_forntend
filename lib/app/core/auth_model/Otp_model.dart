class OTPModel {
  final String email;
  final String otp;

  OTPModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp": otp,
  };
}
