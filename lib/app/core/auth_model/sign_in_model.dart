class SignInModel {
  final String email;
  final String password;
  final String fcmToken;

  SignInModel({
    required this.email,
    required this.password,
    required this.fcmToken,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      fcmToken: json['fcm_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "fcm_token": fcmToken,
    };
  }

  @override
  String toString() {
    return 'SignInModel(email: $email, password: $password, fcmToken: $fcmToken)';
  }
}


