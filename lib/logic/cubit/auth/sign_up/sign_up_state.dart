part of 'sign_up_cubit.dart';

@immutable
sealed   class  SignUpState {}

final   class  SignUpInitialState extends SignUpState {}

//TODO:Signup Process
final class  SignUpLoadingState extends SignUpState {}

final class  SignUpSuccessState extends SignUpState {
  final int code;

  SignUpSuccessState({required this.code});
}

final class  SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState({required this.message});
}

//TODO:SignUpChangingObsecureTextState
final class  SignUpChangingObsecureTextState extends SignUpState {}

//TODO:SignUpChoosing(Country - postion - gender - religion)State
final class  SignUpChoosingCountryState extends SignUpState {}

final class  SignUpChoosingPositionState extends SignUpState {}

final class  SignUpChoosingGenderState extends SignUpState {}

final class  SignUpChoosingReligionState extends SignUpState {}

final class  SignUpChoosingMaritalStatusState extends SignUpState {}

//TODO:getCountries
final class  SignUpGettingCountriesLoadingState extends SignUpState {}

final class  SignUpGettingCountriesSuccessState extends SignUpState {
  final List<Country> countries;

  SignUpGettingCountriesSuccessState({required this.countries});
}

final class  SignUpGettingCountriesFailureState extends SignUpState {
  final String? message;

  SignUpGettingCountriesFailureState({this.message});
}

final class  SignUpGettingPositionsLoadingState extends SignUpState {}

final class  SignUpGettingPositionsSuccessState extends SignUpState {
  final List<Position> countries;

  SignUpGettingPositionsSuccessState({required this.countries});
}

final class  SignUpGettingPositionsFailureState extends SignUpState {
  final String? message;

  SignUpGettingPositionsFailureState({this.message});
}

final class  SignUpGettingReligionLoadingState extends SignUpState {}

final class  SignUpGettingReligionsSuccessState extends SignUpState {
  // final List<Position> countries;

  // SignUpGettingReligionSuccessState({required this.countries});
}

final class  SignUpGettingReligionFailureState extends SignUpState {
  // final String? message;

  // SignUpGettingPositionsFailureState({this.message});
}

final class  SignUpGettingGenderLoadingState extends SignUpState {}

final class  SignUpGettingGenderSuccessState extends SignUpState {
  // final List<Position> countries;

  // SignUpGettingPositionsSuccessState({required this.countries});
}

final class  SignUpGettingGenderFailureState extends SignUpState {
  // final String? message;

  // SignUpGettingPositionsFailureState({this.message});
}

final class  SignUpGettingMaritalStatusLoadingState extends SignUpState {}

final class  SignUpGettingMaritalStatusSuccessState extends SignUpState {
  // final List<Position> countries;

  // SignUpGettingPositionsSuccessState({required this.countries});
}

final class  SignUpGettingMaritalStatusFailureState extends SignUpState {
  // final String? message;

  // SignUpGettingPositionsFailureState({this.message});
}

final class  SignUpOTPLoadingState extends SignUpState {}

final class  SignUpOTPSuccessState extends SignUpState {
  final int code;

  SignUpOTPSuccessState({required this.code});
}

final class  SignUpOTPFailureState extends SignUpState {
  final String? message;

  SignUpOTPFailureState({this.message});
}
