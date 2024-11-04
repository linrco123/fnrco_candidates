part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}
final class ForgetPasswordSuccessState extends ForgetPasswordState {
  final int code;

  ForgetPasswordSuccessState({required this.code});
}
final class ForgetPasswordFailureState extends ForgetPasswordState {
  final String message;

  ForgetPasswordFailureState({required this.message});
  
}


