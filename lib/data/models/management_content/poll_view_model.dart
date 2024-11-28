class PollViewModel {
  bool? status;
  String? message;
  List<PQuestion>? questions;

  PollViewModel({this.status, this.message, this.questions});

  PollViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      questions = <PQuestion>[];
      json['data'].forEach((v) {
        questions!.add(new PQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.questions != null) {
      data['data'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PQuestion {
  int? id;
  int? moduleId;
  String? pollBy;
  String? pollText;
  String? pollStatus;
  String? pollFrom;
  String? pollTo;
  List<Options>? options;

  PQuestion(
      {this.id,
      this.moduleId,
      this.pollBy,
      this.pollText,
      this.pollStatus,
      this.pollFrom,
      this.pollTo,
      this.options});

  PQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    pollBy = json['poll_by'];
    pollText = json['poll_text'];
    pollStatus = json['poll_status'];
    pollFrom = json['poll_from'];
    pollTo = json['poll_to'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
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
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  int? pollId;
  String? pollOptText;
  String? pollOptValue;

  Options({this.id, this.pollId, this.pollOptText, this.pollOptValue});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pollId = json['poll_id'];
    pollOptText = json['poll_opt_text'];
    pollOptValue = json['poll_opt_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['poll_id'] = this.pollId;
    data['poll_opt_text'] = this.pollOptText;
    data['poll_opt_value'] = this.pollOptValue;
    return data;
  }
}