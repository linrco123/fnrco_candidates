class AchievementsModel {
  bool? status;
  String? message;
  List<GetAchievement>? achievements;

  AchievementsModel({this.status, this.message, this.achievements});

  AchievementsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      achievements = <GetAchievement>[];
      json['data'].forEach((v) {
        achievements!.add(new GetAchievement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.achievements != null) {
      data['data'] = this.achievements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAchievement {
  int? id;
  String? achievementText;
  String? achievementBy;

  GetAchievement({this.id, this.achievementText, this.achievementBy});

  GetAchievement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    achievementText = json['achievement_text'];
    achievementBy = json['achievement_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['achievement_text'] = this.achievementText;
    data['achievement_by'] = this.achievementBy;
    return data;
  }
}