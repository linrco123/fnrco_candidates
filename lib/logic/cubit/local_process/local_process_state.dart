part of 'local_process_cubit.dart';

@immutable
sealed   class  LocalProcessState {}

final   class  LocalProcessInitial extends LocalProcessState {}


final   class  GetLocalProcessDataLoadingState extends LocalProcessState {}        

 final class  GetLocalProcessDataSuccessState extends LocalProcessState {
  final List<LocalProcessApp> applications;

  GetLocalProcessDataSuccessState({required this.applications});
}        

final   class  GetLocalProcessDataFailureState extends LocalProcessState {
  final String message;

  GetLocalProcessDataFailureState({required this.message});
}        


final class  DocumentsCategoryGetLoadingState extends LocalProcessState{}

final class  DocumentsCategoryGetSuccessState extends LocalProcessState{
  final List<DocumentInfo> documents;

  DocumentsCategoryGetSuccessState({required this.documents});
}

final class  DocumentsCategoryGetFailureState extends LocalProcessState{
   final String message;

  DocumentsCategoryGetFailureState({required this.message});
}


final class  ChooseDocumentCategoryState extends LocalProcessState{}

final class  LocalProcessUploadAttachmentState extends LocalProcessState{}




final class  LocalProcessDeleteAttachmentState extends LocalProcessState{}

final class  LocalProcessCheckEmptyAttachmentState extends LocalProcessState{}


final class  SubmitLocalProcessAttachmentsLoadingState extends LocalProcessState{}


final class  SubmitLocalProcessAttachmentsSuccessState extends LocalProcessState{}


final class  SubmitLocalProcessAttachmentsFailureState extends LocalProcessState{
  final String message;

  SubmitLocalProcessAttachmentsFailureState({required this.message});
}