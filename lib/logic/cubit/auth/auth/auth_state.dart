part of 'auth_cubit.dart';

@immutable
sealed   class  AuthState {}

final   class  AuthInitial extends AuthState {


 
}
 final class  AuthBiometricLoadingState extends AuthState{}

final class  AuthBiometricSuccessState extends AuthState{}
final class  AuthBiometricErrorState extends AuthState{
    final String message;

  AuthBiometricErrorState({required this.message});
  
}