// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/language.dart';
import 'package:fnrco_candidates/data/models/profile_get/languages_model.dart';

part 'languages_state.dart';

class LanguagesCubit extends Cubit<LanguagesState> {
  LanguageProvider languageProvider;
  LanguagesCubit(
    this.languageProvider,
  ) : super(LanguagesInitial());

  var formKey = GlobalKey<FormState>();
  final TextEditingController langCntroller = TextEditingController();
  final TextEditingController testCntroller = TextEditingController();
  int languageLevel = 1;
  dynamic id = '';

  void changeLanguageLevel(int value) {
    languageLevel = value;
    emit(ChangingLanguageLevelState());
  }

  String? validateLanguage(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_language");
    }
    return null;
  }

  String? validateTestBy(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_test_by");
    }
    return null;
  }

  List<Map<String, dynamic>> submittedLanguages = [];
  void addNewLanguage() {
    if (formKey.currentState!.validate()) {
      submittedLanguages.add({
        "id":id,
        "lang_text": langCntroller.text,
        "lang_level": languageLevel.toString(),
        "lang_test_by": testCntroller.text
      });
      Future.delayed(const Duration(seconds: 1)).then((value) {
        clearFields();
      });
    }
  }

  clearFields() {
    langCntroller.clear();
    testCntroller.clear();
    languageLevel = 1;
    emit(EmptyLanguageFieldsState());
  }

  void submit() {
    if (submittedLanguages.isEmpty) {
      addNewLanguage();
      if (submittedLanguages.isNotEmpty) {
        _submitLanguages();
      }
    } else {
      _submitLanguages();
    }
  }

  void _submitLanguages() {
    var data = {"languages": submittedLanguages};
    if (submittedLanguages.isNotEmpty) {
      emit(SubmitLanguagesLoadingState());
      languageProvider.submitLanguages(data).then((value) {
        emit(SubmitLanguagesSuccessState());
      }).catchError((error) {
        emit(SubmitLanguagesErrorState(message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    langCntroller.dispose();
    testCntroller.dispose();
    return super.close();
  }

  fillFields(GetLanguage? language) {
    if (language != null) {
      id = language.id!;
      langCntroller.text = language.langText!;
      testCntroller.text = language.langTestBy!;
      languageLevel = language.langLevel! ;
      emit(ChangingLanguageLevelState());
    }
  }
}
