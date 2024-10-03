part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}


final class ChangePasswordLoadingState extends ChangePasswordState {}
final class ChangePasswordSuccessState extends ChangePasswordState {}
final class ChangePasswordFailureState extends ChangePasswordState {}

