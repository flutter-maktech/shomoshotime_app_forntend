class CmsResponse {
  bool? success;
  String? message;
  CmsData? data;

  CmsResponse({this.success, this.message, this.data});

  CmsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CmsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CmsData {
  int? id;
  int? sortOrder;
  String? type;
  String? content;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;

  CmsData({
    this.id,
    this.sortOrder,
    this.type,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  CmsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sortOrder = json['sort_order'];
    type = json['type'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sort_order'] = sortOrder;
    data['type'] = type;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    return data;
  }
}
