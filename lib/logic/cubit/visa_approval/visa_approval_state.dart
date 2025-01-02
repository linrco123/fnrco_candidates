part of 'visa_approval_cubit.dart';

@immutable
sealed class VisaApprovalState {}

final class VisaApprovalInitial extends VisaApprovalState {}

final class VisaApprovalLoadingState extends VisaApprovalState {}

final class VisaRejectionLoadingState extends VisaApprovalState {}

final class VisaApprovalSuccessState extends VisaApprovalState {}

final class VisaApprovalErrorState extends VisaApprovalState {
   final String message;

  VisaApprovalErrorState({required this.message});
}


final class GetVisaApprovalDataLoadingState extends VisaApprovalState {}

final class GetVisaApprovalDataSuccessState extends VisaApprovalState {
  final List<VisaApprovalApplication> applications;

  GetVisaApprovalDataSuccessState({required this.applications});
}

final class GetVisaApprovalDataFailureState extends VisaApprovalState {
  final String message;

  GetVisaApprovalDataFailureState({required this.message});
}