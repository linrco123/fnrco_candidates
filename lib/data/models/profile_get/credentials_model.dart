class CredentialsModel {
  bool? status;
  String? message;
  List<GetCredential>? credentials;

  CredentialsModel({this.status, this.message, this.credentials});

  CredentialsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      credentials = <GetCredential>[];
      json['data'].forEach((v) {
        credentials!.add(new GetCredential.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.credentials != null) {
      data['data'] = this.credentials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetCredential {
  int? id;
  String? personCredCat;
  String? personCredName;
  String? personCredNumber;
  String? personCredStatus;
  String? personCredIssuedIn;
  String? personCredExpIn;

  GetCredential(
      {this.id,
      this.personCredCat,
      this.personCredName,
      this.personCredNumber,
      this.personCredStatus,
      this.personCredIssuedIn,
      this.personCredExpIn});

  GetCredential.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personCredCat = json['person_cred_cat'];
    personCredName = json['person_cred_name'];
    personCredNumber = json['person_cred_number'];
    personCredStatus = json['person_cred_status'];
    personCredIssuedIn = json['person_cred_issued_in'];
    personCredExpIn = json['person_cred_exp_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['person_cred_cat'] = this.personCredCat;
    data['person_cred_name'] = this.personCredName;
    data['person_cred_number'] = this.personCredNumber;
    data['person_cred_status'] = this.personCredStatus;
    data['person_cred_issued_in'] = this.personCredIssuedIn;
    data['person_cred_exp_in'] = this.personCredExpIn;
    return data;
  }
}