// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/data/models/management_content/survey_view_model.dart';
import 'package:fnrco_candidates/data/models/management_content/survies_model.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/surveys.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
part 'surveys_state.dart';

class SurveysCubit extends Cubit<SurveysState> {
  SurveysProvider surveysProvider;
  SurveysCubit(
    this.surveysProvider,
  ) : super(SurveysInitial());

 List<Survey> surveys = [];
  void getsurveys() {
    emit(SurveysLoadingState());
    surveysProvider.getSurveys().then((value) {
      surveys.add(value.survey!);
      emit(SurveysSuccessState(surveys: [value.survey!]));
    }).catchError((error) {
      emit(SurveysFailureState(message: error.failure.message));
    });
  }
  final answerCntroller = TextEditingController();
  List<SQuestions> surveyViewQuestions = [];
  List<Map<String, dynamic>> answers = [];
  int question_number = 0;
  int surveyViewID = 0;

  String answer = '';
  void chooseAnswer(String answer) {
    this.answer = answer;
    emit(ChooseAnswerState());
  }

  void getSurveyView(int surveyViewindex) {
    emit(SurveysViewLoadingState());
    surveysProvider.getSurveyView(surveyViewindex).then((value) {
      surveyViewQuestions = value.surveyView!.questions!;
      surveyViewID = value.surveyView!.id!;
      answer = value.surveyView!.questions!.first.options!.first
          .surveyQuestionOptText!;
      emit(SurveysViewSuccessState(
          questions: value.surveyView!.questions!));
    }).catchError((error) {
      emit(SurveysFailureState(message: error.failure.message));
    });
  }

  void submitSurveyViewQuestion(int questionID) {
    if (answer.isNotEmpty || answerCntroller.text.isNotEmpty) {
      if (question_number < surveyViewQuestions.length - 1) {
        addNewAnswer(questionID);
      } else {
        addNewAnswer(questionID); 
        // answer = '';
        sendSurveyView();
      }
    } else {
      emit(PickSurveyAnswerState());
    }
  }

  void sendSurveyView() {
    emit(SubmitSurveyViewLoadingState());
    Map data = {"answers": answers};
    logger.e(data);
    surveysProvider.sendSurveyView(surveyViewID, data).then((value) {
      if (value == true) {
        question_number = 0;
        emit(SubmitSurveyViewSuccessState());
      }
    }).catchError((error) {
      emit(SubmitSurveyViewFailureState());
    });
  }

  void addNewAnswer(int questionID) {
    if (surveyViewQuestions[question_number].surveyQuestionType == 'option') {
      answers.add({
        "survey_question_id": questionID.toString(),
        "survey_answer_text": answer
      });
    } else if (surveyViewQuestions[question_number].surveyQuestionType ==
        "text") {
      answers.add({
        "survey_question_id": questionID.toString(),
        "survey_answer_text": answerCntroller.text
      });
    }
    answerCntroller.clear();
    answer = '';
    if(question_number < surveyViewQuestions.length-1){
        moveTONext();
    }
   
  }

  void moveTONext() {
    question_number++;
    answer = surveyViewQuestions[question_number]
        .options!
        .first
        .surveyQuestionOptText!;
    emit(MoveToNextQuestionsState());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
