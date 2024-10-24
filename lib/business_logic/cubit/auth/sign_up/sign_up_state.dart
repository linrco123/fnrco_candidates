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

//TODO:SignUpChoosingCountryState
class SignUpChoosingCountryState extends SignUpState {}

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
