class MedicalDeclarationAppsModel {
  bool? status;
  String? message;
  List<MedicalDeclarationApp>? applications;
  int? size;
  int? page;
  int? totalPages;
  int? totalSize;
  int? perPage;

  MedicalDeclarationAppsModel(
      {this.status,
      this.message,
      this.applications,
      this.size,
      this.page,
      this.totalPages,
      this.totalSize,
      this.perPage});

  MedicalDeclarationAppsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      applications = <MedicalDeclarationApp>[];
      json['data'].forEach((v) {
        applications!.add(new MedicalDeclarationApp.fromJson(v));
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

class MedicalDeclarationApp {
  int? id;
  String? mprNo;
  String? mprType;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  MedicalPipeline? pipeline;

  MedicalDeclarationApp(
      {this.id,
      this.mprNo,
      this.mprType,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.pipeline});

  MedicalDeclarationApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mprNo = json['mpr_no'];
    mprType = json['mpr_type'];
    position = json['Position'];
    clientName = json['client_name'];
    candidateNationality = json['candidate_nationality'];
    candidateName = json['candidate_name'];
    pipeline = json['pipeline'] != null
        ? new MedicalPipeline.fromJson(json['pipeline'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mpr_no'] = this.mprNo;
    data['mpr_type'] = this.mprType;
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

class MedicalPipeline {
  int? candidateApplicationHdfId;
  String? umdCompanyName;

  MedicalPipeline({this.candidateApplicationHdfId, this.umdCompanyName});

  MedicalPipeline.fromJson(Map<String, dynamic> json) {
    candidateApplicationHdfId = json['candidate_application_hdf_id'];
    umdCompanyName = json['umd_company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_application_hdf_id'] = this.candidateApplicationHdfId;
    data['umd_company_name'] = this.umdCompanyName;
    return data;
  }
}