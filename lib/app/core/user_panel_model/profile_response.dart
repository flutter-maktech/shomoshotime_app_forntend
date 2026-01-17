class ProfileResponse {
  final bool success;
  final String message;
  final ProfileData data;

  ProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'],
      message: json['message'],
      data: ProfileData.fromJson(json['data']),
    );
  }
}
class ProfileData {
  final int id;
  final String name;
  final String email;
  final String image;
  final int status;
  final bool isAdmin;
  final String statusLabel;
  final List<String> statusData;
  final String emailVerifiedAt;
  final String lastLoginAt;
  final String createdAt;
  final String updatedAt;
  final String createrName;
  final String updaterName;

  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.status,
    required this.isAdmin,
    required this.statusLabel,
    required this.statusData,
    required this.emailVerifiedAt,
    required this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    required this.createrName,
    required this.updaterName,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      status: json['status'],
      isAdmin: json['is_admin'],
      statusLabel: json['status_label'],
      statusData: List<String>.from(json['status_data']),
      emailVerifiedAt: json['email_verified_at'] ?? '',
      lastLoginAt: json['last_login_at'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createrName: json['creater_name'],
      updaterName: json['updater_name'],
    );
  }
}
