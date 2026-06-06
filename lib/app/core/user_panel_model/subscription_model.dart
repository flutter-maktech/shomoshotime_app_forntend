class SubscriptionResponse {
  final bool success;
  final String message;
  final List<Subscription> data;
  final PaginationLinks links;
  final Meta meta;

  SubscriptionResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.links,
    required this.meta,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => Subscription.fromJson(e))
          .toList(),
      links: PaginationLinks.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
    );
  }
}
class Subscription {
  final int id;
  final int sortOrder;
  final String duration;
  final double price;
  final List<String> features;
  final int? tag;
  final int status;
  final String statusLabel;
  final String createdAt;
  final String updatedAt;
  final String createrName;
  final String updaterName;

  Subscription({
    required this.id,
    required this.sortOrder,
    required this.duration,
    required this.price,
    required this.features,
    this.tag,
    required this.status,
    required this.statusLabel,
    required this.createdAt,
    required this.updatedAt,
    required this.createrName,
    required this.updaterName,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      sortOrder: json['sort_order'],
      duration: json['duration'],
      price: double.tryParse("${json['price']??0}")??0,
      features: List<String>.from(json['features']),
      tag: json['tag'],
      status: json['status'],
      statusLabel: json['status_label'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createrName: json['creater_name'],
      updaterName: json['updater_name'],
    );
  }
}
class PaginationLinks {
  final String first;
  final String last;
  final String? prev;
  final String? next;

  PaginationLinks({
    required this.first,
    required this.last,
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
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      links: (json['links'] as List<dynamic>)
          .map((e) => MetaLink.fromJson(e))
          .toList(),
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
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
      label: json['label'],
      page: json['page'],
      active: json['active'],
    );
  }
}
