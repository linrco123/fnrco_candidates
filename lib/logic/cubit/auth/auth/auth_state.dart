part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {


 
}
 class AuthBiometricLoadingState extends AuthState{}

class AuthBiometricSuccessState extends AuthState{}
class AuthBiometricErrorState extends AuthState{
    final String message;

  AuthBiometricErrorState({required this.message});
  
}