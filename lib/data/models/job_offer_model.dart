// class JobOfferModel {
//   bool? status;
//   String? message;
//   List<JobApplication>? applications;
//   int? size;
//   int? page;
//   int? totalPages;
//   int? totalSize;
//   int? perPage;

//   JobOfferModel(
//       {this.status,
//       this.message,
//       this.applications,
//       this.size,
//       this.page,
//       this.totalPages,
//       this.totalSize,
//       this.perPage});

//   JobOfferModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       applications = <JobApplication>[];
//       json['data'].forEach((v) {
//         applications!.add(new JobApplication.fromJson(v));
//       });
//     }
//     size = json['size'];
//     page = json['page'];
//     totalPages = json['total_pages'];
//     totalSize = json['total_size'];
//     perPage = json['per_page'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.applications != null) {
//       data['data'] = this.applications!.map((v) => v.toJson()).toList();
//     }
//     data['size'] = this.size;
//     data['page'] = this.page;
//     data['total_pages'] = this.totalPages;
//     data['total_size'] = this.totalSize;
//     data['per_page'] = this.perPage;
//     return data;
//   }
// }

// class JobApplication {
//   int? id;
//   String? mprNo;
//   String? mprType;
//   String? position;
//   String? clientName;
//   String? candidateNationality;
//   String? candidateName;
//   String? isAction;
//   Pipeline? pipeline;

//   JobApplication(
//       {this.id,
//       this.mprNo,
//       this.position,
//       this.clientName,
//       this.candidateNationality,
//       this.candidateName,
//       this.pipeline,
//       this.mprType
//       });

//   JobApplication.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     mprNo = json['mpr_no'];
//     mprType = json['mpr_type'];
//     position = json['Position'];
//     clientName = json['client_name'];
//     candidateNationality = json['candidate_nationality'];
//     candidateName = json['candidate_name'];
//     isAction = json['is_action'];
//     pipeline = json['pipeline'] != null
//         ? new Pipeline.fromJson(json['pipeline'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['mpr_no'] = this.mprNo;
//     data['mpr_type'] = this.mprType;
//     data['Position'] = this.position;
//     data['client_name'] = this.clientName;
//     data['candidate_nationality'] = this.candidateNationality;
//     data['candidate_name'] = this.candidateName;
//     data["is_action"] = this.isAction;
//     if (this.pipeline != null) {
//       data['pipeline'] = this.pipeline!.toJson();
//     }
//     return data;
//   }
// }

// class Pipeline {
//   String? jobOfferPdf;

//   Pipeline({this.jobOfferPdf});

//   Pipeline.fromJson(Map<String, dynamic> json) {
//     jobOfferPdf = json['job_offer_pdf'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['job_offer_pdf'] = this.jobOfferPdf;
//     return data;
//   }
// }


////////////////////////////////////////////////////////

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
  String? mprType;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  String? isAction;
  Pipeline? pipeline;
  Approvals? approvals;

  JobApplication(
      {this.id,
      this.mprNo,
      this.mprType,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.isAction,
      this.pipeline,
      this.approvals});

  JobApplication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mprNo = json['mpr_no'];
    mprType = json['mpr_type'];
    position = json['Position'];
    clientName = json['client_name'];
    candidateNationality = json['candidate_nationality'];
    candidateName = json['candidate_name'];
    isAction = json['is_action'];
    pipeline = json['pipeline'] != null
        ? new Pipeline.fromJson(json['pipeline'])
        : null;
    approvals = json['approvals'] != null
        ? new Approvals.fromJson(json['approvals'])
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
    data['is_action'] = this.isAction;
    if (this.pipeline != null) {
      data['pipeline'] = this.pipeline!.toJson();
    }
    if (this.approvals != null) {
      data['approvals'] = this.approvals!.toJson();
    }
    return data;
  }
}

class Pipeline {
  String? jobOfferPdf;
  String? createdAt;

  Pipeline({this.jobOfferPdf, this.createdAt});

  Pipeline.fromJson(Map<String, dynamic> json) {
    jobOfferPdf = json['job_offer_pdf'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_offer_pdf'] = this.jobOfferPdf;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Approvals {
  Client? client;
  Agency? agency;
  Candidate? candidate;

  Approvals({this.client, this.agency, this.candidate});

  Approvals.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    agency =
        json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
    candidate = json['candidate'] != null
        ? new Candidate.fromJson(json['candidate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    if (this.candidate != null) {
      data['candidate'] = this.candidate!.toJson();
    }
    return data;
  }
}

class Client {
  String? remarks;
  String? isApproved;
  String? clientApprovedIn;
  String? clientName;

  Client(
      {this.remarks, this.isApproved, this.clientApprovedIn, this.clientName});

  Client.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    isApproved = json['is_approved'];
    clientApprovedIn = json['client_approved_in'];
    clientName = json['client_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remarks'] = this.remarks;
    data['is_approved'] = this.isApproved;
    data['client_approved_in'] = this.clientApprovedIn;
    data['client_name'] = this.clientName;
    return data;
  }
}

class Agency {
  String? remarks;
  String? isApproved;
  String? agencyApprovedIn;
  String? agencyName;

  Agency(
      {this.remarks, this.isApproved, this.agencyApprovedIn, this.agencyName});

  Agency.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    isApproved = json['is_approved'];
    agencyApprovedIn = json['agency_approved_in'];
    agencyName = json['agency_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remarks'] = this.remarks;
    data['is_approved'] = this.isApproved;
    data['agency_approved_in'] = this.agencyApprovedIn;
    data['agency_name'] = this.agencyName;
    return data;
  }
}

class Candidate {
  String? remarks;
  String? isApproved;
  String? candidateApprovedIn;
  String? candidateName;

  Candidate(
      {this.remarks,
      this.isApproved,
      this.candidateApprovedIn,
      this.candidateName});

  Candidate.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    isApproved = json['is_approved'];
    candidateApprovedIn = json['candidate_approved_in'];
    candidateName = json['candidate_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remarks'] = this.remarks;
    data['is_approved'] = this.isApproved;
    data['candidate_approved_in'] = this.candidateApprovedIn;
    data['candidate_name'] = this.candidateName;
    return data;
  }
}