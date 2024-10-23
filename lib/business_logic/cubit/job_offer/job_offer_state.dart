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