class GenderModel {
  bool? success;
  String? message;
  List<Gender>? genders;

  GenderModel({this.success, this.message, this.genders});

  GenderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      genders = <Gender>[];
      json['data'].forEach((v) {
        genders!.add(new Gender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.genders != null) {
      data['data'] = this.genders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gender {
  int? id;
  String? metaDataText;

  Gender({this.id, this.metaDataText});

  Gender.fromJson(Map<String, dynamic> json) {
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