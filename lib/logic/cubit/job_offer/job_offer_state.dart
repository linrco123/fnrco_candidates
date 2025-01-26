part of 'job_offer_cubit.dart';

@immutable
sealed class JobOfferState {}

final class JobOfferInitial extends JobOfferState {}

class GeneratingPDFLoadingState extends JobOfferState{}

class GeneratingPDFSuccessState extends JobOfferState{
  final File pdf;

  GeneratingPDFSuccessState({required this.pdf});
}
class GeneratingPDFErrorState extends JobOfferState{
  final String message;

  GeneratingPDFErrorState({required this.message});
}


class JobOfferDownloadPDFLoadingState extends JobOfferState{}

class JobOfferDownloadPDFSuccessState extends JobOfferState{}

class JobOfferDownloadPDFFailureState extends JobOfferState{}



class JobOfferUploadPDFLoadingState extends JobOfferState{}

class JobOfferUploadPDFSuccessState extends JobOfferState{}

class JobOfferUploadPDFFailureState extends JobOfferState{}


class GetJobOfferApplicationsLoadingState extends JobOfferState{}

class GetJobOfferApplicationsSuccessState extends JobOfferState{
  final List<JobApplication>  applications;

  GetJobOfferApplicationsSuccessState({required this.applications});

  // GetJobOfferApplicationsSuccessState(this.applications);
}

class GetJobOfferApplicationsFailureState extends JobOfferState{
    final String message;

  GetJobOfferApplicationsFailureState({required this.message});
}


class GetJobofferLoadingState extends JobOfferState{}

class GetJobofferSuccessState extends JobOfferState{
  final File jobOffer;

  GetJobofferSuccessState(this.jobOffer);
}

class GetJobofferErrorState extends JobOfferState{
  final String message;

  GetJobofferErrorState(this.message);
}


class JobOfferApprovalLoadingState extends JobOfferState{}

class JobOfferRejectLoadingState extends JobOfferState{}

class JobOfferApprovalSuccessState extends JobOfferState{}

class JobOfferApprovalFailureState extends JobOfferState{
  final String message;

  JobOfferApprovalFailureState({required this.message});
}


 class AttachmentUploadFileState extends JobOfferState{}
  class AttachmentDeletionFileState extends JobOfferState{}

  class changeUploadFileToApproveState extends JobOfferState{}