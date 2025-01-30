// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contract_cubit.dart';

@immutable
sealed   class  ContractState {}

final   class  ContractInitial extends ContractState {}

final class  ContractGeneratingPDFLoadingState extends ContractState {}

final class  ContractGeneratingPDFSuccessState extends ContractState {
  final File pdf;

  ContractGeneratingPDFSuccessState({required this.pdf});
}

final class  ContractGeneratingPDFErrorState extends ContractState {
  final String message;
  ContractGeneratingPDFErrorState({
    required this.message,
  });
}

final class  ContractDownloadPDFLoadingState extends ContractState {}

final class  ContractDownloadPDFSuccessState extends ContractState {}

final class  ContractDownloadPDFFailureState extends ContractState {}

final class  GetJobContractLoadingState extends ContractState {}

final class  GetJobContractSuccessState extends ContractState {
  final File contract;

  GetJobContractSuccessState({required this.contract});
}

final class  GetJobContractFailureState extends ContractState {
  final String message;

  GetJobContractFailureState({required this.message});
}

final class  GetJobContractApplicationsLoadingState extends ContractState {}

final class  GetJobContractApplicationsSuccessState extends ContractState {
  final List<ContractApplication> applications;

  GetJobContractApplicationsSuccessState({required this.applications});
}

final class  GetJobContractApplicationsFailureState extends ContractState {
  final String message;

  GetJobContractApplicationsFailureState({required this.message});
}

final class  JobContractApprovalLoadingState extends ContractState {}

final class  JobContractRejectLoadingState extends ContractState {}

final class  JobContractApprovalSuccessState extends ContractState {}

final class  JobContractApprovalFailureState extends ContractState {
  final String message;

  JobContractApprovalFailureState({required this.message});
}

final class  AttachmentUploadFileState extends ContractState {}

final class  AttachmentDeletionFileState extends ContractState {}
