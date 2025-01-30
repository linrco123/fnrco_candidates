part of 'job_offer_cubit.dart';

@immutable
sealed   class  JobOfferState {}

final   class  JobOfferInitial extends JobOfferState {}

final class  GeneratingPDFLoadingState extends JobOfferState{}

final class  GeneratingPDFSuccessState extends JobOfferState{
  final File pdf;

  GeneratingPDFSuccessState({required this.pdf});
}
final class  GeneratingPDFErrorState extends JobOfferState{
  final String message;

  GeneratingPDFErrorState({required this.message});
}


final class  JobOfferDownloadPDFLoadingState extends JobOfferState{}

final class  JobOfferDownloadPDFSuccessState extends JobOfferState{}

final class  JobOfferDownloadPDFFailureState extends JobOfferState{}



final class  JobOfferUploadPDFLoadingState extends JobOfferState{}

final class  JobOfferUploadPDFSuccessState extends JobOfferState{}

final class  JobOfferUploadPDFFailureState extends JobOfferState{}


final class  GetJobOfferApplicationsLoadingState extends JobOfferState{}

final class  GetJobOfferApplicationsSuccessState extends JobOfferState{
  final List<JobApplication>  applications;

  GetJobOfferApplicationsSuccessState({required this.applications});

  // GetJobOfferApplicationsSuccessState(this.applications);
}

final class  GetJobOfferApplicationsFailureState extends JobOfferState{
    final String message;

  GetJobOfferApplicationsFailureState({required this.message});
}


final class  GetJobofferLoadingState extends JobOfferState{}

final class  GetJobofferSuccessState extends JobOfferState{
  final File jobOffer;

  GetJobofferSuccessState(this.jobOffer);
}

final class  GetJobofferErrorState extends JobOfferState{
  final String message;

  GetJobofferErrorState(this.message);
}


final class  JobOfferApprovalLoadingState extends JobOfferState{}

final class  JobOfferRejectLoadingState extends JobOfferState{}

final class  JobOfferApprovalSuccessState extends JobOfferState{}

final class  JobOfferApprovalFailureState extends JobOfferState{
  final String message;

  JobOfferApprovalFailureState({required this.message});
}


 final class  AttachmentUploadFileState extends JobOfferState{}
  final class  AttachmentDeletionFileState extends JobOfferState{}

  final class  changeUploadFileToApproveState extends JobOfferState{}