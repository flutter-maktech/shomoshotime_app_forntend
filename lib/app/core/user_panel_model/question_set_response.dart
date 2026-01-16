// question_set_response.dart

class QuestionSetResponse {
  final bool success;
  final String message;
  final List<QuestionSetData> data;
  final Links links;
  final Meta meta;

  QuestionSetResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.links,
    required this.meta,
  });

  factory QuestionSetResponse.fromJson(Map<String, dynamic> json) {
    return QuestionSetResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<QuestionSetData>.from(
              json['data'].map((x) => QuestionSetData.fromJson(x)),
            )
          : [],
      links: json['links'] != null ? Links.fromJson(json['links']) : Links(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : Meta(),
    );
  }

  // Map<String, dynamic> toJson() => {
  //   'success': success,
  //   'message': message,
  //   'data': data.map((x) => x.toJson()).toList(),
  //   'links': links.toJson(),
  //   'meta': meta.toJson(),
  // };
}

class QuestionSetData {
  final int id;
  final int sortOrder;
  final String category;
  final String title;
  final String subtitle;
  final int status;
  final String statusLabel;
  final List<String> statusData;
  final String statusColor;
  final int totalQuestions;

  // ✅ NEW (safe additions)
  final List<QuestionAnswer> questionAnswers;
  final List<QuestionAnalytics> analytics;

  final String createdAt;
  final String updatedAt;
  final String createrName;
  final String updaterName;

  QuestionSetData({
    required this.id,
    required this.sortOrder,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusLabel,
    required this.statusData,
    required this.statusColor,
    required this.totalQuestions,
    required this.questionAnswers,
    required this.analytics,
    required this.createdAt,
    required this.updatedAt,
    required this.createrName,
    required this.updaterName,
  });

  factory QuestionSetData.fromJson(Map<String, dynamic> json) {
    return QuestionSetData(
      id: json['id'] ?? 0,
      sortOrder: json['sort_order'] ?? 0,
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      status: json['status'] ?? 0,
      statusLabel: json['status_label'] ?? '',
      statusData: List<String>.from(json['status_data'] ?? []),
      statusColor: json['status_color'] ?? '',
      totalQuestions: json['total_questions'] ?? 0,

      // ✅ NEW (won’t break old UI)
      questionAnswers:
          (json['questionAnswers'] as List?)
              ?.map((e) => QuestionAnswer.fromJson(e))
              .toList() ??
          [],
      analytics:
          (json['analytics'] as List?)
              ?.map((e) => QuestionAnalytics.fromJson(e))
              .toList() ??
          [],

      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createrName: json['creater_name'] ?? '',
      updaterName: json['updater_name'] ?? '',
    );
  }
}

class QuestionAnswer {
  final int id;
  final int questionId;
  final int questionSetId;
  final int userId;
  final PracticeStats? practice;
  final MockTestStats? mockTest;
  final String lastMode;
  final String lastAnswer;
  final bool isFirstTime;
  final String createdAt;
  final String updatedAt;

