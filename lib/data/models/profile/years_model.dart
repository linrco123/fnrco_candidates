class YearsModel {
  bool? status;
  String? message;
  List<Year>? years;

  YearsModel({this.status, this.message, this.years});

  YearsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      years = <Year>[];
      json['data'].forEach((v) {
        years!.add(new Year.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.years != null) {
      data['data'] = this.years!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Year {
  int? id;
  String? metaDataText;

  Year({this.id, this.metaDataText});

  Year.fromJson(Map<String, dynamic> json) {
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