part of 'medical_declare_cubit.dart';

@immutable
sealed class MedicalDeclareState {}

final class MedicalDeclareInitial extends MedicalDeclareState {}

final class MedicalDeclareChoosingCountryState extends MedicalDeclareState {}

final class MedicalDeclareChoosingGenderState extends MedicalDeclareState {}

final class MedicalDeclareChoosingReligionState extends MedicalDeclareState {}

final class MedicalDeclareettingCountriesLoadingState
    extends MedicalDeclareState {}

final class MedicalDeclareGettingCountriesSuccessState
    extends MedicalDeclareState {
  final List<Country> countries;

  MedicalDeclareGettingCountriesSuccessState({required this.countries});
}

final class MedicalDeclareGettingCountriesFailureState
    extends MedicalDeclareState {}

final class MedicalDeclareGettingGenderLoadingState
    extends MedicalDeclareState {}

final class MedicalDeclareGettingGenderSuccessState
    extends MedicalDeclareState {
  MedicalDeclareGettingGenderSuccessState();
}

final class MedicalDeclareGettingGenderFailureState
    extends MedicalDeclareState {}

final class MedicalDeclareGettingMaritalStatusLoadingState
    extends MedicalDeclareState {}

final class MedicalDeclareGettingMaritalStatusSuccessState
    extends MedicalDeclareState {}

final class MedicalDeclareGettingMaritalStatusFailureState
    extends MedicalDeclareState {}

final class MedicalDeclarationIncrementStepperState
    extends MedicalDeclareState {}

final class GetMedicalQuestionsLoadingState extends MedicalDeclareState {}

final class GetMedicalQuestionsSuccessState extends MedicalDeclareState {}

final class GetMedicalQuestionsFailureState extends MedicalDeclareState {}

final class MoveToNextQuestionsState extends MedicalDeclareState {}

final class MedicalSubmitAnswerState extends MedicalDeclareState {}

final class ChangerYesOrNoState extends MedicalDeclareState {}

final class MedicalChooseDateState extends MedicalDeclareState {}

class MedicalDeclareGettingClassificationsLoadingState
    extends MedicalDeclareState {}

class MedicalDeclareGettingClassificationsSuccessState
    extends MedicalDeclareState {}

class MedicalDeclareGettingClassificationsFailureState
    extends MedicalDeclareState {}

class MedicalDeclareChoosingRelationState extends MedicalDeclareState{}

class SendMedicalDeclareLoadingState extends MedicalDeclareState{}


class SendMedicalDeclareSuccessState extends MedicalDeclareState{}


class SendMedicalDeclareFailureState extends MedicalDeclareState{
  final String message;

  SendMedicalDeclareFailureState({required this.message});
}

class EnterOneFamilyMemberAtLeastState extends MedicalDeclareState{}

class MedicalDeclarationClearState extends MedicalDeclareState{}

class GetMedicalApplicationsLoadingState extends MedicalDeclareState{}

class GetMedicalApplicationsSuccessState extends MedicalDeclareState{
  final List<MedicalDeclarationApp> applications;

  GetMedicalApplicationsSuccessState({required this.applications});
}


class GetMedicalApplicationsFailureState extends MedicalDeclareState{
  final String message;

  GetMedicalApplicationsFailureState({required this.message});
  
}