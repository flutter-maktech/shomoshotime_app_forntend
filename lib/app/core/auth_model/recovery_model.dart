class RecoveryModel {
  String email;

  RecoveryModel({required this.email});

  factory RecoveryModel.fromJson(Map<String, dynamic> json) {
    return RecoveryModel(
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  @override
  String toString() {
    return 'RecoveryModel(email: $email)';
  }
}
