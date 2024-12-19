class ClassificationsModel {
  bool? status;
  String? message;
  List<Classification>? classifications;

  ClassificationsModel({this.status, this.message, this.classifications});

  ClassificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      classifications = <Classification>[];
      json['data'].forEach((v) {
        classifications!.add(new Classification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.classifications != null) {
      data['data'] = this.classifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classification {
  int? id;
  String? metaDataText;

  Classification({this.id, this.metaDataText});

  Classification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metaDataText = json['meta_data_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meta_data_text'] = this.metaDataText;
    return data;
  }
}