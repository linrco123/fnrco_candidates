class LocalProcessModel {
  bool? status;
  String? message;
  List<LocalProcess>? data;
  int? size;
  int? page;
  int? totalPages;
  int? totalSize;
  int? perPage;

  LocalProcessModel(
      {this.status,
      this.message,
      this.data,
      this.size,
      this.page,
      this.totalPages,
      this.totalSize,
      this.perPage});

  LocalProcessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LocalProcess>[];
      json['data'].forEach((v) {
        data!.add(new LocalProcess.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    data['page'] = this.page;
    data['total_pages'] = this.totalPages;
    data['total_size'] = this.totalSize;
    data['per_page'] = this.perPage;
    return data;
  }
}

class LocalProcess {
  int? id;
  String? mprNo;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  dynamic pipeline;

  LocalProcess(
      {this.id,
      this.mprNo,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.pipeline});

  LocalProcess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mprNo = json['mpr_no'];
    position = json['Position'];
    clientName = json['client_name'];
    candidateNationality = json['candidate_nationality'];
    candidateName = json['candidate_name'];
    pipeline = json['pipeline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mpr_no'] = this.mprNo;
    data['Position'] = this.position;
    data['client_name'] = this.clientName;
    data['candidate_nationality'] = this.candidateNationality;
    data['candidate_name'] = this.candidateName;
    data['pipeline'] = this.pipeline;
    return data;
  }
}