class AirTicketModel {
  bool? status;
  String? message;
  List<AirTicketApplication>? applications;
  int? size;
  int? page;
  int? totalPages;
  int? totalSize;
  int? perPage;

  AirTicketModel(
      {this.status,
      this.message,
      this.applications,
      this.size,
      this.page,
      this.totalPages,
      this.totalSize,
      this.perPage});

  AirTicketModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      applications = <AirTicketApplication>[];
      json['data'].forEach((v) {
        applications!.add(new AirTicketApplication.fromJson(v));
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

class AirTicketApplication {
  int? id;
  String? mprNo;
  String? mprType;
  String? position;
  String? clientName;
  String? candidateNationality;
  String? candidateName;
  String? isAction;
  AirPipeline? pipeline;

  AirTicketApplication(
      {this.id,
      this.mprNo,
      this.mprType,
      this.position,
      this.clientName,
      this.candidateNationality,
      this.candidateName,
      this.isAction,
      this.pipeline});

  AirTicketApplication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mprNo = json['mpr_no'];
    mprType = json['mpr_type'];
    position = json['Position'];
    clientName = json['client_name'];
    candidateNationality = json['candidate_nationality'];
    candidateName = json['candidate_name'];
    isAction = json['is_action'];
    pipeline = json['pipeline'] != null
        ? new AirPipeline.fromJson(json['pipeline'])
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
    return data;
  }
}

class AirPipeline {
  String? airlineTicketIn;
  String? airlineTicketNumber;
  String? airlines;
  String? flightNumber;
  String? departureFrom;
  String? departureDate;
  String? departureTime;
  String? arrivalAt;
  String? arrivalDate;
  String? arrivalTime;
  String? airlineTicketStatus;
  String? remarks;

  AirPipeline(
      {this.airlineTicketIn,
      this.airlineTicketNumber,
      this.airlines,
      this.flightNumber,
      this.departureFrom,
      this.departureDate,
      this.departureTime,
      this.arrivalAt,
      this.arrivalDate,
      this.arrivalTime,
      this.airlineTicketStatus,
      this.remarks});

  AirPipeline.fromJson(Map<String, dynamic> json) {
    airlineTicketIn = json['airline_ticket_in'];
    airlineTicketNumber = json['airline_ticket_number'];
    airlines = json['airlines'];
    flightNumber = json['flight_number'];
    departureFrom = json['departure_from'];
    departureDate = json['departure_date'];
    departureTime = json['departure_time'];
    arrivalAt = json['arrival_at'];
    arrivalDate = json['arrival_date'];
    arrivalTime = json['arrival_time'];
    airlineTicketStatus = json['airline_ticket_status'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['airline_ticket_in'] = this.airlineTicketIn;
    data['airline_ticket_number'] = this.airlineTicketNumber;
    data['airlines'] = this.airlines;
    data['flight_number'] = this.flightNumber;
    data['departure_from'] = this.departureFrom;
    data['departure_date'] = this.departureDate;
    data['departure_time'] = this.departureTime;
    data['arrival_at'] = this.arrivalAt;
    data['arrival_date'] = this.arrivalDate;
    data['arrival_time'] = this.arrivalTime;
    data['airline_ticket_status'] = this.airlineTicketStatus;
    data['remarks'] = this.remarks;
    return data;
  }
}
