part of 'local_process_cubit.dart';

@immutable
sealed class LocalProcessState {}

final class LocalProcessInitial extends LocalProcessState {}


final class GetLocalProcessDataLoadingState extends LocalProcessState {}        

 class GetLocalProcessDataSuccessState extends LocalProcessState {
  final List<LocalProcessApp> applications;

  GetLocalProcessDataSuccessState({required this.applications});
}        

final class GetLocalProcessDataFailureState extends LocalProcessState {
  final String message;

  GetLocalProcessDataFailureState({required this.message});
}        


class DocumentsCategoryGetLoadingState extends LocalProcessState{}

class DocumentsCategoryGetSuccessState extends LocalProcessState{
  final List<DocumentInfo> documents;

  DocumentsCategoryGetSuccessState({required this.documents});
}

class DocumentsCategoryGetFailureState extends LocalProcessState{
   final String message;

  DocumentsCategoryGetFailureState({required this.message});
}


class ChooseDocumentCategoryState extends LocalProcessState{}

class LocalProcessUploadAttachmentState extends LocalProcessState{}




class LocalProcessDeleteAttachmentState extends LocalProcessState{}

class LocalProcessCheckEmptyAttachmentState extends LocalProcessState{}


class SubmitLocalProcessAttachmentsLoadingState extends LocalProcessState{}


class SubmitLocalProcessAttachmentsSuccessState extends LocalProcessState{}


class SubmitLocalProcessAttachmentsFailureState extends LocalProcessState{
  final String message;

  SubmitLocalProcessAttachmentsFailureState({required this.message});
}