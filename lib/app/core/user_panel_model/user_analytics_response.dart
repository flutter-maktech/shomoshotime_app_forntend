// user_analytics_response.dart

class UserAnalyticsResponse {
  final bool success;
  final String message;
  final UserAnalyticsData data;

  UserAnalyticsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserAnalyticsResponse.fromJson(Map<String, dynamic> json) {
    return UserAnalyticsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? UserAnalyticsData.fromJson(json['data'])
          : UserAnalyticsData.empty(),
    );
  }
}

class UserAnalyticsData {
  final StudyAnalytics studyAnalytics;
  final FlashcardAnalytics flashcardAnalytics;
  final num practiceAccuracy;
  final num mocktestAccuracy;
  final num practiceProgress;
  final num mocktestProgress;

  UserAnalyticsData({
    required this.studyAnalytics,
    required this.flashcardAnalytics,
    required this.practiceAccuracy,
    required this.mocktestAccuracy,
    required this.practiceProgress,
    required this.mocktestProgress,
  });

  factory UserAnalyticsData.fromJson(Map<String, dynamic> json) {
    return UserAnalyticsData(
      studyAnalytics: json['studyAnalytics'] != null
          ? StudyAnalytics.fromJson(json['studyAnalytics'])
          : StudyAnalytics.empty(),
      flashcardAnalytics: json['flashcardAnalytics'] != null
          ? FlashcardAnalytics.fromJson(json['flashcardAnalytics'])
          : FlashcardAnalytics.empty(),
      practiceAccuracy: json['practiceAccuracy'] ?? 0,
      mocktestAccuracy: json['mocktestAccuracy'] ?? 0,
      practiceProgress: json['practiceProgress'] ?? 0,
      mocktestProgress: json['mocktestProgress'] ?? 0,
    );
  }

  factory UserAnalyticsData.empty() => UserAnalyticsData(
        studyAnalytics: StudyAnalytics.empty(),
        flashcardAnalytics: FlashcardAnalytics.empty(),
        practiceAccuracy: 0,
        mocktestAccuracy: 0,
        practiceProgress: 0,
        mocktestProgress: 0,
      );
}

class StudyAnalytics {
  final int attemptedPages;
  final int totalPages;
  final double progressPercent;

  StudyAnalytics({
    required this.attemptedPages,
    required this.totalPages,
    required this.progressPercent,
  });

  factory StudyAnalytics.fromJson(Map<String, dynamic> json) {
    return StudyAnalytics(
      attemptedPages: json['attempted_pages'] ?? 0,
      totalPages: int.tryParse(json['total_pages'].toString()) ?? 0,
      progressPercent:
          (json['progress_percent'] ?? 0).toDouble(),
    );
  }

  factory StudyAnalytics.empty() => StudyAnalytics(
        attemptedPages: 0,
        totalPages: 0,
        progressPercent: 0,
      );
}

class FlashcardAnalytics {
  final int attemptedCards;
  final int totalCards;
  final double progressPercent;

  FlashcardAnalytics({
    required this.attemptedCards,
    required this.totalCards,
    required this.progressPercent,
  });

  factory FlashcardAnalytics.fromJson(Map<String, dynamic> json) {
    return FlashcardAnalytics(
      attemptedCards: json['attempted_cards'] ?? 0,
      totalCards: json['total_cards'] ?? 0,
      progressPercent:
          (json['progress_percent'] ?? 0).toDouble(),
    );
  }

  factory FlashcardAnalytics.empty() => FlashcardAnalytics(
        attemptedCards: 0,
        totalCards: 0,
        progressPercent: 0,
      );
}
