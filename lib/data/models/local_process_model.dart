class LocalProcessModel {
  bool? status;
  String? message;
  List<LocalProcessApp>? applications;
  int? size;
  int? page;
  int? totalPages;
  int? totalSize;
  int? perPage;

  LocalProcessModel(
      {this.status,
      this.message,
      this.applications,
      this.size,
      this.page,
      this.totalPages,
      this.totalSize,
      this.perPage});

  LocalProcessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      applications = <LocalProcessApp>[];
      json['data'].forEach((v) {
        applications!.add(new LocalProcessApp.fromJson(v));
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

class LocalProcessApp {
  int? id;
  String? mprNo;
  String? mprType;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  List<LocalProcessPipeLine>? pipeline;

  LocalProcessApp(
      {this.id,
      this.mprNo,
      this.mprType,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.pipeline});

  LocalProcessApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mprNo = json['mpr_no'];
    mprType = json['mpr_type'];
    position = json['Position'];
    clientName = json['client_name'];
    candidateNationality = json['candidate_nationality'];
    candidateName = json['candidate_name'];
    if (json['pipeline'] != null) {
      pipeline = <LocalProcessPipeLine>[];
      json['pipeline'].forEach((v) {
        pipeline!.add(new LocalProcessPipeLine.fromJson(v));
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
    if (this.pipeline != null) {
      data['pipeline'] = this.pipeline!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocalProcessPipeLine {
  int? stepId;
  String? stepName;
  String? pathFile;

  LocalProcessPipeLine({this.stepId, this.stepName, this.pathFile});

  LocalProcessPipeLine.fromJson(Map<String, dynamic> json) {
    stepId = json['step_id'];
    stepName = json['step_name'];
    pathFile = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step_id'] = this.stepId;
    data['step_name'] = this.stepName;
    data['path_file'] = this.pathFile;
    return data;
  }
  // set changePath(String path){
 
  // }
  void changeFilePath(String newPath){
    this.pathFile = newPath;
  }
  
}





