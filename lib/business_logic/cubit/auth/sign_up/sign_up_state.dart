part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState{}

class SignUpSuccessState extends SignUpState{}
class SignUpErrorState extends SignUpState{}


class SignUpChangingObsecureTextState extends SignUpState{
}

class SignUpChoosingCountryState extends SignUpState{}