part of 'surveys_cubit.dart';

@immutable
sealed class SurveysState {}

final class SurveysInitial extends SurveysState {}

final class SurveysLoadingState extends SurveysState {}

final class SurveysSuccessState extends SurveysState {
  final List<Survey> surveys;

  SurveysSuccessState({required this.surveys});
}

final class SurveysFailureState extends SurveysState {
  final String message;

  SurveysFailureState({required this.message});
}

class SurveysViewLoadingState extends SurveysState {}

class SurveysViewSuccessState extends SurveysState {
  final List<SQuestions> questions;

  SurveysViewSuccessState({required this.questions});
}

class SurveysViewFailureState extends SurveysState {
  final String message;

  SurveysViewFailureState({required this.message});
} 


class MoveToNextQuestionsState extends SurveysState{}
class ChooseAnswerState extends SurveysState{
}

class SubmitSurveyViewLoadingState extends SurveysState{}
class SubmitSurveyViewSuccessState extends SurveysState{}
class SubmitSurveyViewFailureState extends SurveysState{}


class PickSurveyAnswerState extends SurveysState{}