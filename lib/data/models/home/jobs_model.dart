class JobsModel {
  bool? success;
  String? message;
  List<Jobs>? jobs;

  JobsModel({this.success, this.message, this.jobs});

  JobsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      jobs = <Jobs>[];
      json['data'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.jobs != null) {
      data['data'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  int? id;
  String? positionName;
  String? createdAt;

  Jobs({this.id, this.positionName, this.createdAt});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positionName = json['position_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position_name'] = this.positionName;
    data['created_at'] = this.createdAt;
    return data;
  }
}