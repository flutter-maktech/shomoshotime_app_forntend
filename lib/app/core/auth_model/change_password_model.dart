class ChangePasswordModel {
  final String oldPassword;
  final String password;
  final String passwordConfirmation;

  ChangePasswordModel({
    required this.oldPassword,
    required this.password,
    required this.passwordConfirmation,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      oldPassword: json['old_password'] ?? '',
      password: json['password'] ?? '',
      passwordConfirmation: json['password_confirmation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "old_password": oldPassword,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }

  @override
  String toString() {
    return 'ChangePasswordModel(oldPassword: $oldPassword, password: $password, passwordConfirmation: $passwordConfirmation)';
  }
}
