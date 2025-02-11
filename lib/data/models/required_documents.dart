// class RequiredDocumentsModel {
//   bool? status;
//   String? message;
//   List<RequiredDocumentsApp>? applications;
//   int? size;
//   int? page;
//   int? totalPages;
//   int? totalSize;
//   int? perPage;

//   RequiredDocumentsModel(
//       {this.status,
//       this.message,
//       this.applications,
//       this.size,
//       this.page,
//       this.totalPages,
//       this.totalSize,
//       this.perPage});

//   RequiredDocumentsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       applications = <RequiredDocumentsApp>[];
//       json['data'].forEach((v) {
//         applications!.add(new RequiredDocumentsApp.fromJson(v));
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

// class RequiredDocumentsApp {
//   int? id;
//   String? mprNo;
//   String? mprType;
//   String? position;
//   String? clientName;
//   String? candidateNationality;
//   String? candidateName;
//   List<RequiredDocumentsPipeLine>? pipeline;

//   RequiredDocumentsApp(
//       {this.id,
//       this.mprNo,
//       this.mprType,
//       this.position,
//       this.clientName,
//       this.candidateNationality,
//       this.candidateName,
//       this.pipeline});

//   RequiredDocumentsApp.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     mprNo = json['mpr_no'];
//     mprType = json['mpr_type'];
//     position = json['Position'];
//     clientName = json['client_name'];
//     candidateNationality = json['candidate_nationality'];
//     candidateName = json['candidate_name'];
//     if (json['pipeline'] != null) {
//       pipeline = <RequiredDocumentsPipeLine>[];
//       json['pipeline'].forEach((v) {
//         pipeline!.add(new RequiredDocumentsPipeLine.fromJson(v));
//       });
//     }
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
//     if (this.pipeline != null) {
//       data['pipeline'] = this.pipeline!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
// //"verified": ""
// class RequiredDocumentsPipeLine {
//   int? stepId;
//   String? stepName;
//   String? pathFile;
//   String? verified;

//   RequiredDocumentsPipeLine({this.stepId, this.stepName, this.pathFile});

//   RequiredDocumentsPipeLine.fromJson(Map<String, dynamic> json) {
//     stepId = json['step_id'];
//     stepName = json['step_name'];
//     pathFile = json['file_path'];
//     verified = json['verified'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['step_id'] = this.stepId;
//     data['step_name'] = this.stepName;
//     data['path_file'] = this.pathFile;
//     data["verified"] = this.verified;
//     return data;
//   }

//   void changeFilePath(String newPath){
//     this.pathFile = newPath;
//   }
  
// }
//////////////////////////////////////////////////////////////


class RequiredDocumentsModel {
  bool? status;
  String? message;
  RequiredDocumentsApp? data;

  RequiredDocumentsModel({this.status, this.message, this.data});

  RequiredDocumentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new RequiredDocumentsApp.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RequiredDocumentsApp {
  int? id;
  String? mprNo;
  String? mprType;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  List<RequiredDocument>? requiredDocuments;

  RequiredDocumentsApp(
      {this.id,
      this.mprNo,
      this.mprType,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.requiredDocuments});

  RequiredDocumentsApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mprNo = json['mpr_no'];
    mprType = json['mpr_type'];
    position = json['Position'];
    clientName = json['client_name'];
    candidateNationality = json['candidate_nationality'];
    candidateName = json['candidate_name'];
    if (json['documents'] != null) {
      requiredDocuments = <RequiredDocument>[];
      json['documents'].forEach((v) {
        requiredDocuments!.add(new RequiredDocument.fromJson(v));
      });
    }
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
    if (this.requiredDocuments != null) {
      data['documents'] = this.requiredDocuments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequiredDocument {
  int? stepId;
  String? stepName;
  String? filePath;
  String? verified;

  RequiredDocument({this.stepId, this.stepName, this.filePath, this.verified});

  RequiredDocument.fromJson(Map<String, dynamic> json) {
    stepId = json['step_id'];
    stepName = json['step_name'];
    filePath = json['file_path'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step_id'] = this.stepId;
    data['step_name'] = this.stepName;
    data['file_path'] = this.filePath;
    data['verified'] = this.verified;
    return data;
  }

    void changeFilePath(String newPath){
    this.filePath = newPath;
  }
}
