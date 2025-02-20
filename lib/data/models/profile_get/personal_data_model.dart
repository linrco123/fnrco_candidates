class PersonalDataModel {
  bool? status;
  String? message;
  List<GetPData>? personalData;

  PersonalDataModel({this.status, this.message, this.personalData});

  PersonalDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      personalData = <GetPData>[];
      json['data'].forEach((v) {
        personalData!.add(new GetPData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.personalData != null) {
      data['data'] = this.personalData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPData {
  int? id;
  String? personFirstName;
  String? personSecondName;
  String? personThirdName;
  String? personSurName;
  String? personGender;
  String? personMartialStatus;
  String? personHeight;
  String? personHeightUnit;
  String? personDob;
  String? personWeight;
  String? personNationality;
  String? personCountryResidency;
  String? personWeightUnit;
  String? personOriginalCv;
  Email? email;

  GetPData(
      {this.id,
      this.personFirstName,
      this.personSecondName,
      this.personThirdName,
      this.personSurName,
      this.personGender,
      this.personMartialStatus,
      this.personHeight,
      this.personHeightUnit,
      this.personDob,
      this.personWeight,
      this.personNationality,
      this.personCountryResidency,
      this.personWeightUnit,
      this.personOriginalCv,
      this.email});

  GetPData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personFirstName = json['person_first_name'];
    personSecondName = json['person_second_name'];
    personThirdName = json['person_third_name'];
    personSurName = json['person_sur_name'];
    personGender = json['person_gender'];
    personMartialStatus = json['person_martial_status'];
    personHeight = json['person_height'];
    personHeightUnit = json['person_height_unit'];
    personDob = json['person_dob'];
    personWeight = json['person_weight'];
    personNationality = json['person_nationality'];
    personCountryResidency = json['person_country_residency'];
    personWeightUnit = json['person_weight_unit'];
    personOriginalCv = json['person_original_cv'];
    email = json['email'] != null ? new Email.fromJson(json['email']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['person_first_name'] = this.personFirstName;
    data['person_second_name'] = this.personSecondName;
    data['person_third_name'] = this.personThirdName;
    data['person_sur_name'] = this.personSurName;
    data['person_gender'] = this.personGender;
    data['person_martial_status'] = this.personMartialStatus;
    data['person_height'] = this.personHeight;
    data['person_height_unit'] = this.personHeightUnit;
    data['person_dob'] = this.personDob;
    data['person_weight'] = this.personWeight;
    data['person_nationality'] = this.personNationality;
    data['person_country_residency'] = this.personCountryResidency;
    data['person_weight_unit'] = this.personWeightUnit;
    data['person_original_cv'] = this.personOriginalCv;
    if (this.email != null) {
      data['email'] = this.email!.toJson();
    }
    return data;
  }
}

class Email {
  int? id;
  int? personId;
  String? candidateUserUname;
  String? email;
  String? accessToken;
  int? code;

  Email(
      {this.id,
      this.personId,
      this.candidateUserUname,
      this.email,
      this.accessToken,
      this.code});

  Email.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personId = json['person_id'];
    candidateUserUname = json['candidate_user_uname'];
    email = json['email'];
    accessToken = json['access_token'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['person_id'] = this.personId;
    data['candidate_user_uname'] = this.candidateUserUname;
    data['email'] = this.email;
    data['access_token'] = this.accessToken;
    data['code'] = this.code;
    return data;
  }
}