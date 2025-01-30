part of 'surveys_cubit.dart';

@immutable
sealed   class  SurveysState {}

  final class  SurveysInitial extends SurveysState {}

  final class  SurveysLoadingState extends SurveysState {}

  final class  SurveysSuccessState extends SurveysState {
  final List<Survey> surveys;

  SurveysSuccessState({required this.surveys});
}

  final class  SurveysFailureState extends SurveysState {
  final String message;

  SurveysFailureState({required this.message});
}

final class  SurveysViewLoadingState extends SurveysState {}

final class  SurveysViewSuccessState extends SurveysState {
  final List<SQuestions> questions;

  SurveysViewSuccessState({required this.questions});
}

final class  SurveysViewFailureState extends SurveysState {
  final String message;

  SurveysViewFailureState({required this.message});
} 


final class  MoveToNextQuestionsState extends SurveysState{}
final class  ChooseAnswerState extends SurveysState{
}

final class  SubmitSurveyViewLoadingState extends SurveysState{}
final class  SubmitSurveyViewSuccessState extends SurveysState{}
final class  SubmitSurveyViewFailureState extends SurveysState{}


final class  PickSurveyAnswerState extends SurveysState{}