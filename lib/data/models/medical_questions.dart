class MedicalQuestionsModel {
  bool? status;
  String? message;
  List<MedicalQuestion>? data;

  MedicalQuestionsModel({this.status, this.message, this.data});

  MedicalQuestionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MedicalQuestion>[];
      json['data'].forEach((v) {
        data!.add(new MedicalQuestion.fromJson(v));
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

class MedicalQuestion {
  int? id;
  String? type;
  String? nameAr;
  String? nameEn;

  MedicalQuestion({this.id, this.type, this.nameAr, this.nameEn});

  MedicalQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    return data;
  }
}