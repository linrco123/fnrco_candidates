class TutorialsModel {
  bool? status;
  String? message;
  List<Tutorial>? tutorials;

  TutorialsModel({this.status, this.message, this.tutorials});

  TutorialsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      tutorials = <Tutorial>[];
      json['data'].forEach((v) {
        tutorials!.add(new Tutorial.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tutorials != null) {
      data['data'] = this.tutorials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tutorial {
  int? id;
  String? tuTitle;
  String? tuDesc;
  String? tuLink;
  String? tuViews;

  Tutorial({this.id, this.tuTitle, this.tuDesc, this.tuLink, this.tuViews});

  Tutorial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tuTitle = json['tu_title'];
    tuDesc = json['tu_desc'];
    tuLink = json['tu_link'];
    tuViews = json['tu_views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tu_title'] = this.tuTitle;
    data['tu_desc'] = this.tuDesc;
    data['tu_link'] = this.tuLink;
    data['tu_views'] = this.tuViews;
    return data;
  }
}