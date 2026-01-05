class CreatePasswordModel {
  String email;
  String newPassword;

  CreatePasswordModel({
    required this.email,
    required this.newPassword,
  });


  factory CreatePasswordModel.fromJson(Map<String, dynamic> json) {
    return CreatePasswordModel(
      email: json['email'] ?? '',
      newPassword: json['new_password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'new_password': newPassword,
    };
  }

  @override
  String toString() {
    return 'CreatePasswordModel(email: $email, newPassword: $newPassword)';
  }
}
