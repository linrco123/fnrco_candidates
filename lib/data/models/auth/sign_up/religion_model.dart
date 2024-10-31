class ReligionModel {
  bool? status;
  String? message;
  List<Religion>? data;

  ReligionModel({this.status, this.message, this.data});

  ReligionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Religion>[];
      json['data'].forEach((v) {
        data!.add(new Religion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Religion {
  int? id;
  String? religionName;

  Religion({this.id, this.religionName});

  Religion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    religionName = json['religion_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['religion_name'] = this.religionName;
    return data;
  }
}