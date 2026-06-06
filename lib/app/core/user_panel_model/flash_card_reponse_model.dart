class FlashCardResponse {
  final bool success;
  final String message;
  final List<FlashCardItem> data;
  final PaginationLinks? links;
  final PaginationMeta? meta;

  FlashCardResponse({
    required this.success,
    required this.message,
    required this.data,
    this.links,
    this.meta,
  });

  factory FlashCardResponse.fromJson(Map<String, dynamic> json) {
    return FlashCardResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => FlashCardItem.fromJson(e))
          .toList(),
      links: json['links'] != null
          ? PaginationLinks.fromJson(json['links'])
          : null,
      meta:
          json['meta'] != null ? PaginationMeta.fromJson(json['meta']) : null,
    );
  }
}
class FlashCardItem {
  final int id;
  final int sortOrder;
  final String title;
  final String subtitle;
  final String category;
  final String file;
  final String? fileType;
  final int type;
  final String typeLabel;
  final bool isPublish;
  final String isPublishLabel;
  final int totalPages;
  final int studyGuideActivitiesCount;
  final double studyGuidePercentCompleted;
  final int flashCardActivitiesCount;
  final int flashCardsCount;
  final double flashCardPercentCompleted;
  final String createdAt;
  final String updatedAt;
  final String createrName;
  final String updaterName;

  FlashCardItem({
    required this.id,
    required this.sortOrder,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.file,
    this.fileType,
    required this.type,
    required this.typeLabel,
    required this.isPublish,
    required this.isPublishLabel,
    required this.totalPages,
    required this.studyGuideActivitiesCount,
    required this.studyGuidePercentCompleted,
    required this.flashCardActivitiesCount,
    required this.flashCardsCount,
    required this.flashCardPercentCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.createrName,
    required this.updaterName,
  });

  factory FlashCardItem.fromJson(Map<String, dynamic> json) {
    return FlashCardItem(
      id: json['id'] ?? 0,
      sortOrder: json['sort_order'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      category: json['category'] ?? '',
      file: json['file'] ?? '',
      fileType: json['file_type'],
      type: json['type'] ?? 0,
      typeLabel: json['type_label'] ?? '',
      isPublish: json['is_publish'] ?? false,
      isPublishLabel: json['is_publish_label'] ?? '',
      totalPages: json['total_pages'] ?? 0,
      studyGuideActivitiesCount:
          json['study_guide_activities_count'] ?? 0,
      studyGuidePercentCompleted:
    (json['study_guide_percent_completed'] ?? 0).toDouble(),
      flashCardActivitiesCount:
          json['flash_card_activities_count'] ?? 0,
      flashCardsCount: json['flash_cards_count'] ?? 0,
      flashCardPercentCompleted:
    (json['flash_card_percent_completed'] ?? 0).toDouble(),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createrName: json['creater_name'] ?? '',
      updaterName: json['updater_name'] ?? '',
    );
  }
}
class PaginationLinks {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  PaginationLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory PaginationLinks.fromJson(Map<String, dynamic> json) {
    return PaginationLinks(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}
class PaginationMeta {
  final int currentPage;
  final int from;
  final int lastPage;
  final int perPage;
  final int to;
  final int total;
  final List<PaginationLinkItem> links;
  final String path;

  PaginationMeta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
    required this.links,
    required this.path,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] ?? 0,
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
      path: json['path'] ?? '',
      links: (json['links'] as List<dynamic>? ?? [])
          .map((e) => PaginationLinkItem.fromJson(e))
          .toList(),
    );
  }
}
class PaginationLinkItem {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  PaginationLinkItem({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  factory PaginationLinkItem.fromJson(Map<String, dynamic> json) {
    return PaginationLinkItem(
      url: json['url'],
      label: json['label'] ?? '',
      page: json['page'],
      active: json['active'] ?? false,
    );
  }
}
