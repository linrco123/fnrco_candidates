
class RequestModel {
  bool? status;
  String? message;
  List<RequestData>? data;
  int? size;
  int? page;
  int? totalPages;
  int? totalSize;
  int? perPage;

  RequestModel(
      {this.status,
      this.message,
      this.data,
      this.size,
      this.page,
      this.totalPages,
      this.totalSize,
      this.perPage});

  RequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RequestData>[];
      json['data'].forEach((v) {
        data!.add(new RequestData.fromJson(v));
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

class RequestData {
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

  RequestData(
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

  RequestData.fromJson(Map<String, dynamic> json) {
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