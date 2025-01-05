class DocumentsCategoryModel {
  bool? status;
  String? message;
  List<DocumentInfo>? documents;

  DocumentsCategoryModel({this.status, this.message, this.documents});

  DocumentsCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      documents = <DocumentInfo>[];
      json['data'].forEach((v) {
        documents!.add(new DocumentInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.documents != null) {
      data['data'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentInfo {
  int? id;
  String? metaCategoryTitle;

  DocumentInfo({this.id, this.metaCategoryTitle});

  DocumentInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metaCategoryTitle = json['meta_category_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meta_category_title'] = this.metaCategoryTitle;
    return data;
  }
}