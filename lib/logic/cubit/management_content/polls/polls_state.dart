part of 'polls_cubit.dart';

@immutable
sealed   class  PollsState {}

final   class  PollsInitial extends PollsState {}

final   class  PollsLoadingState extends PollsState {}

final   class  PollsSuccessState extends PollsState {
  final List<Poll> polls;

  PollsSuccessState({required this.polls});
}

final   class  PollsFailureState extends PollsState {
  final String message;

  PollsFailureState({required this.message});
}

final class  PollsViewLoadingState extends PollsState {}

final class  PollsViewSuccessState extends PollsState {
  final List<String> questions;

  PollsViewSuccessState({required this.questions});
}

final class  PollsViewFailureState extends PollsState {
  final String message;

  PollsViewFailureState({required this.message});
}

final class  MoveToNextQuestionsState extends PollsState {}

final class  ChooseAnswerState extends PollsState {}

final class  SubmitPollViewLoadingState extends PollsState {}

final class  SubmitPollViewSuccessState extends PollsState {
  final VotePercentages votePercentages;
  final String question;

  SubmitPollViewSuccessState(
      {required this.question, required this.votePercentages});
}

final class  SubmitPollViewFailureState extends PollsState {
  final String message;

  SubmitPollViewFailureState({required this.message});
}

final class  PickPollAnswerState extends PollsState {}
