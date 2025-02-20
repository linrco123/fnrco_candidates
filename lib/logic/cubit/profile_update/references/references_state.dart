part of 'references_cubit.dart';

@immutable
sealed   class  KeyWordsState {}

final   class  KeyWordsInitial extends KeyWordsState {}

final class  EmptyKeywordFieldsState extends KeyWordsState{}

final class  SubmitKeyWordsLoadingState extends KeyWordsState{}

final class  SubmitKeyWordsSuccessState extends KeyWordsState{}

final class  SubmitKeyWordsFailureState extends KeyWordsState{
  final String message;

  SubmitKeyWordsFailureState({required this.message});
}
