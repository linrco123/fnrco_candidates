part of 'credentials_cubit.dart';

@immutable
sealed class CredentialsState {}

final class CredentialsInitial extends CredentialsState {}


class CredentialsPickingUpIssueDate extends CredentialsState{}
class CredentialsPickingUpExpireDate extends CredentialsState{}
class CheckCredentialsEmptyFieldsState extends CredentialsState{}

class EmptyCredentialsFieldsState extends CredentialsState{}


class SubmitCredentialsLoadingState extends CredentialsState{}

class SubmitCredentialsSuccessState extends CredentialsState{}
class SubmitCredentialsFailureState extends CredentialsState{
  final String message;

  SubmitCredentialsFailureState({required this.message});
}