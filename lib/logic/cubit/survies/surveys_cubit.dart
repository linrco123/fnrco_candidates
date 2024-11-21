// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/data/models/management_content/survey_view_model.dart';
import 'package:fnrco_candidates/data/models/management_content/survies_model.dart';
import 'package:meta/meta.dart';
import 'package:fnrco_candidates/data/api_provider/management_contect/surveys.dart';
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
      surveys.addAll(value!.surveys!);
      emit(SurveysSuccessState(surveys: value.surveys!));
    }).catchError((error) {
      emit(SurveysFailureState(message: error.failure.message));
    });
  }

  List<Questions> surveyViewQuestions = [];
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
      surveyViewQuestions = value!.surveyViews!.first.questions!;
      surveyViewID = value.surveyViews!.first.id!;
      emit(SurveysViewSuccessState(
          questions: value.surveyViews!.first.questions!));
    }).catchError((error) {
      emit(SurveysFailureState(message: error.failure.message));
    });
  }

  void submitSurveyViewQuestion(int questionID) {
    if (answer.isNotEmpty) {
      if (question_number < surveyViewQuestions.length - 1) {
      addNewAnswer(questionID);
    } else {
      answers.add({
        "survey_question_id": questionID.toString(),
        "survey_answer_text": answer
      });
     // answer = '';
      sendSurveyView();
    }
    }else{
      emit(PickSurveyAnswerState());
    }
  }

  void sendSurveyView() {
    emit(SubmitSurveyViewLoadingState());
    Map data = {"answers": answers};
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
    answers.add({
      "survey_question_id": questionID.toString(),
      "survey_answer_text": answer
    });
    answer = '';

    moveTONext();
  }

  void moveTONext() {
    question_number++;
    emit(MoveToNextQuestionsState());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
