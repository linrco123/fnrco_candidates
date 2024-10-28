part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitialState extends SignUpState {}

//TODO:Signup Process
class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {}

//TODO:SignUpChangingObsecureTextState
class SignUpChangingObsecureTextState extends SignUpState {}

//TODO:SignUpChoosing(Country - postion - gender - religion)State
class SignUpChoosingCountryState extends SignUpState {}

class SignUpChoosingPositionState extends SignUpState {}

class SignUpChoosingGenderState extends SignUpState {}

class SignUpChoosingReligionState extends SignUpState {}

//TODO:getCountries
class SignUpGettingCountriesLoadingState extends SignUpState {}

class SignUpGettingCountriesSuccessState extends SignUpState {
  final List<Country> countries;

  SignUpGettingCountriesSuccessState({required this.countries});
}

class SignUpGettingCountriesFailureState extends SignUpState {
  final String? message;

  SignUpGettingCountriesFailureState({this.message});
}

class SignUpGettingPositionsLoadingState extends SignUpState {}

class SignUpGettingPositionsSuccessState extends SignUpState {
  final List<Position> countries;

  SignUpGettingPositionsSuccessState({required this.countries});
}

class SignUpGettingPositionsFailureState extends SignUpState {
  final String? message;

  SignUpGettingPositionsFailureState({this.message});
}

class SignUpGettingReligionLoadingState extends SignUpState {}

class SignUpGettingReligionsSuccessState extends SignUpState {
  // final List<Position> countries;

  // SignUpGettingReligionSuccessState({required this.countries});
}

class SignUpGettingReligionFailureState extends SignUpState {
  // final String? message;

  // SignUpGettingPositionsFailureState({this.message});
}

class SignUpGettingGenderLoadingState extends SignUpState {}

class SignUpGettingGenderSuccessState extends SignUpState {
  // final List<Position> countries;

  // SignUpGettingPositionsSuccessState({required this.countries});
}

class SignUpGettingGenderFailureState extends SignUpState {
  // final String? message;

  // SignUpGettingPositionsFailureState({this.message});
}
