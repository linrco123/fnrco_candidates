class SkillsModel {
  bool? status;
  String? message;
  List<Skill>? data;

  SkillsModel({this.status, this.message, this.data});

  SkillsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Skill>[];
      json['data'].forEach((v) {
        data!.add(new Skill.fromJson(v));
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

class Skill {
  int? id;
  String? metaDataText;

  Skill({this.id, this.metaDataText});

  Skill.fromJson(Map<String, dynamic> json) {
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