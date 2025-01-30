part of 'tutorial_cubit.dart';

@immutable
sealed   class  TutorialState {}

final   class  TutorialInitial extends TutorialState {}

final class  TutorialLoadingState extends TutorialState {}

final class  TutorialSuccessState extends TutorialState {
  final List<Tutorial> tutorials;

  TutorialSuccessState({required this.tutorials});
}

final class  TutorialFailureState extends TutorialState {
  final String message;

  TutorialFailureState({required this.message});
}
