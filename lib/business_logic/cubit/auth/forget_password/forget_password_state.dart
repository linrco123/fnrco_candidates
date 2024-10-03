part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}
final class ForgetPasswordSuccessState extends ForgetPasswordState {}
final class ForgetPasswordFailureState extends ForgetPasswordState {}


