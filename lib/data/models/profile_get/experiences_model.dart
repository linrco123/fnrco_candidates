
class ExperiencesModel {
  bool? status;
  String? message;
  List<GetExperience>? experiences;

  ExperiencesModel({this.status, this.message, this.experiences});

  ExperiencesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      experiences = <GetExperience>[];
      json['data'].forEach((v) {
        experiences!.add(new GetExperience.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.experiences != null) {
      data['data'] = this.experiences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetExperience {
  int? id;
  String? countryId;
  String? experienceJobTitle;
  String? experienceStartIn;
  String? experienceEndIn;
  String? experienceDescription;
  String? experienceCompany;

  GetExperience(
      {this.id,
      this.countryId,
      this.experienceJobTitle,
      this.experienceStartIn,
      this.experienceEndIn,
      this.experienceDescription,
      this.experienceCompany});

  GetExperience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    experienceJobTitle = json['experience_job_title'];
    experienceStartIn = json['experience_start_in'];
    experienceEndIn = json['experience_end_in'];
    experienceDescription = json['experience_description'];
    experienceCompany = json['experience_company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['experience_job_title'] = this.experienceJobTitle;
    data['experience_start_in'] = this.experienceStartIn;
    data['experience_end_in'] = this.experienceEndIn;
    data['experience_description'] = this.experienceDescription;
    data['experience_company'] = this.experienceCompany;
    return data;
  }
}