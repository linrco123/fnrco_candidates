part of 'personal_details_cubit.dart';

@immutable
sealed   class  PersonalDetailsState {}

final   class  PersonalDetailsInitial extends PersonalDetailsState {}


//TODO:PersonalDetails Process
final class  PersonalDetailsLoadingState extends PersonalDetailsState {}

final class  PersonalDetailsSuccessState extends PersonalDetailsState {}

final class  PersonalDetailsErrorState extends PersonalDetailsState {
  final String message;

  PersonalDetailsErrorState({required this.message});
}


//TODO:PersonalDetailsChoosing(Country - postion - gender - religion)State
final class  PersonalDetailsChoosingCountryState extends PersonalDetailsState {}

final class  PersonalDetailsChoosingGenderState extends PersonalDetailsState {}

final class  PersonalDetailsChoosingReligionState extends PersonalDetailsState {}

final class  PersonalDetailsChoosingMaritalStatusState extends PersonalDetailsState {}

//TODO:getCountries
final class  PersonalDetailsGettingCountriesLoadingState extends PersonalDetailsState {}

final class  PersonalDetailsGettingCountriesSuccessState extends PersonalDetailsState {
  final List<Country> countries;

  PersonalDetailsGettingCountriesSuccessState({required this.countries});
}

final class  PersonalDetailsGettingCountriesFailureState extends PersonalDetailsState {
  final String? message;

  PersonalDetailsGettingCountriesFailureState({this.message});
}

final class  PersonalDetailsGettingPositionsLoadingState extends PersonalDetailsState {}

final class  PersonalDetailsGettingPositionsSuccessState extends PersonalDetailsState {
  final List<Position> countries;

  PersonalDetailsGettingPositionsSuccessState({required this.countries});
}

final class  PersonalDetailsGettingPositionsFailureState extends PersonalDetailsState {
  final String? message;

  PersonalDetailsGettingPositionsFailureState({this.message});
}

final class  PersonalDetailsGettingReligionLoadingState extends PersonalDetailsState {}

final class  PersonalDetailsGettingReligionsSuccessState extends PersonalDetailsState {
  // final List<Position> countries;

  // PersonalDetailsGettingReligionSuccessState({required this.countries});
}

final class  PersonalDetailsGettingReligionFailureState extends PersonalDetailsState {
  // final String? message;

  // PersonalDetailsGettingPositionsFailureState({this.message});
}

final class  PersonalDetailsGettingGenderLoadingState extends PersonalDetailsState {}

final class  PersonalDetailsGettingGenderSuccessState extends PersonalDetailsState {
  // final List<Position> countries;

  // PersonalDetailsGettingPositionsSuccessState({required this.countries});
}

final class  PersonalDetailsGettingGenderFailureState extends PersonalDetailsState {
  // final String? message;

  // PersonalDetailsGettingPositionsFailureState({this.message});
}

final class  PersonalDetailsGettingMaritalStatusLoadingState extends PersonalDetailsState {}

final class  PersonalDetailsGettingMaritalStatusSuccessState extends PersonalDetailsState {
  // final List<Position> countries;

  // PersonalDetailsGettingPositionsSuccessState({required this.countries});
}

final class  PersonalDetailsGettingMaritalStatusFailureState extends PersonalDetailsState {
  // final String? message;

  // PersonalDetailsGettingPositionsFailureState({this.message});
}


final class  PersonalDetailsPickingUpDate extends PersonalDetailsState{}

final class  PersonalDetailsSuccessChangeImageState extends PersonalDetailsState{}


final class  ResumePickAttachmentFileState extends PersonalDetailsState{}


final class GetPersonalDataLoadingState extends PersonalDetailsState{}


final class GetPersonalDataSuccessState extends PersonalDetailsState{}


final class GetPersonalDataErrorState extends PersonalDetailsState{}

