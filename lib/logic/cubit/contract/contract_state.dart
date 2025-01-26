// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contract_cubit.dart';

@immutable
sealed class ContractState {}

final class ContractInitial extends ContractState {}

class ContractGeneratingPDFLoadingState extends ContractState {}

class ContractGeneratingPDFSuccessState extends ContractState {
  final File pdf;

  ContractGeneratingPDFSuccessState({required this.pdf});
}

class ContractGeneratingPDFErrorState extends ContractState {
  final String message;
  ContractGeneratingPDFErrorState({
    required this.message,
  });
}

class ContractDownloadPDFLoadingState extends ContractState {}

class ContractDownloadPDFSuccessState extends ContractState {}

class ContractDownloadPDFFailureState extends ContractState {}

class GetJobContractLoadingState extends ContractState {}

class GetJobContractSuccessState extends ContractState {
  final File contract;

  GetJobContractSuccessState({required this.contract});
}

class GetJobContractFailureState extends ContractState {
  final String message;

  GetJobContractFailureState({required this.message});
}

class GetJobContractApplicationsLoadingState extends ContractState {}

class GetJobContractApplicationsSuccessState extends ContractState {
  final List<ContractApplication> applications;

  GetJobContractApplicationsSuccessState({required this.applications});
}

class GetJobContractApplicationsFailureState extends ContractState {
  final String message;

  GetJobContractApplicationsFailureState({required this.message});
}

class JobContractApprovalLoadingState extends ContractState {}

class JobContractRejectLoadingState extends ContractState {}

class JobContractApprovalSuccessState extends ContractState {}

class JobContractApprovalFailureState extends ContractState {
  final String message;

  JobContractApprovalFailureState({required this.message});
}

class AttachmentUploadFileState extends ContractState {}

class AttachmentDeletionFileState extends ContractState {}
