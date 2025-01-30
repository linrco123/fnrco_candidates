part of 'contacts_type_cubit.dart';

@immutable
sealed   class  ContactsTypeState {}

final   class  ContactsTypeInitial extends ContactsTypeState {}

final class  ContactsChoosingContactTypeState extends ContactsTypeState{}


final class  ContactsGettingContactTypeLoadingState extends ContactsTypeState{}

final class  ContactsGettingContactTypeSuccessState extends ContactsTypeState{
  final List<ContactType> contacts;

  ContactsGettingContactTypeSuccessState({required this.contacts});
}

final class  ContactsGettingContactTypeFailureState extends ContactsTypeState{
  final String message;

  ContactsGettingContactTypeFailureState({required this.message});
}


final class  CheckContactsEmptyFieldsState extends ContactsTypeState{}

final class  EmptyContactFieldsState extends ContactsTypeState{}


final class  SubmitContactsTypeLoadingState extends ContactsTypeState{}

final class  SubmitContactsTypeSuccessState extends ContactsTypeState{}
final class  SubmitContactsTypeFailureState extends ContactsTypeState{
  final String message;

  SubmitContactsTypeFailureState({required this.message});
}

final class  ContactsChangingContactTypeImportanceState extends ContactsTypeState{}