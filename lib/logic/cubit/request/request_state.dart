part of 'request_cubit.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}

class GetRequestDataLoadingState extends RequestState {}

class GetRequestDataSuccessState extends RequestState {
  final List<RequestData> requests;

  GetRequestDataSuccessState({required this.requests});
}

class GetRequestDataFailureState extends RequestState {
  final String message;

  GetRequestDataFailureState({required this.message});
}

class AttachmentDeletionFileState extends RequestState {}

class AttachmentUploadFileState extends RequestState {}

class RequestFileDownloadLoadingState extends RequestState {}

class RequestFileDownloadSuccessState extends RequestState {}

class RequestFileDownloadFailureState extends RequestState {
  final String message;

  RequestFileDownloadFailureState({required this.message});
}

class RequestSubmitLoadingState extends RequestState {}

class RequestSubmitSuccessState extends RequestState {}

class RequestSubmitfailureState extends RequestState {
  final String messsage;

  RequestSubmitfailureState({required this.messsage});
}

class RequestChooseFileState extends RequestState {}

class RequestApprovalLoadingState extends RequestState {}

class RequestApprovalSuccessState extends RequestState {}

class RequestApprovalFailureState extends RequestState {
  final String message;

  RequestApprovalFailureState({required this.message});
}

class RequestRejectionLoadingState extends RequestState {}

// class RequestRejectionSuccessState extends RequestState {}

// class RequestRejectionFailureState extends RequestState {
//   final String message;

//   RequestRejectionFailureState({required this.message});
// }
