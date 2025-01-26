class SharedDocumentsModel {
  bool? status;
  String? message;
  List<SharedDocument>? sharedDocuments;

  SharedDocumentsModel({this.status, this.message, this.sharedDocuments});

  SharedDocumentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      sharedDocuments = <SharedDocument>[];
      json['data'].forEach((v) {
        sharedDocuments!.add(new SharedDocument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.sharedDocuments != null) {
      data['data'] = this.sharedDocuments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SharedDocument {
  int? id;
  int? candidateApplicationId;
  String? mprNo;
  String? clientName;
  String? uploadedAt;
  String? stepId;
  String? fileName;
  String? filePath;
  String? fileType;
  String? verified;
  DocumentationRequestId? documentationRequestId;

  SharedDocument(
      {this.id,
      this.candidateApplicationId,
      this.mprNo,
      this.clientName,
      this.uploadedAt,
      this.stepId,
      this.fileName,
      this.filePath,
      this.fileType,
      this.verified,
      this.documentationRequestId});

  SharedDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    candidateApplicationId = json['candidate_application_id'];
    mprNo = json['mpr_no'];
    clientName = json['client_name'];
    uploadedAt = json['uploaded_at'];
    stepId = json['step_id'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    fileType = json['file_type'];
    verified = json['verified'];
    documentationRequestId = json['documentation_request_id'] != ""
        ? new DocumentationRequestId.fromJson(json['documentation_request_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['candidate_application_id'] = this.candidateApplicationId;
    data['mpr_no'] = this.mprNo;
    data['client_name'] = this.clientName;
    data['uploaded_at'] = this.uploadedAt;
    data['step_id'] = this.stepId;
    data['file_name'] = this.fileName;
    data['file_path'] = this.filePath;
    data['file_type'] = this.fileType;
    data['verified'] = this.verified;
    if (this.documentationRequestId != null) {
      data['documentation_request_id'] = this.documentationRequestId!.toJson();
    }
    return data;
  }
}

class DocumentationRequestId {
  int? requestId;
  int? candidateAppId;
  String? mprNo;
  String? positionName;
  String? clientName;
  String? documentType;
  String? requestType;
  String? requestTo;
  String? remarks;
  String? title;
  String? file;

  DocumentationRequestId(
      {this.requestId,
      this.candidateAppId,
      this.mprNo,
      this.positionName,
      this.clientName,
      this.documentType,
      this.requestType,
      this.requestTo,
      this.remarks,
      this.title,
      this.file});

  DocumentationRequestId.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    candidateAppId = json['candidate_app_id'];
    mprNo = json['mpr_no'];
    positionName = json['position_name'];
    clientName = json['client_name'];
    documentType = json['document_type'];
    requestType = json['request_type'];
    requestTo = json['request_to'];
    remarks = json['remarks'];
    title = json['title'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['candidate_app_id'] = this.candidateAppId;
    data['mpr_no'] = this.mprNo;
    data['position_name'] = this.positionName;
    data['client_name'] = this.clientName;
    data['document_type'] = this.documentType;
    data['request_type'] = this.requestType;
    data['request_to'] = this.requestTo;
    data['remarks'] = this.remarks;
    data['title'] = this.title;
    data['file'] = this.file;
    return data;
  }
}