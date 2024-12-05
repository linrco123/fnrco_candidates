part of 'notes_cubit.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}
class EmptyNotesFieldsState  extends NotesState {}


class SubmitNotesLoadingState extends NotesState{}

class SubmitNotesSuccessState extends NotesState{}

class SubmitNotesFailureState extends NotesState{
  final String message;

  SubmitNotesFailureState({required this.message});
}