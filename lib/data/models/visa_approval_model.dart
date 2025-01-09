class VisaApprovalModel {
  bool? status;
  String? message;
  List<VisaApprovalApplication>? visaApplications;
  int? size;
  int? page;
  int? totalPages;
  int? totalSize;
  int? perPage;

  VisaApprovalModel(
      {this.status,
      this.message,
      this.visaApplications,
      this.size,
      this.page,
      this.totalPages,
      this.totalSize,
      this.perPage});

  VisaApprovalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      visaApplications = <VisaApprovalApplication>[];
      json['data'].forEach((v) {
        visaApplications!.add(new VisaApprovalApplication.fromJson(v));
      });
    }
    size = json['size'];
    page = json['page'];
    totalPages = json['total_pages'];
    totalSize = json['total_size'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.visaApplications != null) {
      data['data'] = this.visaApplications!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    data['page'] = this.page;
    data['total_pages'] = this.totalPages;
    data['total_size'] = this.totalSize;
    data['per_page'] = this.perPage;
    return data;
  }
}

class VisaApprovalApplication {
  int? id;
  String? mprNo;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  Pipeline? pipeline;
  String? isAction;

  VisaApprovalApplication(
      {this.id,
      this.mprNo,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.pipeline});

  VisaApprovalApplication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mprNo = json['mpr_no'];
    position = json['Position'];
    clientName = json['client_name'];
    candidateNationality = json['candidate_nationality'];
    candidateName = json['candidate_name'];
    isAction = json['is_action'];
    pipeline = json['pipeline'] != null
        ? new Pipeline.fromJson(json['pipeline'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mpr_no'] = this.mprNo;
    data['Position'] = this.position;
    data['client_name'] = this.clientName;
    data['candidate_nationality'] = this.candidateNationality;
    data['candidate_name'] = this.candidateName;

    data["is_action"] = this.isAction;
    if (this.pipeline != null) {
      data['pipeline'] = this.pipeline!.toJson();
    }
    return data;
  }
}

class Pipeline {
  String? visaNo;
  String? positionName;
  String? religion;
  String? country;
  String? gender;

  Pipeline(
      {this.visaNo,
      this.positionName,
      this.religion,
      this.country,
      this.gender});

  Pipeline.fromJson(Map<String, dynamic> json) {
    visaNo = json['visa_no'];
    positionName = json['position_name'];
    religion = json['religion'];
    country = json['country'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visa_no'] = this.visaNo;
    data['position_name'] = this.positionName;
    data['religion'] = this.religion;
    data['country'] = this.country;
    data['gender'] = this.gender;
    return data;
  }
}
