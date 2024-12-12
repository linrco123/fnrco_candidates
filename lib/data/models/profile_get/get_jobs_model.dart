class GetJobsModel {
  bool? status;
  String? message;
  List<GetJob>? data;

  GetJobsModel({this.status, this.message, this.data});

  GetJobsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetJob>[];
      json['data'].forEach((v) {
        data!.add(new GetJob.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetJob {
  int? id;
  int? erpMprId;
  ErpMprItemId? erpMprItemId;

  GetJob({this.id, this.erpMprId, this.erpMprItemId});

  GetJob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    erpMprId = json['erp_mpr_id'];
    erpMprItemId = json['erp_mpr_item_id'] != null
        ? new ErpMprItemId.fromJson(json['erp_mpr_item_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['erp_mpr_id'] = this.erpMprId;
    if (this.erpMprItemId != null) {
      data['erp_mpr_item_id'] = this.erpMprItemId!.toJson();
    }
    return data;
  }
}

class ErpMprItemId {
  int? id;
  String? position;
  String? erpMprItemWorkingHours;
  String? erpMprItemPositionGender;
  String? erpMprItemContractDuration;
  String? erpMprItemSalary;
  String? erpMprItemWorkLocation;
  String? erpMprItemYearsOfExperience;
  String? erpMprItemAgePreference;
  String? erpMprItemRemarks;
  String? erpMprItemWorkforceCategory;
  String? erpMprItemRequirementType;
  String? erpMprItemOverTime;
  String? erpMprItemVacationDetails;
  String? erpMprItemContractCostType;
  String? erpMprItemStatus;
  String? erpMprItemQty;
  String? erpMprItemCandidateName;
  String? erpMprItemOverTimeDisplay;
  String? erpMprItemSalaryDisplay;
  String? erpMprItemClientDisplay;
  String? erpMprItemSectorDisplay;

  ErpMprItemId(
      {this.id,
      this.position,
      this.erpMprItemWorkingHours,
      this.erpMprItemPositionGender,
      this.erpMprItemContractDuration,
      this.erpMprItemSalary,
      this.erpMprItemWorkLocation,
      this.erpMprItemYearsOfExperience,
      this.erpMprItemAgePreference,
      this.erpMprItemRemarks,
      this.erpMprItemWorkforceCategory,
      this.erpMprItemRequirementType,
      this.erpMprItemOverTime,
      this.erpMprItemVacationDetails,
      this.erpMprItemContractCostType,
      this.erpMprItemStatus,
      this.erpMprItemQty,
      this.erpMprItemCandidateName,
      this.erpMprItemOverTimeDisplay,
      this.erpMprItemSalaryDisplay,
      this.erpMprItemClientDisplay,
      this.erpMprItemSectorDisplay});

  ErpMprItemId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    erpMprItemWorkingHours = json['erp_mpr_item_working_hours'];
    erpMprItemPositionGender = json['erp_mpr_item_position_gender'];
    erpMprItemContractDuration = json['erp_mpr_item_contract_duration'];
    erpMprItemSalary = json['erp_mpr_item_salary'];
    erpMprItemWorkLocation = json['erp_mpr_item_work_location'];
    erpMprItemYearsOfExperience = json['erp_mpr_item_years_of_experience'];
    erpMprItemAgePreference = json['erp_mpr_item_age_preference'];
    erpMprItemRemarks = json['erp_mpr_item_remarks'];
    erpMprItemWorkforceCategory = json['erp_mpr_item_workforce_category'];
    erpMprItemRequirementType = json['erp_mpr_item_requirement_type'];
    erpMprItemOverTime = json['erp_mpr_item_over_time'];
    erpMprItemVacationDetails = json['erp_mpr_item_vacation_details'];
    erpMprItemContractCostType = json['erp_mpr_item_contract_cost_type'];
    erpMprItemStatus = json['erp_mpr_item_status'];
    erpMprItemQty = json['erp_mpr_item_qty'];
    erpMprItemCandidateName = json['erp_mpr_item_candidate_name'];
    erpMprItemOverTimeDisplay = json['erp_mpr_item_over_time_display'];
    erpMprItemSalaryDisplay = json['erp_mpr_item_salary_display'];
    erpMprItemClientDisplay = json['erp_mpr_item_client_display'];
    erpMprItemSectorDisplay = json['erp_mpr_item_sector_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position'] = this.position;
    data['erp_mpr_item_working_hours'] = this.erpMprItemWorkingHours;
    data['erp_mpr_item_position_gender'] = this.erpMprItemPositionGender;
    data['erp_mpr_item_contract_duration'] = this.erpMprItemContractDuration;
    data['erp_mpr_item_salary'] = this.erpMprItemSalary;
    data['erp_mpr_item_work_location'] = this.erpMprItemWorkLocation;
    data['erp_mpr_item_years_of_experience'] = this.erpMprItemYearsOfExperience;
    data['erp_mpr_item_age_preference'] = this.erpMprItemAgePreference;
    data['erp_mpr_item_remarks'] = this.erpMprItemRemarks;
    data['erp_mpr_item_workforce_category'] = this.erpMprItemWorkforceCategory;
    data['erp_mpr_item_requirement_type'] = this.erpMprItemRequirementType;
    data['erp_mpr_item_over_time'] = this.erpMprItemOverTime;
    data['erp_mpr_item_vacation_details'] = this.erpMprItemVacationDetails;
    data['erp_mpr_item_contract_cost_type'] = this.erpMprItemContractCostType;
    data['erp_mpr_item_status'] = this.erpMprItemStatus;
    data['erp_mpr_item_qty'] = this.erpMprItemQty;
    data['erp_mpr_item_candidate_name'] = this.erpMprItemCandidateName;
    data['erp_mpr_item_over_time_display'] = this.erpMprItemOverTimeDisplay;
    data['erp_mpr_item_salary_display'] = this.erpMprItemSalaryDisplay;
    data['erp_mpr_item_client_display'] = this.erpMprItemClientDisplay;
    data['erp_mpr_item_sector_display'] = this.erpMprItemSectorDisplay;
    return data;
  }
}