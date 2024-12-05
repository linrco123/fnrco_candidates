import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_notes_state.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit() : super(GetNotesInitial());
}
