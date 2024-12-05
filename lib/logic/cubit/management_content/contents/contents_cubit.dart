import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/data/models/management_content/contents_model.dart';
import 'package:meta/meta.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/contents.dart';
part 'contents_state.dart';

class ContentsCubit extends Cubit<ContentsState> {
  ContentsProvider contentsProvider;
  ContentsCubit(
    this.contentsProvider,
  ) : super(ContentsInitial());
   void getContents() {
    emit(ContentsLoadingState());
    contentsProvider.getContents().then((value) {
      emit(ContentsSuccessState(contents: value.contents!));
    }).catchError((error) {
      emit(ContentsFailureState(message: error.failure.message));
    });
  }

  // void chooseAnswer(String answer) {
  //   this.answer = answer;
  //   emit(ChooseAnswerState());
  // }

  // void getSurveyView(int surveyViewindex) {
  //   emit(SurveysViewLoadingState());
  //   surveysProvider.getSurveyView(surveyViewindex).then((value) {
  //     surveyViewQuestions = value!.surveyViews!.first.questions!;
  //     surveyViewID = value.surveyViews!.first.id!;
  //     answer = value.surveyViews!.first.questions!.first.options!.first
  //         .surveyQuestionOptText!;
  //     emit(SurveysViewSuccessState(
  //         questions: value.surveyViews!.first.questions!));
  //   }).catchError((error) {
  //     emit(SurveysFailureState(message: error.failure.message));
  //   });
  // }


  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

}
