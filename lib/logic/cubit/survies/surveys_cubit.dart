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

  void getsurveys() {
    List<Survey> surveys = [];
    emit(SurveysLoadingState());
    surveysProvider.getSurveys().then((value) {
      surveys.addAll(value!.surveys!);
      emit(SurveysSuccessState(surveys: surveys));
    }).catchError((error) {
      emit(SurveysFailureState(message: error.failure.message));
    });
  }

  List<Questions> surveyViewQuestions = [];
  List<Map<String, dynamic>> answers = [];
  int question_number = 0;
  int surveyViewID = 0;

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

  void addNewAnswer(int questionID, String answer) {
    answers.add({
      "survay_question_id": questionID.toString(),
      "survay_answer_text": answer
    });
  }
  void moveTONext(){
    question_number++;
    emit(MoveToNextQuestionsState());
  }
  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
