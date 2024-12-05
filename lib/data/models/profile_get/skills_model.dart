class GetSkillsModel {
  bool? status;
  String? message;
  List<GetSkill>? skills;

  GetSkillsModel({this.status, this.message, this.skills});

  GetSkillsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      skills = <GetSkill>[];
      json['data'].forEach((v) {
        skills!.add(new GetSkill.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.skills != null) {
      data['data'] = this.skills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetSkill {
  int? id;
  String? skillName;
  String? skillLevel;

  GetSkill({this.id, this.skillName, this.skillLevel});

  GetSkill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skillName = json['skill_name'];
    skillLevel = json['skill_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skill_name'] = this.skillName;
    data['skill_level'] = this.skillLevel;
    return data;
  }
}