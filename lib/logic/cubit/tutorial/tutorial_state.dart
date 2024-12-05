part of 'tutorial_cubit.dart';

@immutable
sealed class TutorialState {}

final class TutorialInitial extends TutorialState {}

class TutorialLoadingState extends TutorialState {}

class TutorialSuccessState extends TutorialState {
  final List<Tutorial> tutorials;

  TutorialSuccessState({required this.tutorials});
}

class TutorialFailureState extends TutorialState {
  final String message;

  TutorialFailureState({required this.message});
}