  QuestionAnswer({
    required this.id,
    required this.questionId,
    required this.questionSetId,
    required this.userId,
    this.practice,
    this.mockTest,
    required this.lastMode,
    required this.lastAnswer,
    required this.isFirstTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAnswer(
      id: json['id'] ?? 0,
      questionId: json['question_id'] ?? 0,
      questionSetId: json['question_set_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      practice: json['practice'] != null
          ? PracticeStats.fromJson(json['practice'])
          : null,
      mockTest: json['mock_test'] != null
          ? MockTestStats.fromJson(json['mock_test'])
          : null,
      lastMode: json['last_mode'] ?? '',
      lastAnswer: json['last_answer'] ?? '',
      isFirstTime: json['is_first_time'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class PracticeStats {
  final int correctAttempts;
  final int failedAttempts;
  final int totalAttempts;
  final num accuracy;
  final String lastAnswer;
  final String firstAnsweredAt;

  PracticeStats({
    required this.correctAttempts,
    required this.failedAttempts,
    required this.totalAttempts,
    required this.accuracy,
    required this.lastAnswer,
    required this.firstAnsweredAt,
  });

  factory PracticeStats.fromJson(Map<String, dynamic> json) {
    return PracticeStats(
      correctAttempts: json['correct_attempts'] ?? 0,
      failedAttempts: json['failed_attempts'] ?? 0,
      totalAttempts: json['total_attempts'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
      lastAnswer: json['last_answer'] ?? '',
      firstAnsweredAt: json['first_answered_at'] ?? '',
    );
  }
}

class MockTestStats {
  final int correctAttempts;
  final int failedAttempts;
  final int totalAttempts;
  final num accuracy;
  final int lastAttemptNumber;

  MockTestStats({
    required this.correctAttempts,
    required this.failedAttempts,
    required this.totalAttempts,
    required this.accuracy,
    required this.lastAttemptNumber,
  });

  factory MockTestStats.fromJson(Map<String, dynamic> json) {
    return MockTestStats(
      correctAttempts: json['correct_attempts'] ?? 0,
      failedAttempts: json['failed_attempts'] ?? 0,
      totalAttempts: json['total_attempts'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
      lastAttemptNumber: json['last_attempt_number'] ?? 0,
    );
  }
}

class QuestionAnalytics {
  final int id;
  final int questionSetId;
  final String currentMode;
  final bool isPracticeMode;
  final bool isMockTestMode;
  final PracticeProgress? practice;
  final MockTestProgress? mockTest;

  QuestionAnalytics({
    required this.id,
    required this.questionSetId,
    required this.currentMode,
    required this.isPracticeMode,
    required this.isMockTestMode,
    this.practice,
    this.mockTest,
  });

  factory QuestionAnalytics.fromJson(Map<String, dynamic> json) {
    return QuestionAnalytics(
      id: json['id'] ?? 0,
      questionSetId: json['question_set_id'] ?? 0,
      currentMode: json['current_mode'] ?? '',
      isPracticeMode: json['is_practice_mode'] ?? false,
      isMockTestMode: json['is_mock_test_mode'] ?? false,
      practice: json['practice'] != null
          ? PracticeProgress.fromJson(json['practice'])
          : null,
      mockTest: json['mock_test'] != null
          ? MockTestProgress.fromJson(json['mock_test'])
          : null,
    );
  }
}
class PracticeProgress {
  final int questionsAnswered;
  final int correctAnswers;
  final bool completed;
  final num progressPercentage;
  final num accuracy;
  final String? completedAt;

  PracticeProgress({
    required this.questionsAnswered,
    required this.correctAnswers,
    required this.completed,
    required this.progressPercentage,
    required this.accuracy,
    this.completedAt,
  });

  factory PracticeProgress.fromJson(Map<String, dynamic> json) {
    return PracticeProgress(
      questionsAnswered: json['questions_answered'] ?? 0,
      correctAnswers: json['correct_answers'] ?? 0,
      completed: json['completed'] ?? false,
      progressPercentage: json['progress_percentage'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
      completedAt: json['completed_at'],
    );
  }
}
class MockTestProgress {
  final int totalAttempts;
  final int remainingAttempts;
  final bool canStart;
  final bool hasCompletedAll;
  final int bestScore;
  final num bestPercentage;
  final int currentAttemptNumber;
  final int currentQuestionsAnswered;
  final bool isInProgress;

  MockTestProgress({
    required this.totalAttempts,
    required this.remainingAttempts,
    required this.canStart,
    required this.hasCompletedAll,
    required this.bestScore,
    required this.bestPercentage,
    required this.currentAttemptNumber,
    required this.currentQuestionsAnswered,
    required this.isInProgress,
  });

  factory MockTestProgress.fromJson(Map<String, dynamic> json) {
    return MockTestProgress(
      totalAttempts: json['total_attempts'] ?? 0,
      remainingAttempts: json['remaining_attempts'] ?? 0,
      canStart: json['can_start'] ?? false,
      hasCompletedAll: json['has_completed_all'] ?? false,
      bestScore: json['best_score'] ?? 0,
      bestPercentage: json['best_percentage'] ?? 0,
      currentAttemptNumber: json['current_attempt_number'] ?? 0,
      currentQuestionsAnswered:
          json['current_questions_answered'] ?? 0,
      isInProgress: json['is_in_progress'] ?? false,
    );
  }
}

class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() => {
    'first': first,
    'last': last,
    'prev': prev,
    'next': next,
  };
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<MetaLink> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta({
    this.currentPage = 0,
    this.from = 0,
    this.lastPage = 0,
    this.links = const [],
    this.path = '',
    this.perPage = 0,
    this.to = 0,
    this.total = 0,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'] ?? 0,
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      links: json['links'] != null
          ? List<MetaLink>.from(json['links'].map((x) => MetaLink.fromJson(x)))
          : [],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 0,
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'from': from,
    'last_page': lastPage,
    'links': links.map((x) => x.toJson()).toList(),
    'path': path,
    'per_page': perPage,
    'to': to,
    'total': total,
  };
}

class MetaLink {
  final String? url;
  final String? label;
  final int? page;
  final bool active;

  MetaLink({this.url, this.label, this.page, this.active = false});

  factory MetaLink.fromJson(Map<String, dynamic> json) {
    return MetaLink(
      url: json['url'],
      label: json['label'],
      page: json['page'],
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'label': label,
    'page': page,
    'active': active,
  };
}
