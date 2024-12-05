class LanguagesModel {
  bool? status;
  String? message;
  List<GetLanguage>? languages;

  LanguagesModel({this.status, this.message, this.languages});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      languages = <GetLanguage>[];
      json['data'].forEach((v) {
        languages!.add(new GetLanguage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.languages != null) {
      data['data'] = this.languages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetLanguage {
  int? id;
  String? langText;
  int? langLevel;
  String? langTestBy;

  GetLanguage({this.id, this.langText, this.langLevel, this.langTestBy});

  GetLanguage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    langText = json['lang_text'];
    langLevel = json['lang_level'];
    langTestBy = json['lang_test_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lang_text'] = this.langText;
    data['lang_level'] = this.langLevel;
    data['lang_test_by'] = this.langTestBy;
    return data;
  }
}