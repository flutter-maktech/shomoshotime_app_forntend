class UserNotification {
  final int id;
  final String title;
  final String message;
  final bool isRead;
  final String createdAtFormatted;

  UserNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAtFormatted,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json['id'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      isRead: json['is_read'] ?? false,
      createdAtFormatted: json['created_at_formatted'] ?? '',
    );
  }

  // ✅ Add this method
  UserNotification copyWith({
    int? id,
    String? title,
    String? message,
    bool? isRead,
    String? createdAtFormatted,
  }) {
    return UserNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAtFormatted: createdAtFormatted ?? this.createdAtFormatted,
    );
  }
}

