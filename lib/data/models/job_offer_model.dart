class JobOfferModel {
  bool? status;
  String? message;
  List<JobApplication>? applications;
  int? size;
  int? page;
  int? totalPages;
  int? totalSize;
  int? perPage;

  JobOfferModel(
      {this.status,
      this.message,
      this.applications,
      this.size,
      this.page,
      this.totalPages,
      this.totalSize,
      this.perPage});

  JobOfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      applications = <JobApplication>[];
      json['data'].forEach((v) {
        applications!.add(new JobApplication.fromJson(v));
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
    if (this.applications != null) {
      data['data'] = this.applications!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    data['page'] = this.page;
    data['total_pages'] = this.totalPages;
    data['total_size'] = this.totalSize;
    data['per_page'] = this.perPage;
    return data;
  }
}

class JobApplication {
  int? id;
  String? mprNo;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  Pipeline? pipeline;

  JobApplication(
      {this.id,
      this.mprNo,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.pipeline});

  JobApplication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mprNo = json['mpr_no'];
    position = json['Position'];
    clientName = json['client_name'];
    candidateNationality = json['candidate_nationality'];
    candidateName = json['candidate_name'];
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
    if (this.pipeline != null) {
      data['pipeline'] = this.pipeline!.toJson();
    }
    return data;
  }
}

class Pipeline {
  String? jobOfferPdf;

  Pipeline({this.jobOfferPdf});

  Pipeline.fromJson(Map<String, dynamic> json) {
    jobOfferPdf = json['job_offer_pdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_offer_pdf'] = this.jobOfferPdf;
    return data;
  }
}