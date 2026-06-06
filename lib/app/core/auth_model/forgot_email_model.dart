class ForgotEmailModel {
  final String email;

  ForgotEmailModel({
    required this.email,
  });

  factory ForgotEmailModel.fromJson(Map<String, dynamic> json) {
    return ForgotEmailModel(
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
    return 'ForgotEmailModel(email: $email)';
  }
}
