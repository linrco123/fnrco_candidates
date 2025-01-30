part of 'request_cubit.dart';

@immutable
sealed   class  RequestState {}

final   class  RequestInitial extends RequestState {}

final class  GetRequestDataLoadingState extends RequestState {}

final class  GetRequestDataSuccessState extends RequestState {
  final List<RequestData> requests;

  GetRequestDataSuccessState({required this.requests});
}

final class  GetRequestDataFailureState extends RequestState {
  final String message;

  GetRequestDataFailureState({required this.message});
}

final class  AttachmentDeletionFileState extends RequestState {}

final class  AttachmentUploadFileState extends RequestState {}

final class  RequestFileDownloadLoadingState extends RequestState {}

final class  RequestFileDownloadSuccessState extends RequestState {}

final class  RequestFileDownloadFailureState extends RequestState {
  final String message;

  RequestFileDownloadFailureState({required this.message});
}

final class  RequestSubmitLoadingState extends RequestState {}

final class  RequestSubmitSuccessState extends RequestState {}

final class  RequestSubmitfailureState extends RequestState {
  final String messsage;

  RequestSubmitfailureState({required this.messsage});
}

final class  RequestChooseFileState extends RequestState {}

final class  RequestApprovalLoadingState extends RequestState {}

final class  RequestApprovalSuccessState extends RequestState {}

final class  RequestApprovalFailureState extends RequestState {
  final String message;

  RequestApprovalFailureState({required this.message});
}

final class  RequestRejectionLoadingState extends RequestState {}

// final class  RequestRejectionSuccessState extends RequestState {}

// final class  RequestRejectionFailureState extends RequestState {
//   final String message;

//   RequestRejectionFailureState({required this.message});
// }
