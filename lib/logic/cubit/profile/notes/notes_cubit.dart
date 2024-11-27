// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/notes.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesProvider notesProvider;
  NotesCubit(
    this.notesProvider,
  ) : super(NotesInitial());


  var formKey = GlobalKey<FormState>();
  final TextEditingController notCntroller = TextEditingController();

  String? validateNotes(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_notes");
    }
    return null;
  }

  List<Map<String, dynamic>> submittedNotes = [];
  void addNewNotes() {
    if (formKey.currentState!.validate()) {
      submittedNotes.add({"achievement_text": notCntroller.text});
      Future.delayed(const Duration(seconds: 1)).then((value) {
        clearFields();
      });
    }
  }

  clearFields() {
    notCntroller.clear();
    emit(EmptyNotesFieldsState());
  }

  void submitNotes() {
    print('===============notes============');
    logger.d(submittedNotes);
    var data = {"notes": submittedNotes};
    if (submittedNotes.isNotEmpty) {
      emit(SubmitNotesLoadingState());
      notesProvider.submitNotes(data).then((value) {
        emit(SubmitNotesSuccessState());
      }).catchError((error) {
        emit(SubmitNotesFailureState(message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    notCntroller.dispose();
    return super.close();
  }
}


