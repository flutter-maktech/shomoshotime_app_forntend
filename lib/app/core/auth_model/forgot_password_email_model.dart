class ForgotPasswordEmailModel {
  final String email;

  ForgotPasswordEmailModel({
    required this.email,
  });

  factory ForgotPasswordEmailModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordEmailModel(
      email: json['email'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }

  @override
  String toString() {
    return 'ForgotPasswordEmailModel(email: $email)';
  }
}
