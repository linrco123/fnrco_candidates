// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/profile/contact_type_model.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/contact.dart';

part 'contacts_type_state.dart';

class ContactsTypeCubit extends Cubit<ContactsTypeState> {
  ContactsProvider contactsProvider;
  ContactsTypeCubit(
    this.contactsProvider,
  ) : super(ContactsTypeInitial());

  var formKey = GlobalKey<FormState>();
  final cntCntroller = TextEditingController();
  String contactTypeID = '';
  int contactImportance = 2;

  void changeContactImportance(int value) {
    contactImportance = value;
    emit(ContactsChangingContactTypeImportanceState());
  }

  String? validateContactType(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_contact_type");
    }
    return null;
  }

  void selectContactType(String value) {
    contactTypeID = value;

    emit(ContactsChoosingContactTypeState());
  }

  var contactsType = List<ContactType>.empty(growable: true);
  void getContacts() {
    emit(ContactsGettingContactTypeLoadingState());
    contactsType.clear();
    contactsProvider.getContactType().then((value) {
      for (var contact in value.contactsType as List) contactsType.add(contact);
      emit(ContactsGettingContactTypeSuccessState(contacts: contactsType));
    }).catchError((error) {
      emit(ContactsGettingContactTypeFailureState(
          message: error.failure.message));
    });
  }

  List<Map<String, dynamic>> submittedContacts = [];
  void addNewContact() {
    if (formKey.currentState!.validate()) {
      if (contactTypeID != 0 && contactImportance != 2) {
        submittedContacts.add({
          "person_contact_type": contactTypeID,
          "person_contact_value": cntCntroller.text,
          "person_contact_primary": contactImportance.toString()
        });
        Future.delayed(const Duration(seconds: 1)).then((value) {
          clearFields();
        });
      } else {
        emit(CheckContactsEmptyFieldsState());
      }
    }
  }

  clearFields() {
    cntCntroller.clear();
    contactTypeID = '';
    contactImportance = 2;
    emit(EmptyContactFieldsState());
  }
  void submit(){
    if(submittedContacts.isEmpty){
      addNewContact();
      if(submittedContacts.isNotEmpty){
        _submitContactsType();
      }
    }else{
      _submitContactsType();
    }
  }
  void _submitContactsType() {
    var data = {"contacts": submittedContacts};
    if (submittedContacts.isNotEmpty) {
      emit(SubmitContactsTypeLoadingState());
      contactsProvider.submitContacts(data).then((value) {
        emit(SubmitContactsTypeSuccessState());
      }).catchError((error) {
        emit(SubmitContactsTypeFailureState(message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    cntCntroller.clear();
    return super.close();
  }
}
