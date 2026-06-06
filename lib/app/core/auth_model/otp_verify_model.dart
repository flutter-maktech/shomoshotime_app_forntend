class OtpVerifyModel {
  final int otp;

  OtpVerifyModel({
    required this.otp,
  });

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    return OtpVerifyModel(
      otp: json['otp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
    };
  }

  @override
  String toString() {
    return 'OtpVerifyModel(otp: $otp)';
  }
}
