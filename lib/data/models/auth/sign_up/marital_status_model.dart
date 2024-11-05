class MaritalStatusModel {
  bool? status;
  String? message;
  List<MaritalStatus>? data;

  MaritalStatusModel({this.status, this.message, this.data});

  MaritalStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MaritalStatus>[];
      json['data'].forEach((v) {
        data!.add(new MaritalStatus.fromJson(v));
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

class MaritalStatus {
  int? id;
  String? metaDataText;

  MaritalStatus({this.id, this.metaDataText});

  MaritalStatus.fromJson(Map<String, dynamic> json) {
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