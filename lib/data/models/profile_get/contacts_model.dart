class ContactsModel {
  bool? status;
  String? message;
  List<GetContact>? contacts;

  ContactsModel({this.status, this.message, this.contacts});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      contacts = <GetContact>[];
      json['data'].forEach((v) {
        contacts!.add(new GetContact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.contacts != null) {
      data['data'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetContact {
  int? id;
  String? personContactType;
  String? personContactValue;
  String? personContactPrimary;

  GetContact(
      {this.id,
      this.personContactType,
      this.personContactValue,
      this.personContactPrimary});

  GetContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personContactType = json['person_contact_type'];
    personContactValue = json['person_contact_value'];
    personContactPrimary = json['person_contact_primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['person_contact_type'] = this.personContactType;
    data['person_contact_value'] = this.personContactValue;
    data['person_contact_primary'] = this.personContactPrimary;
    return data;
  }
}