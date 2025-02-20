class ReferencesModel {
  bool? status;
  String? message;
  List<GetReference>? references;

  ReferencesModel({this.status, this.message, this.references});

  ReferencesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      references = <GetReference>[];
      json['data'].forEach((v) {
        references!.add(new GetReference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.references != null) {
      data['data'] = this.references!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetReference{
  int? id;
  String? jobTitle;
  String? company;
  String? name;
  String? email;
  String? phone;

  GetReference(
      {this.id,
      this.jobTitle,
      this.company,
      this.name,
      this.email,
      this.phone});

  GetReference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['job_title'];
    company = json['company'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_title'] = this.jobTitle;
    data['company'] = this.company;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}