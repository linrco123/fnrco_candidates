part of 'personal_details_cubit.dart';

@immutable
sealed class PersonalDetailsState {}

final class PersonalDetailsInitial extends PersonalDetailsState {}


//TODO:PersonalDetails Process
class PersonalDetailsLoadingState extends PersonalDetailsState {}

class PersonalDetailsSuccessState extends PersonalDetailsState {}

class PersonalDetailsErrorState extends PersonalDetailsState {
  final String message;

  PersonalDetailsErrorState({required this.message});
}


//TODO:PersonalDetailsChoosing(Country - postion - gender - religion)State
class PersonalDetailsChoosingCountryState extends PersonalDetailsState {}

class PersonalDetailsChoosingGenderState extends PersonalDetailsState {}

class PersonalDetailsChoosingReligionState extends PersonalDetailsState {}

class PersonalDetailsChoosingMaritalStatusState extends PersonalDetailsState {}

//TODO:getCountries
class PersonalDetailsGettingCountriesLoadingState extends PersonalDetailsState {}

class PersonalDetailsGettingCountriesSuccessState extends PersonalDetailsState {
  final List<Country> countries;

  PersonalDetailsGettingCountriesSuccessState({required this.countries});
}

class PersonalDetailsGettingCountriesFailureState extends PersonalDetailsState {
  final String? message;

  PersonalDetailsGettingCountriesFailureState({this.message});
}

class PersonalDetailsGettingPositionsLoadingState extends PersonalDetailsState {}

class PersonalDetailsGettingPositionsSuccessState extends PersonalDetailsState {
  final List<Position> countries;

  PersonalDetailsGettingPositionsSuccessState({required this.countries});
}

class PersonalDetailsGettingPositionsFailureState extends PersonalDetailsState {
  final String? message;

  PersonalDetailsGettingPositionsFailureState({this.message});
}

class PersonalDetailsGettingReligionLoadingState extends PersonalDetailsState {}

class PersonalDetailsGettingReligionsSuccessState extends PersonalDetailsState {
  // final List<Position> countries;

  // PersonalDetailsGettingReligionSuccessState({required this.countries});
}

class PersonalDetailsGettingReligionFailureState extends PersonalDetailsState {
  // final String? message;

  // PersonalDetailsGettingPositionsFailureState({this.message});
}

class PersonalDetailsGettingGenderLoadingState extends PersonalDetailsState {}

class PersonalDetailsGettingGenderSuccessState extends PersonalDetailsState {
  // final List<Position> countries;

  // PersonalDetailsGettingPositionsSuccessState({required this.countries});
}

class PersonalDetailsGettingGenderFailureState extends PersonalDetailsState {
  // final String? message;

  // PersonalDetailsGettingPositionsFailureState({this.message});
}

class PersonalDetailsGettingMaritalStatusLoadingState extends PersonalDetailsState {}

class PersonalDetailsGettingMaritalStatusSuccessState extends PersonalDetailsState {
  // final List<Position> countries;

  // PersonalDetailsGettingPositionsSuccessState({required this.countries});
}

class PersonalDetailsGettingMaritalStatusFailureState extends PersonalDetailsState {
  // final String? message;

  // PersonalDetailsGettingPositionsFailureState({this.message});
}


class PersonalDetailsPickingUpDate extends PersonalDetailsState{}

class PersonalDetailsSuccessChangeImageState extends PersonalDetailsState{}


class ResumePickAttachmentFileState extends PersonalDetailsState{}
