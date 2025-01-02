part of 'joining_date_cubit.dart';

@immutable
sealed class JoiningDateState {}


final class JoiningDateInitial extends JoiningDateState {}

class GetJoiningDateLoadingState extends JoiningDateState {}

class GetJoiningDateFailureState extends JoiningDateState {
  final String message;

  GetJoiningDateFailureState(this.message);
}

class GetJoiningDateSuccessState extends JoiningDateState {
  final List<JoiningDateApplication> applications;

  GetJoiningDateSuccessState({required this.applications});
  
}

final class JoiningDateApprovalLoadingState extends JoiningDateState {}

final class JoiningDateRejectionLoadingState extends JoiningDateState {}

final class JoiningDateApprovalSuccessState extends JoiningDateState {}

final class JoiningDateApprovalErrorState extends JoiningDateState {
  final String message;

  JoiningDateApprovalErrorState({required this.message});
}
