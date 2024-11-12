part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitialState extends SignUpState {}

//TODO:Signup Process
class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState({required this.message});
}

//TODO:SignUpChangingObsecureTextState
class SignUpChangingObsecureTextState extends SignUpState {}

//TODO:SignUpChoosing(Country - postion - gender - religion)State
class SignUpChoosingCountryState extends SignUpState {}

class SignUpChoosingPositionState extends SignUpState {}

class SignUpChoosingGenderState extends SignUpState {}

class SignUpChoosingReligionState extends SignUpState {}

class SignUpChoosingMaritalStatusState extends SignUpState {}

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

class SignUpGettingMaritalStatusLoadingState extends SignUpState {}

class SignUpGettingMaritalStatusSuccessState extends SignUpState {
  // final List<Position> countries;

  // SignUpGettingPositionsSuccessState({required this.countries});
}

class SignUpGettingMaritalStatusFailureState extends SignUpState {
  // final String? message;

  // SignUpGettingPositionsFailureState({this.message});
}

class SignUpOTPLoadingState extends SignUpState {}

class SignUpOTPSuccessState extends SignUpState {
  final int code;

  SignUpOTPSuccessState({required this.code});
}

class SignUpOTPFailureState extends SignUpState {
  final String? message;

  SignUpOTPFailureState({this.message});
}
