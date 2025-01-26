class PollPercentagesModel {
  String? success;
  PPoll? poll;
  VotePercentages? votePercentages;

  PollPercentagesModel({this.success, this.poll, this.votePercentages});

  PollPercentagesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    poll = json['poll'] != null ? new PPoll.fromJson(json['poll']) : null;
    votePercentages = json['vote_percentages'] != null
        ? new VotePercentages.fromJson(json['vote_percentages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.poll != null) {
      data['poll'] = this.poll!.toJson();
    }
    if (this.votePercentages != null) {
      data['vote_percentages'] = this.votePercentages!.toJson();
    }
    return data;
  }
}

class PPoll {
  int? id;
  String? text;
  List<Options>? options;

  PPoll({this.id, this.text, this.options});

  PPoll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
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
    data['text'] = this.text;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? text;
  String? votes;

  Options({this.id, this.text, this.votes});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    votes = json['votes'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['votes'] = this.votes;
    return data;
  }
}

class VotePercentages {
  double? jobPostingAdvertising;
  double? candidateSourcing;
  double? applicantTrackingSystemATS;
  double? interviewScheduling;
  double? candidateScreeningAssessments;

  VotePercentages(
      {this.jobPostingAdvertising,
      this.candidateSourcing,
      this.applicantTrackingSystemATS,
      this.interviewScheduling,
      this.candidateScreeningAssessments});

  VotePercentages.fromJson(Map<String, dynamic> json) {
    jobPostingAdvertising =
        double.parse(json['Job Posting & Advertising'].toString());
    candidateSourcing = double.parse(json['Candidate Sourcing'].toString());
    applicantTrackingSystemATS =
        double.parse(json['Applicant Tracking System (ATS)'].toString());
    interviewScheduling = double.parse(json['Interview Scheduling'].toString());
    candidateScreeningAssessments =
        double.parse(json['Candidate Screening & Assessments'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Job Posting & Advertising'] = this.jobPostingAdvertising;
    data['Candidate Sourcing'] = this.candidateSourcing;
    data['Applicant Tracking System (ATS)'] = this.applicantTrackingSystemATS;
    data['Interview Scheduling'] = this.interviewScheduling;
    data['Candidate Screening & Assessments'] =
        this.candidateScreeningAssessments;
    //data.keys.toList();
    return data;
  }
}
