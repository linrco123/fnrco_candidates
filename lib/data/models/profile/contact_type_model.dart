class ContactTypeModel {
  bool? status;
  String? message;
  List<ContactType>? contactsType;

  ContactTypeModel({this.status, this.message, this.contactsType});

  ContactTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      contactsType = <ContactType>[];
      json['data'].forEach((v) {
        contactsType!.add(new ContactType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.contactsType != null) {
      data['data'] = this.contactsType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactType {
  int? id;
  String? metaDataText;

  ContactType({this.id, this.metaDataText});

  ContactType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metaDataText = json['meta_data_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meta_data_text'] = this.metaDataText;
    return data;
  }
}