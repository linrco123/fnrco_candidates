class PollsModel {
  bool? status;
  String? message;
  Poll? poll;

  PollsModel({this.status, this.message, this.poll});

  PollsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    poll = json['data'] != null ? new Poll.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.poll != null) {
      data['data'] = this.poll!.toJson();
    }
    return data;
  }
}

class Poll {
  int? id;
  int? moduleId;
  String? pollBy;
  String? pollText;
  String? pollStatus;
  String? pollFrom;
  String? pollTo;

  Poll(
      {this.id,
      this.moduleId,
      this.pollBy,
      this.pollText,
      this.pollStatus,
      this.pollFrom,
      this.pollTo});

  Poll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    pollBy = json['poll_by'];
    pollText = json['poll_text'];
    pollStatus = json['poll_status'];
    pollFrom = json['poll_from'];
    pollTo = json['poll_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_id'] = this.moduleId;
    data['poll_by'] = this.pollBy;
    data['poll_text'] = this.pollText;
    data['poll_status'] = this.pollStatus;
    data['poll_from'] = this.pollFrom;
    data['poll_to'] = this.pollTo;
    return data;
  }
}