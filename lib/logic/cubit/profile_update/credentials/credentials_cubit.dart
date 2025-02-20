// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/credentials.dart';
import 'package:fnrco_candidates/data/models/profile_get/credentials_model.dart';

part 'credentials_state.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  CredentialsProvider credentialsProvider;
  CredentialsCubit(
    this.credentialsProvider,
  ) : super(CredentialsInitial());

  var formKey = GlobalKey<FormState>();
  final catCntroller = TextEditingController();
  final nameCntroller = TextEditingController();
  final numbCntroller = TextEditingController();
  String? issueDate;
  String? expireDate;
  dynamic id = '';

  fillFields(GetCredential? credential) {
    if (credential != null) {
      id = credential.id!;
      catCntroller.text = credential.personCredCat!;
      nameCntroller.text = credential.personCredName!;
      numbCntroller.text = credential.personCredNumber!;
      issueDate = credential.personCredIssuedIn;
      expireDate = credential.personCredExpIn;
      emit(CredentialsPickingUpIssueDate());
    }
  }

  String? validateCategory(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_credential_cat");
    }
    return null;
  }

  String? validateName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_credential_name");
    }
    return null;
  }

  String? validateNumber(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_credential_number");
    }
    return null;
  }

  void selectIssueDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    issueDate =
        "${pickedDate!.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    emit(CredentialsPickingUpIssueDate());
  }

  void selectExpiryDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    expireDate =
        "${pickedDate!.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    emit(CredentialsPickingUpExpireDate());
  }

  List<Map<String, dynamic>> submittedCredentials = [];
  void addNewCredentials() {
    if (formKey.currentState!.validate()) {
      if (issueDate != null && expireDate != null) {
        submittedCredentials.add({
          "id": id,
          "person_cred_cat": catCntroller.text,
          "person_cred_name": nameCntroller.text,
          "person_cred_number": numbCntroller.text,
          "person_cred_issued_in": issueDate,
          "person_cred_exp_in": expireDate
        });
        Future.delayed(const Duration(seconds: 1)).then((value) {
          clearFields();
        });
      } else {
        emit(CheckCredentialsEmptyFieldsState());
      }
    }
  }

  clearFields() {
    catCntroller.clear();
    nameCntroller.clear();
    numbCntroller.clear();
    issueDate = null;
    expireDate = null;
    emit(EmptyCredentialsFieldsState());
  }

  void submit() {
    if (submittedCredentials.isEmpty) {
      addNewCredentials();
      if (submittedCredentials.isNotEmpty) {
        _submitCredentials();
      }
    } else {
      _submitCredentials();
    }
  }

  void _submitCredentials() {
    var data = {"credentials": submittedCredentials};
    if (submittedCredentials.isNotEmpty) {
      emit(SubmitCredentialsLoadingState());
      credentialsProvider.submitCredentials(data).then((value) {
        emit(SubmitCredentialsSuccessState());
      }).catchError((error) {
        emit(SubmitCredentialsFailureState(message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    catCntroller.dispose();
    nameCntroller.dispose();
    numbCntroller.dispose();

    return super.close();
  }
}
