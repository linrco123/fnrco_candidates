class UiWidgetModel {
  bool? status;
  String? message;
  Data? data;

  UiWidgetModel({this.status, this.message, this.data});

  UiWidgetModel.fromJson(Map<String, dynamic> json) {
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
  List<Supporting>? supporting;

  Data({this.supporting});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Supporting'] != null) {
      supporting = <Supporting>[];
      json['Supporting'].forEach((v) {
        supporting!.add(new Supporting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supporting != null) {
      data['Supporting'] = this.supporting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Supporting {
  int? id;
  int? uiWidgetBy;
  String? uiWidgetName;
  String? status;
  int? code;
  String? descreption;
  String? classification;
  String? icon;
  bool? isShow;

  Supporting(
      {this.id,
      this.uiWidgetBy,
      this.uiWidgetName,
      this.status,
      this.code,
      this.descreption,
      this.classification,
      this.icon,
      this.isShow});

  Supporting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uiWidgetBy = json['ui_widget_by'];
    uiWidgetName = json['ui_widget_name'];
    status = json['status'];
    code = json['code'];
    descreption = json['descreption'];
    classification = json['classification'];
    icon = json['icon'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ui_widget_by'] = this.uiWidgetBy;
    data['ui_widget_name'] = this.uiWidgetName;
    data['status'] = this.status;
    data['code'] = this.code;
    data['descreption'] = this.descreption;
    data['classification'] = this.classification;
    data['icon'] = this.icon;
    data['is_show'] = this.isShow;
    return data;
  }
}