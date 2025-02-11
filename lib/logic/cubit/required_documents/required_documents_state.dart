 //part of 'required_documents_cubit.dart';

import 'package:fnrco_candidates/data/models/documents_category.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import 'package:fnrco_candidates/data/models/required_documents.dart';

sealed   class  RequiredDocumentsState {}

final   class  RequiredDocumentsInitial extends RequiredDocumentsState {}


final class GetRequiredDocumentsAppsLoadingState extends RequiredDocumentsState{}
 
final class GetRequiredDocumentsAppsSuccessState extends RequiredDocumentsState{
  final List<JobApplication> applications;

  GetRequiredDocumentsAppsSuccessState({required this.applications});
}

final class GetRequiredDocumentsAppsFailureState extends RequiredDocumentsState{
  final String message;

  GetRequiredDocumentsAppsFailureState({required this.message});
}



final   class  GetRequiredDocumentsDataLoadingState extends RequiredDocumentsState {}        

 final class  GetRequiredDocumentsDataSuccessState extends RequiredDocumentsState {
  final List<RequiredDocument> docs;

  GetRequiredDocumentsDataSuccessState({required this.docs});
}        

final   class  GetRequiredDocumentsDataFailureState extends RequiredDocumentsState {
  final String message;

  GetRequiredDocumentsDataFailureState({required this.message});
}        


final class  DocumentsCategoryGetLoadingState extends RequiredDocumentsState{}

final class  DocumentsCategoryGetSuccessState extends RequiredDocumentsState{
  final List<DocumentInfo> documents;

  DocumentsCategoryGetSuccessState({required this.documents});
}

final class  DocumentsCategoryGetFailureState extends RequiredDocumentsState{
   final String message;

  DocumentsCategoryGetFailureState({required this.message});
}


final class  ChooseDocumentCategoryState extends RequiredDocumentsState{}

final class  RequiredDocumentsUploadAttachmentState extends RequiredDocumentsState{}




final class  RequiredDocumentsDeleteAttachmentState extends RequiredDocumentsState{}

final class  RequiredDocumentsCheckEmptyAttachmentState extends RequiredDocumentsState{}


final class  SubmitRequiredDocumentsAttachmentsLoadingState extends RequiredDocumentsState{}


final class  SubmitRequiredDocumentsAttachmentsSuccessState extends RequiredDocumentsState{}


final class  SubmitRequiredDocumentsAttachmentsFailureState extends RequiredDocumentsState{
  final String message;

  SubmitRequiredDocumentsAttachmentsFailureState({required this.message});
}

final class RequiredDocumentVerifiedState extends RequiredDocumentsState{}