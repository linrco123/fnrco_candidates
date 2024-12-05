class KeyWordsModel {
  bool? status;
  String? message;
  List<GetKeyword>? keywords;

  KeyWordsModel({this.status, this.message, this.keywords});

  KeyWordsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      keywords = <GetKeyword>[];
      json['data'].forEach((v) {
        keywords!.add(new GetKeyword.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.keywords != null) {
      data['data'] = this.keywords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetKeyword {
  int? id;
  String? keywordText;

  GetKeyword({this.id, this.keywordText});

  GetKeyword.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keywordText = json['keyword_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyword_text'] = this.keywordText;
    return data;
  }
}