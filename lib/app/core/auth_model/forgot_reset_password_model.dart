class ForgotResetPasswordModel {
  final String token;
  final String email;
  final String password;
  final String passwordConfirmation;

  ForgotResetPasswordModel({
    required this.token,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  factory ForgotResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotResetPasswordModel(
      token: json['token'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      passwordConfirmation: json['password_confirmation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }

  @override
  String toString() {
    return 'ForgotResetPasswordModel(token: $token, email: $email, password: $password, passwordConfirmation: $passwordConfirmation)';
  }
}
