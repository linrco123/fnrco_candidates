part of 'achievements_cubit.dart';

@immutable
sealed class AchievementsState {}

final class AchievementsInitial extends AchievementsState {}

final class EmptyAchievementsFieldsState extends AchievementsState {}

class SubmitAchievementsLoadingState extends AchievementsState {}

class SubmitAchievementsSuccessState extends AchievementsState {}

class SubmitAchievementsFailureState extends AchievementsState {
  final String message;

  SubmitAchievementsFailureState({required this.message});
}


