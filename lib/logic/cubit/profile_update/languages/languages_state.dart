part of 'languages_cubit.dart';

@immutable
sealed class LanguagesState {}

final class LanguagesInitial extends LanguagesState {}

class ChangingLanguageLevelState extends LanguagesState{}


class EmptyLanguageFieldsState extends LanguagesState{}


class SubmitLanguagesLoadingState extends LanguagesState{}
class SubmitLanguagesSuccessState extends LanguagesState{}
class SubmitLanguagesErrorState extends LanguagesState{
  final String message;

  SubmitLanguagesErrorState({required this.message});
}

