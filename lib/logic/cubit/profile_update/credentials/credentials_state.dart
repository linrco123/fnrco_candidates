part of 'credentials_cubit.dart';

@immutable
sealed   class  CredentialsState {}

final   class  CredentialsInitial extends CredentialsState {}


final class  CredentialsPickingUpIssueDate extends CredentialsState{}
final class  CredentialsPickingUpExpireDate extends CredentialsState{}
final class  CheckCredentialsEmptyFieldsState extends CredentialsState{}

final class  EmptyCredentialsFieldsState extends CredentialsState{}


final class  SubmitCredentialsLoadingState extends CredentialsState{}

final class  SubmitCredentialsSuccessState extends CredentialsState{}
final class  SubmitCredentialsFailureState extends CredentialsState{
  final String message;

  SubmitCredentialsFailureState({required this.message});
}