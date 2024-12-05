class ContentsModel {
  bool? status;
  String? message;
  List<ContentData>? contents;

  ContentsModel({this.status, this.message, this.contents});

  ContentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      contents = <ContentData>[];
      json['data'].forEach((v) {
        contents!.add(new ContentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.contents != null) {
      data['data'] = this.contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentData {
  int? id;
  String? contentText;
  String? contentStatus;
  String? contentFrom;
  String? contentTo;
  int? contentBy;
  String? createdAt;
  String? updatedAt;

  ContentData(
      {this.id,
      this.contentText,
      this.contentStatus,
      this.contentFrom,
      this.contentTo,
      this.contentBy,
      this.createdAt,
      this.updatedAt});

  ContentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentText = json['content_text'];
    contentStatus = json['content_status'];
    contentFrom = json['content_from'];
    contentTo = json['content_to'];
    contentBy = json['content_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content_text'] = this.contentText;
    data['content_status'] = this.contentStatus;
    data['content_from'] = this.contentFrom;
    data['content_to'] = this.contentTo;
    data['content_by'] = this.contentBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}