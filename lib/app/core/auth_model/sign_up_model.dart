class SignupModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String authProvider;

  SignupModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.authProvider,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      password: json['password'] ?? '',
      authProvider: json['auth_provider'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "auth_provider": authProvider,
    };
  }

  @override
  String toString() {
    return 'SignupModel(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, password: $password, authProvider: $authProvider)';
  }
}
