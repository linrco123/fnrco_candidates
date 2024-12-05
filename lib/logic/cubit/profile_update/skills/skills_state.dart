part of 'skills_cubit.dart';

@immutable
sealed class SkillsState {}

final class SkillsInitial extends SkillsState {}


final class ChooseSkillLevelState extends SkillsState{}
final class CheckSkillLevelState extends SkillsState{}


final class GettingSkillsLevelLoadingState extends SkillsState{}
final class GettingSkillsLevelSuccessState extends SkillsState{
  final List<Skill> skills;
  GettingSkillsLevelSuccessState(this.skills);
}
final class GettingSkillsLevelErrorState extends SkillsState{
  final String message;

  GettingSkillsLevelErrorState({required this.message});
}


final class SubmitSkillsLoadingState extends SkillsState{}
final class SubmitSkillsSuccessState extends SkillsState{}
final class SubmitSkillsFailureState extends SkillsState{
  final String? message;

  SubmitSkillsFailureState({ this.message});
}


final class EmptySkillLevelstate extends SkillsState{}