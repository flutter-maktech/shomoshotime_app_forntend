class QuestionListResponse {
  final bool success;
  final String message;
  final List<QuestionData> data;
  final Links links;
  final Meta meta;

  QuestionListResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.links,
    required this.meta,
  });

  factory QuestionListResponse.fromJson(Map<String, dynamic> json) {
    return QuestionListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)
              ?.map((e) => QuestionData.fromJson(e))
              .toList() ??
          [],
      links: Links.fromJson(json['links'] ?? {}),
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }
}
class QuestionData {
  final int id;
  final int sortOrder;
  final int questionSetId;
  final String file;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String answer;
  final QuestionSet questionSet;
  final String createdAt;
  final String updatedAt;
  final String createrName;
  final String updaterName;

  QuestionData({
    required this.id,
    required this.sortOrder,
    required this.questionSetId,
    required this.file,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.answer,
    required this.questionSet,
    required this.createdAt,
    required this.updatedAt,
    required this.createrName,
    required this.updaterName,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json['id'] ?? 0,
      sortOrder: json['sort_order'] ?? 0,
      questionSetId: json['question_set_id'] ?? 0,
      file: json['file'] ?? '',
      question: json['question'] ?? '',
      optionA: json['option_a'] ?? '',
      optionB: json['option_b'] ?? '',
      optionC: json['option_c'] ?? '',
      optionD: json['option_d'] ?? '',
      answer: json['answer'] ?? '',
      questionSet: QuestionSet.fromJson(json['questionSet'] ?? {}),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createrName: json['creater_name'] ?? '',
      updaterName: json['updater_name'] ?? '',
    );
  }
}
class QuestionSet {
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
  final String createdAt;
  final String updatedAt;
  final String createrName;
  final String updaterName;

  QuestionSet({
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
    required this.createdAt,
    required this.updatedAt,
    required this.createrName,
    required this.updaterName,
  });

  factory QuestionSet.fromJson(Map<String, dynamic> json) {
    return QuestionSet(
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
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createrName: json['creater_name'] ?? '',
      updaterName: json['updater_name'] ?? '',
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
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'] ?? 0,
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      links: (json['links'] as List?)
              ?.map((e) => MetaLink.fromJson(e))
              .toList() ??
          [],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 0,
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}
class MetaLink {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  MetaLink({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  factory MetaLink.fromJson(Map<String, dynamic> json) {
    return MetaLink(
      url: json['url'],
      label: json['label'] ?? '',
      page: json['page'],
      active: json['active'] ?? false,
    );
  }
}
