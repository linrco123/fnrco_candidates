part of 'key_words_cubit.dart';

@immutable
sealed class KeyWordsState {}

final class KeyWordsInitial extends KeyWordsState {}

class EmptyKeywordFieldsState extends KeyWordsState{}

class SubmitKeyWordsLoadingState extends KeyWordsState{}

class SubmitKeyWordsSuccessState extends KeyWordsState{}

class SubmitKeyWordsFailureState extends KeyWordsState{
  final String message;

  SubmitKeyWordsFailureState({required this.message});
}
