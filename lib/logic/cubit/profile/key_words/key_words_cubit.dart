// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/keywords.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

part 'key_words_state.dart';

class KeyWordsCubit extends Cubit<KeyWordsState> {
  KeywordsProvider keywordsProvider;
  KeyWordsCubit(
    this.keywordsProvider,
  ) : super(KeyWordsInitial());

  var formKey = GlobalKey<FormState>();
  final TextEditingController keyWCntroller = TextEditingController();

  String? validateKeyWord(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_keyw");
    }
    return null;
  }

  List<String> submittedKeyWords = [];
  void addNewKeyword() {
    if (formKey.currentState!.validate()) {
      submittedKeyWords.add(keyWCntroller.text);
      Future.delayed(const Duration(seconds: 1)).then((value) {
        clearFields();
      });
    }
  }

  clearFields() {
    keyWCntroller.clear();
    emit(EmptyKeywordFieldsState());
  }

  void submitKeyWords() {
    print('===============notes============');
    logger.d(submittedKeyWords);
    var data = {"keywords": submittedKeyWords};
    if (submittedKeyWords.isNotEmpty) {
      emit(SubmitKeyWordsLoadingState());
      keywordsProvider.submitKeyWords(data).then((value) {
        emit(SubmitKeyWordsSuccessState());
      }).catchError((error) {
        emit(SubmitKeyWordsFailureState(message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    keyWCntroller.dispose();
    return super.close();
  }
}


