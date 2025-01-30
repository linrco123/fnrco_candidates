class AppOverviewModel {
  bool? status;
  String? message;
  OverviewData? overviewData;

  AppOverviewModel({this.status, this.message, this.overviewData});

  AppOverviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    overviewData = json['data'] != null ? new OverviewData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.overviewData != null) {
      data['data'] = this.overviewData!.toJson();
    }
    return data;
  }
}

class OverviewData {
  int? candidateAppId;
  int? candidateId;
  String? clientName;
  String? positionName;
  String? positionContractType;
  String? positionContractDuration;
  String? positionVacationDetails;
  String? positionWorkHour;
  String? positionInsurance;
  String? agencyName;
  String? agencyAddress;
  String? agencyContactName;
  String? agencyContactNbspPhone;

  OverviewData(
      {this.candidateAppId,
      this.candidateId,
      this.clientName,
      this.positionName,
      this.positionContractType,
      this.positionContractDuration,
      this.positionVacationDetails,
      this.positionWorkHour,
      this.positionInsurance,
      this.agencyName,
      this.agencyAddress,
      this.agencyContactName,
      this.agencyContactNbspPhone});

  OverviewData.fromJson(Map<String, dynamic> json) {
    candidateAppId = json['candidate_app_id'];
    candidateId = json['candidate_id'];
    clientName = json['client_name'];
    positionName = json['Position_name'];
    positionContractType = json['Position_contract_type'];
    positionContractDuration = json['Position_contract_duration'];
    positionVacationDetails = json['Position_vacation_details'];
    positionWorkHour = json['Position_work_hour'];
    positionInsurance = json['Position_insurance'];
    agencyName = json['agency_name'];
    agencyAddress = json['agency_address'];
    agencyContactName = json['agency_contact_name'];
    agencyContactNbspPhone = json['agency_contact_nbsp_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_app_id'] = this.candidateAppId;
    data['candidate_id'] = this.candidateId;
    data['client_name'] = this.clientName;
    data['Position_name'] = this.positionName;
    data['Position_contract_type'] = this.positionContractType;
    data['Position_contract_duration'] = this.positionContractDuration;
    data['Position_vacation_details'] = this.positionVacationDetails;
    data['Position_work_hour'] = this.positionWorkHour;
    data['Position_insurance'] = this.positionInsurance;
    data['agency_name'] = this.agencyName;
    data['agency_address'] = this.agencyAddress;
    data['agency_contact_name'] = this.agencyContactName;
    data['agency_contact_nbsp_phone'] = this.agencyContactNbspPhone;
    return data;
  }
}