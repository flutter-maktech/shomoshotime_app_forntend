class SignupModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final bool? isAdmin;
  final String fcmToken;

  SignupModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    this.isAdmin,
    required this.fcmToken,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      passwordConfirmation: json['password_confirmation'] ?? '',
      isAdmin: json['is_admin'],
      fcmToken: json['fcm_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      if (isAdmin != null) "is_admin": isAdmin,
      "fcm_token": fcmToken,
    };
  }

  @override
  String toString() {
    return 'SignupModel(name: $name, email: $email, password: $password, '
        'passwordConfirmation: $passwordConfirmation, isAdmin: $isAdmin, '
        'fcmToken: $fcmToken)';
  }
}
