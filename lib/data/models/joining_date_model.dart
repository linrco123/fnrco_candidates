class JoiningDateModel {
  bool? status;
  String? message;
  List<JoiningDateApplication>? dateApplications;
  int? size;
  int? page;
  int? totalPages;
  int? totalSize;
  int? perPage;

  JoiningDateModel(
      {this.status,
      this.message,
      this.dateApplications,
      this.size,
      this.page,
      this.totalPages,
      this.totalSize,
      this.perPage});

  JoiningDateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      dateApplications = <JoiningDateApplication>[];
      json['data'].forEach((v) {
        dateApplications!.add(new JoiningDateApplication.fromJson(v));
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
    if (this.dateApplications != null) {
      data['data'] = this.dateApplications!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    data['page'] = this.page;
    data['total_pages'] = this.totalPages;
    data['total_size'] = this.totalSize;
    data['per_page'] = this.perPage;
    return data;
  }
}

class JoiningDateApplication {
  int? id;
  String? mprNo;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  Pipeline? pipeline;

  JoiningDateApplication(
      {this.id,
      this.mprNo,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.pipeline});

  JoiningDateApplication.fromJson(Map<String, dynamic> json) {
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
  String? joiningDate;
  String? joiningDateIn;

  Pipeline({this.joiningDate, this.joiningDateIn});

  Pipeline.fromJson(Map<String, dynamic> json) {
    joiningDate = json['joining_date'];
    joiningDateIn = json['joining_date_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['joining_date'] = this.joiningDate;
    data['joining_date_in'] = this.joiningDateIn;
    return data;
  }
}