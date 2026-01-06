class ResentOtpModel {
  final int otp;

  ResentOtpModel({
    required this.otp,
  });

  factory ResentOtpModel.fromJson(Map<String, dynamic> json) {
    return ResentOtpModel(
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
    return 'ResentOtpModel(otp: $otp)';
  }
}
