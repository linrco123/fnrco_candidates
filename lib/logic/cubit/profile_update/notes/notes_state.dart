part of 'notes_cubit.dart';

@immutable
sealed   class  NotesState {}

final   class  NotesInitial extends NotesState {}
final class  EmptyNotesFieldsState  extends NotesState {}


final class  SubmitNotesLoadingState extends NotesState{}

final class  SubmitNotesSuccessState extends NotesState{}

final class  SubmitNotesFailureState extends NotesState{
  final String message;

  SubmitNotesFailureState({required this.message});
}