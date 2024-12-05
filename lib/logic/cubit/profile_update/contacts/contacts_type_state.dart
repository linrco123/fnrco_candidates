part of 'contacts_type_cubit.dart';

@immutable
sealed class ContactsTypeState {}

final class ContactsTypeInitial extends ContactsTypeState {}

class ContactsChoosingContactTypeState extends ContactsTypeState{}


class ContactsGettingContactTypeLoadingState extends ContactsTypeState{}

class ContactsGettingContactTypeSuccessState extends ContactsTypeState{
  final List<ContactType> contacts;

  ContactsGettingContactTypeSuccessState({required this.contacts});
}

class ContactsGettingContactTypeFailureState extends ContactsTypeState{
  final String message;

  ContactsGettingContactTypeFailureState({required this.message});
}


class CheckContactsEmptyFieldsState extends ContactsTypeState{}

class EmptyContactFieldsState extends ContactsTypeState{}


class SubmitContactsTypeLoadingState extends ContactsTypeState{}

class SubmitContactsTypeSuccessState extends ContactsTypeState{}
class SubmitContactsTypeFailureState extends ContactsTypeState{
  final String message;

  SubmitContactsTypeFailureState({required this.message});
}

class ContactsChangingContactTypeImportanceState extends ContactsTypeState{}