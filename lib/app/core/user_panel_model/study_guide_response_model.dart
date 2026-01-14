import 'dart:convert';

import 'package:intl/intl.dart';
import '../urls/urls.dart';

// Main API response model
class StudyGuideResponse {
  final bool success;
  final String message;
  final List<StudyGuide> data;
  final Links links;
  final Meta meta;

  StudyGuideResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.links,
    required this.meta,
  });

  factory StudyGuideResponse.fromJson(Map<String, dynamic> json) {
    return StudyGuideResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((item) => StudyGuide.fromJson(item))
          .toList(),
      links: Links.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
    };
  }

  static StudyGuideResponse fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return StudyGuideResponse.fromJson(json);
  }
}

// Individual study guide model
// Individual study guide model with nullable fields
class StudyGuide {
  final int id;
  final int sortOrder;
  final String title;
  final String subtitle;
  final String category;
  final String? file; // Nullable
  final String? fileType; // Nullable
  final int? totalPage;
  final int type;
  final String typeLabel;
  final bool isPublish;
  final String isPublishLabel;
  final String createdAt;
  final String updatedAt;
  final String createrName;
  final String updaterName;
  final double studyGuidePercentCompleted;
  final int studyGuideActivitiesCount;

  StudyGuide({
    required this.id,
    required this.sortOrder,
    required this.title,
    required this.subtitle,
    required this.category,
    this.file, // Nullable
    this.fileType, // Nullable
    required this.type,
    required this.typeLabel,
    required this.isPublish,
    required this.isPublishLabel,
    required this.createdAt,
    required this.updatedAt,
    required this.createrName,
    required this.updaterName,
    this.totalPage,
    required this.studyGuidePercentCompleted, required this.studyGuideActivitiesCount,
  });

  factory StudyGuide.fromJson(Map<String, dynamic> json) {
    return StudyGuide(
      id: json['id'] as int,
      sortOrder: json['sort_order'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      category: json['category'] as String,
      file: json['file'] as String?, // Nullable cast
      fileType: json['file_type'] as String?, // Nullable cast
      type: json['type'] as int,
      typeLabel: json['type_label'] as String,
      isPublish: json['is_publish'] as bool,
      isPublishLabel: json['is_publish_label'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      createrName: json['creater_name'] as String,
      updaterName: json['updater_name'] as String,
      totalPage: json['total_pages'] as int?,
      studyGuidePercentCompleted:
          (json['study_guide_percent_completed'] as num?)?.toDouble() ?? 0.0,
      studyGuideActivitiesCount: json['study_guide_activities_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sort_order': sortOrder,
      'title': title,
      'subtitle': subtitle,
      'category': category,
      'file': file,
      'file_type': fileType,
      'type': type,
      'type_label': typeLabel,
      'is_publish': isPublish,
      'is_publish_label': isPublishLabel,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'creater_name': createrName,
      'updater_name': updaterName,
      'total_page': totalPage,
    };
  }
}

// Links model for pagination
class Links {
  final String first;
  final String last;
  final String? prev;
  final String? next;

  Links({required this.first, required this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'] as String,
      last: json['last'] as String,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'first': first, 'last': last, 'prev': prev, 'next': next};
  }
}

// Meta model for pagination metadata
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
      currentPage: json['current_page'] as int,
      from: json['from'] as int,
      lastPage: json['last_page'] as int,
      links: (json['links'] as List)
          .map((item) => MetaLink.fromJson(item))
          .toList(),
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      to: json['to'] as int,
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links.map((link) => link.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

// Meta link model for individual pagination links
class MetaLink {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  MetaLink({this.url, required this.label, this.page, required this.active});

  factory MetaLink.fromJson(Map<String, dynamic> json) {
    return MetaLink(
      url: json['url'] as String?,
      label: json['label'] as String,
      page: json['page'] as int?,
      active: json['active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'label': label, 'page': page, 'active': active};
  }
}

extension StudyGuideExtensions on StudyGuide {
  // Check if it's a PDF file
  bool get isPdf => fileType?.toLowerCase() == 'pdf';

  // Check if it's a flashcard
  bool get isFlashcard => type == 1;

  // Get full file URL (assuming you have a base URL)
  String? get fullFileUrl => file != null ? '${Urls.baseDomain}/$file' : null;

  // Get formatted date
  DateTime? get parsedCreatedAt {
    try {
      if (createdAt == 'N/A') return null;
      // Parse "07 Jan, 2026 11:41 AM"
      return DateFormat('dd MMM, yyyh hh:mm a').parse(createdAt);
    } catch (e) {
      return null;
    }
  }
}
