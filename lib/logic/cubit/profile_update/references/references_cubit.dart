// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/references.dart';

part 'references_state.dart';

class ReferencesCubit extends Cubit<KeyWordsState> {
  RefencesProvider keywordsProvider;
  ReferencesCubit(
    this.keywordsProvider,
  ) : super(KeyWordsInitial());

  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final jobTitleCntroller = TextEditingController();
  final companyCntroller = TextEditingController();
  dynamic id = '';
  String? validateJobTitle(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_job_title");
    }
    return null;
  }

  String? validateCompany(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_company");
    }
    return null;
  }

  String? validateName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_last_name");
    }
    return null;
  }

  String? validateEmail(context, String? value) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_email");
    } else if (!regex.hasMatch(value)) {
      return translateLang(context, "msg_plz_enter_correct_email");
    }
    return null;
  }

  String? validatePhone(context, String? value) {
    final regExp = RegExp(
      'Constance.phoneRegExp',
      caseSensitive: false,
      multiLine: false,
    );

    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_phone");
    }
    // } else if (!regExp.hasMatch(value)) {
    //   return translateLang(context, "msg_plz_enter_correct_phone");
    // }
    return null;
  }

  List<Map<String, dynamic>> submittedReferences = [];
  void addNewReferences() {
    if (formKey.currentState!.validate()) {
      submittedReferences.add({
        "id": id,
        "company": companyCntroller.text,
        "job_title": jobTitleCntroller.text,
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text
      });
      Future.delayed(const Duration(seconds: 1)).then((value) {
        clearFields();
      });
    }
  }

  clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    companyCntroller.clear();
    jobTitleCntroller.clear();

    emit(EmptyKeywordFieldsState());
  }

  void submit() {
    if (submittedReferences.isEmpty) {
      addNewReferences();
      if (submittedReferences.isNotEmpty) {
        _submitReferences();
      }
    } else {
      _submitReferences();
    }
  }

  void _submitReferences() {
    var data = {"personReferences": submittedReferences};
    if (submittedReferences.isNotEmpty) {
      emit(SubmitKeyWordsLoadingState());
      keywordsProvider.submitReferences(data).then((value) {
        emit(SubmitKeyWordsSuccessState());
      }).catchError((error) {
        emit(SubmitKeyWordsFailureState(message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyCntroller.dispose();
    jobTitleCntroller.dispose();
    return super.close();
  }
}
