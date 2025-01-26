part of 'shared_documents_cubit.dart';

@immutable
sealed class SharedDocumentsState {}

final class SharedDocumentsInitial extends SharedDocumentsState {}



// class SharedDocumentsGetAppsLoadingState extends SharedDocumentsState {}

// class SharedDocumentsGetAppsSuccessState extends SharedDocumentsState {
//   final List<SharedDocsApplication> applications;

//   SharedDocumentsGetAppsSuccessState({required this.applications});
// }

// class SharedDocumentsGetAppsfailureState extends SharedDocumentsState {
//   final String message;

//   SharedDocumentsGetAppsfailureState({required this.message});
// }



class SharedDocumentsGetDetailsLoadingState extends SharedDocumentsState {}

class SharedDocumentsGetDetailsSuccessState extends SharedDocumentsState {
  final List<SharedDocument> sharedDocuments;

  SharedDocumentsGetDetailsSuccessState({required this.sharedDocuments});
}

class SharedDocumentsGetDetailsfailureState extends SharedDocumentsState {
  final String message;

  SharedDocumentsGetDetailsfailureState({required this.message});
}




class GetJobApplicationsLoadingState extends SharedDocumentsState{}

class GetJobApplicationsSuccessState extends SharedDocumentsState{
  final List<JobApplication>  applications;

  GetJobApplicationsSuccessState({required this.applications});

  // GetJobOfferApplicationsSuccessState(this.applications);
}

class GetJobApplicationsFailureState extends SharedDocumentsState{
    final String message;

  GetJobApplicationsFailureState({required this.message});
}

class ChooseDocumentState extends SharedDocumentsState{}


class SharedDocumentDownloadLoadingState extends SharedDocumentsState{}

class SharedDocumentDownloadSuccessState extends SharedDocumentsState{}

class SharedDocumentDownloadFailureState extends SharedDocumentsState{
  final String message;

  SharedDocumentDownloadFailureState({required this.message});
}