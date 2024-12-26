// class SurveyViewModel {
//   bool? status;
//   String? message;
//   List<SurveyView>? surveyViews;

//   SurveyViewModel({this.status, this.message, this.surveyViews});

//   SurveyViewModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       surveyViews = <SurveyView>[];
//       json['data'].forEach((v) {
//         surveyViews!.add(new SurveyView.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.surveyViews != null) {
//       data['data'] = this.surveyViews!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SurveyView {
//   int? id;
//   int? moduleId;
//   String? surveyName;
//   String? surveyDesc;
//   String? surveyBy;
//   String? surveyFrom;
//   String? surveyTo;
//   String? surveyStatus;
//   List<SQuestions>? questions;

//   SurveyView(
//       {this.id,
//       this.moduleId,
//       this.surveyName,
//       this.surveyDesc,
//       this.surveyBy,
//       this.surveyFrom,
//       this.surveyTo,
//       this.surveyStatus,
//       this.questions});

//   SurveyView.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     moduleId = json['module_id'];
//     surveyName = json['survey_name'];
//     surveyDesc = json['survey_desc'];
//     surveyBy = json['survey_by'];
//     surveyFrom = json['survey_from'];
//     surveyTo = json['survey_to'];
//     surveyStatus = json['survey_status'];
//     if (json['questions'] != null) {
//       questions = <SQuestions>[];
//       json['questions'].forEach((v) {
//         questions!.add(new SQuestions.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['module_id'] = this.moduleId;
//     data['survey_name'] = this.surveyName;
//     data['survey_desc'] = this.surveyDesc;
//     data['survey_by'] = this.surveyBy;
//     data['survey_from'] = this.surveyFrom;
//     data['survey_to'] = this.surveyTo;
//     data['survey_status'] = this.surveyStatus;
//     if (this.questions != null) {
//       data['questions'] = this.questions!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SQuestions {
//   int? id;
//   int? surveyId;
//   String? surveyQuestionText;
//   String? surveyQuestionType;
//   List<Options>? options;

//   SQuestions(
//       {this.id,
//       this.surveyId,
//       this.surveyQuestionText,
//       this.surveyQuestionType,
//       this.options});

//   SQuestions.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     surveyId = json['survey_id'];
//     surveyQuestionText = json['survey_question_text'];
//     surveyQuestionType = json['survey_question_type'];
//     if (json['options'] != null) {
//       options = <Options>[];
//       json['options'].forEach((v) {
//         options!.add(new Options.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['survey_id'] = this.surveyId;
//     data['survey_question_text'] = this.surveyQuestionText;
//     data['survey_question_type'] = this.surveyQuestionType;
//     if (this.options != null) {
//       data['options'] = this.options!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Options {
//   int? id;
//   int? surveyQuestionId;
//   String? surveyQuestionOptText;
//   String? surveyQuestionOptDefultValue;

//   Options(
//       {this.id,
//       this.surveyQuestionId,
//       this.surveyQuestionOptText,
//       this.surveyQuestionOptDefultValue});

//   Options.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     surveyQuestionId = json['survey_question_id'];
//     surveyQuestionOptText = json['survey_question_opt_text'];
//     surveyQuestionOptDefultValue = json['survey_question_opt_defult_value'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['survey_question_id'] = this.surveyQuestionId;
//     data['survey_question_opt_text'] = this.surveyQuestionOptText;
//     data['survey_question_opt_defult_value'] =
//         this.surveyQuestionOptDefultValue;
//     return data;
//   }
// }

///////////////////////////////////////////////////////////////////
///


class SurveyViewModel {
  bool? status;
  String? message;
  SurveyView? surveyView;

  SurveyViewModel({this.status, this.message, this.surveyView});

  SurveyViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    surveyView = json['data'] != null ? new SurveyView.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.surveyView != null) {
      data['data'] = this.surveyView!.toJson();
    }
    return data;
  }
}

class SurveyView {
  int? id;
  int? moduleId;
  String? surveyName;
  String? surveyDesc;
  String? surveyBy;
  String? surveyFrom;
  String? surveyTo;
  String? surveyStatus;
  List<SQuestions>? questions;

  SurveyView(
      {this.id,
      this.moduleId,
      this.surveyName,
      this.surveyDesc,
      this.surveyBy,
      this.surveyFrom,
      this.surveyTo,
      this.surveyStatus,
      this.questions});

  SurveyView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    surveyName = json['survey_name'];
    surveyDesc = json['survey_desc'];
    surveyBy = json['survey_by'];
    surveyFrom = json['survey_from'];
    surveyTo = json['survey_to'];
    surveyStatus = json['survey_status'];
    if (json['questions'] != null) {
      questions = <SQuestions>[];
      json['questions'].forEach((v) {
        questions!.add(new SQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_id'] = this.moduleId;
    data['survey_name'] = this.surveyName;
    data['survey_desc'] = this.surveyDesc;
    data['survey_by'] = this.surveyBy;
    data['survey_from'] = this.surveyFrom;
    data['survey_to'] = this.surveyTo;
    data['survey_status'] = this.surveyStatus;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SQuestions {
  int? id;
  int? surveyId;
  String? surveyQuestionText;
  String? surveyQuestionType;
  List<Options>? options;

  SQuestions(
      {this.id,
      this.surveyId,
      this.surveyQuestionText,
      this.surveyQuestionType,
      this.options});

  SQuestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surveyId = json['survey_id'];
    surveyQuestionText = json['survey_question_text'];
    surveyQuestionType = json['survey_question_type'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['survey_id'] = this.surveyId;
    data['survey_question_text'] = this.surveyQuestionText;
    data['survey_question_type'] = this.surveyQuestionType;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  int? surveyQuestionId;
  String? surveyQuestionOptText;
  String? surveyQuestionOptDefultValue;

  Options(
      {this.id,
      this.surveyQuestionId,
      this.surveyQuestionOptText,
      this.surveyQuestionOptDefultValue});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surveyQuestionId = json['survey_question_id'];
    surveyQuestionOptText = json['survey_question_opt_text'];
    surveyQuestionOptDefultValue = json['survey_question_opt_defult_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['survey_question_id'] = this.surveyQuestionId;
    data['survey_question_opt_text'] = this.surveyQuestionOptText;
    data['survey_question_opt_defult_value'] =
        this.surveyQuestionOptDefultValue;
    return data;
  }
}


