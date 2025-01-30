part of 'languages_cubit.dart';

@immutable
sealed   class  LanguagesState {}

final   class  LanguagesInitial extends LanguagesState {}

final class  ChangingLanguageLevelState extends LanguagesState{}


final class  EmptyLanguageFieldsState extends LanguagesState{}


final class  SubmitLanguagesLoadingState extends LanguagesState{}
final class  SubmitLanguagesSuccessState extends LanguagesState{}
final class  SubmitLanguagesErrorState extends LanguagesState{
  final String message;

  SubmitLanguagesErrorState({required this.message});
}

