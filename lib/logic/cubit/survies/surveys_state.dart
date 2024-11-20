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
  final List<Questions> questions;

  SurveysViewSuccessState({required this.questions});
}

class SurveysViewFailureState extends SurveysState {
  final String message;

  SurveysViewFailureState({required this.message});
} 


class MoveToNextQuestionsState extends SurveysState{}
