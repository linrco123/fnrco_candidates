class EducationsModel {
  bool? status;
  String? message;
  List<GetEducation>? educations;

  EducationsModel({this.status, this.message, this.educations});

  EducationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      educations = <GetEducation>[];
      json['data'].forEach((v) {
        educations!.add(new GetEducation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.educations != null) {
      data['data'] = this.educations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetEducation {
  int? id;
  String? eduFieldOfStudy;
  String? eduCertificationName;
  String? eduDegree;
  String? eduYears;
  String? eduInstitutionName;
  String? eduGraduationYear;
  String? eduCertificationIssuesIn;
  String? eduCertificationExpiryIn;

  GetEducation(
      {this.id,
      this.eduFieldOfStudy,
      this.eduCertificationName,
      this.eduDegree,
      this.eduYears,
      this.eduInstitutionName,
      this.eduGraduationYear,
      this.eduCertificationIssuesIn,
      this.eduCertificationExpiryIn});

  GetEducation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eduFieldOfStudy = json['edu_field_of_study'];
    eduCertificationName = json['edu_certification_name'];
    eduDegree = json['edu_degree'];
    eduYears = json['edu_years'];
    eduInstitutionName = json['edu_institution_name'];
    eduGraduationYear = json['edu_graduation_year'];
    eduCertificationIssuesIn = json['edu_certification_issues_in'];
    eduCertificationExpiryIn = json['edu_certification_expiry_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['edu_field_of_study'] = this.eduFieldOfStudy;
    data['edu_certification_name'] = this.eduCertificationName;
    data['edu_degree'] = this.eduDegree;
    data['edu_years'] = this.eduYears;
    data['edu_institution_name'] = this.eduInstitutionName;
    data['edu_graduation_year'] = this.eduGraduationYear;
    data['edu_certification_issues_in'] = this.eduCertificationIssuesIn;
    data['edu_certification_expiry_in'] = this.eduCertificationExpiryIn;
    return data;
  }
}