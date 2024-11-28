part of 'polls_cubit.dart';

@immutable
sealed class PollsState {}

final class PollsInitial extends PollsState {}



final class PollsLoadingState extends PollsState {}

final class PollsSuccessState extends PollsState {
  final List<Poll> polls;

  PollsSuccessState({required this.polls});
}

final class PollsFailureState extends PollsState {
  final String message;

  PollsFailureState({required this.message});
}

class PollsViewLoadingState extends PollsState {}

class PollsViewSuccessState extends PollsState {
  final List<PQuestion> questions;

  PollsViewSuccessState({required this.questions});
}

class PollsViewFailureState extends PollsState {
  final String message;

  PollsViewFailureState({required this.message});
} 


class MoveToNextQuestionsState extends PollsState{}
class ChooseAnswerState extends PollsState{
}

class SubmitPollViewLoadingState extends PollsState{}
class SubmitPollViewSuccessState extends PollsState{}
class SubmitPollViewFailureState extends PollsState{}


class PickPollAnswerState extends PollsState{}
