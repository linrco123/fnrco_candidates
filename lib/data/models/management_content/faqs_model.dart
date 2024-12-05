class FAQsModel {
  bool? status;
  String? message;
  List<FAQ>? faq;

  FAQsModel({this.status, this.message, this.faq});

  FAQsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      faq = <FAQ>[];
      json['data'].forEach((v) {
        faq!.add(new FAQ.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.faq != null) {
      data['data'] = this.faq!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FAQ {
  int? id;
  String? title;
  String? desc;
  String? status;
  String? createdBy;

  FAQ({this.id, this.title, this.desc, this.status, this.createdBy});

  FAQ.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    status = json['status'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    return data;
  }
}