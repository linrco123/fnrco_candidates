part of 'achievements_cubit.dart';

@immutable
sealed class AchievementsState {}

final class AchievementsInitial extends AchievementsState {}

final class EmptyAchievementsFieldsState extends AchievementsState {}

final class SubmitAchievementsLoadingState extends AchievementsState {}

final class SubmitAchievementsSuccessState extends AchievementsState {}

final class SubmitAchievementsFailureState extends AchievementsState {
  final String message;

  SubmitAchievementsFailureState({required this.message});
}


