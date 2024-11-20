
class SurviesModel {
  bool? status;
  String? message;
  List<Survey>? surveys;

  SurviesModel({this.status, this.message, this.surveys});

  SurviesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      surveys = <Survey>[];
      json['data'].forEach((v) {
        surveys!.add(new Survey.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.surveys != null) {
      data['data'] = this.surveys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Survey {
  int? id;
  int? moduleId;
  String? surveyName;
  String? surveyDesc;
  String? surveyBy;
  String? surveyFrom;
  String? surveyTo;
  String? surveyStatus;

  Survey(
      {this.id,
      this.moduleId,
      this.surveyName,
      this.surveyDesc,
      this.surveyBy,
      this.surveyFrom,
      this.surveyTo,
      this.surveyStatus});

  Survey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    surveyName = json['survey_name'];
    surveyDesc = json['survey_desc'];
    surveyBy = json['survey_by'];
    surveyFrom = json['survey_from'];
    surveyTo = json['survey_to'];
    surveyStatus = json['survey_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_id'] = this.moduleId;
    data['survey_name'] = this.surveyName;
    data['survey_desc'] = this.surveyDesc;
    data['survey_by'] = this.surveyBy;
    data['survey_from'] = this.surveyFrom;
    data['survey_to'] = this.surveyTo;
    data['survey_status'] = this.surveyStatus;
    return data;
  }
}