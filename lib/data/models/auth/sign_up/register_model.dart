class RegisterModel {
  bool? status;
  String? message;
  Data? data;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  String? candidateUserUname;
  String? email;
  String? accessToken;

  Data({this.id, this.candidateUserUname, this.email, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    candidateUserUname = json['candidate_user_uname'];
    email = json['email'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['candidate_user_uname'] = this.candidateUserUname;
    data['email'] = this.email;
    data['access_token'] = this.accessToken;
    return data;
  }
}