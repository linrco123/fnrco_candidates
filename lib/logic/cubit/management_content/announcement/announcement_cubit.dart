// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/announcement.dart';
import 'package:fnrco_candidates/data/models/management_content/announcement_model.dart';
 import 'package:meta/meta.dart';
part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementProvider announcementProvider;
  AnnouncementCubit(
    this.announcementProvider,
  ) : super(AnnouncementInitial());

  void getAnnouncements() {
    emit(AnnouncementLoadingState());
    announcementProvider.getAnnouncements().then((value) {
      emit(AnnouncementSuccessState(announcements: value.announcements!));
    }).catchError((error) {
      emit(AnnouncementFailureState(message: error.failure.message));
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

