part of 'shared_documents_cubit.dart';

@immutable
sealed   class  SharedDocumentsState {}

final   class  SharedDocumentsInitial extends SharedDocumentsState {}



// final class  SharedDocumentsGetAppsLoadingState extends SharedDocumentsState {}

// final class  SharedDocumentsGetAppsSuccessState extends SharedDocumentsState {
//   final List<SharedDocsApplication> applications;

//   SharedDocumentsGetAppsSuccessState({required this.applications});
// }

// final class  SharedDocumentsGetAppsfailureState extends SharedDocumentsState {
//   final String message;

//   SharedDocumentsGetAppsfailureState({required this.message});
// }



final class  SharedDocumentsGetDetailsLoadingState extends SharedDocumentsState {}

final class  SharedDocumentsGetDetailsSuccessState extends SharedDocumentsState {
  final List<SharedDocument> sharedDocuments;

  SharedDocumentsGetDetailsSuccessState({required this.sharedDocuments});
}

final class  SharedDocumentsGetDetailsfailureState extends SharedDocumentsState {
  final String message;

  SharedDocumentsGetDetailsfailureState({required this.message});
}




final class  GetJobApplicationsLoadingState extends SharedDocumentsState{}

final class  GetJobApplicationsSuccessState extends SharedDocumentsState{
  final List<JobApplication>  applications;

  GetJobApplicationsSuccessState({required this.applications});

  // GetJobOfferApplicationsSuccessState(this.applications);
}

final class  GetJobApplicationsFailureState extends SharedDocumentsState{
    final String message;

  GetJobApplicationsFailureState({required this.message});
}

final class  ChooseDocumentState extends SharedDocumentsState{}


final class  SharedDocumentDownloadLoadingState extends SharedDocumentsState{}

final class  SharedDocumentDownloadSuccessState extends SharedDocumentsState{}

final class  SharedDocumentDownloadFailureState extends SharedDocumentsState{
  final String message;

  SharedDocumentDownloadFailureState({required this.message});
}