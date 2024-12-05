class AnnouncementModel {
  bool? status;
  String? message;
  List<Announcement>? announcements;

  AnnouncementModel({this.status, this.message, this.announcements});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      announcements = <Announcement>[];
      json['data'].forEach((v) {
        announcements!.add(new Announcement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.announcements != null) {
      data['data'] = this.announcements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Announcement {
  int? id;
  String? announcementStatus;
  String? announcementText;
  String? announcementFrom;
  String? announcementTo;

  Announcement(
      {this.id,
      this.announcementStatus,
      this.announcementText,
      this.announcementFrom,
      this.announcementTo});

  Announcement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    announcementStatus = json['announcement_status'];
    announcementText = json['announcement_text'];
    announcementFrom = json['announcement_from'];
    announcementTo = json['announcement_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['announcement_status'] = this.announcementStatus;
    data['announcement_text'] = this.announcementText;
    data['announcement_from'] = this.announcementFrom;
    data['announcement_to'] = this.announcementTo;
    return data;
  }
}