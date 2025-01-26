// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fnrco_candidates/data/api_provider/job_contract.dart';
import 'package:fnrco_candidates/data/models/job_contract_model.dart';

part 'contract_state.dart';

class JobContractCubit extends Cubit<ContractState> {
  JobContractProvider jobContractProvider;
  JobContractCubit(
    this.jobContractProvider,
  ) : super(ContractInitial());

  
  File? jobContract;
  Future<void> convertPdfData(String url) async {
    emit(GetJobContractLoadingState());
    Completer<File> completer = Completer();
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      if (await file.exists()) {
        jobContract = file;
      }
      emit(GetJobContractSuccessState(contract: file));
      completer.complete(file);
    } catch (e) {
      emit(GetJobContractFailureState(message: e.toString()));
    }
  }

  var ContractApplications = List<ContractApplication>.empty(growable: true);

  getJobApplications() {
    emit(GetJobContractApplicationsLoadingState());
    jobContractProvider.getContractApplications().then((value) {
      ContractApplications.addAll(value.applications!);
      emit(GetJobContractApplicationsSuccessState(
          applications: value.applications!));
    }).catchError((error) {
      emit(GetJobContractApplicationsFailureState(
          message: error.failure.message));
    });
  }

  File? attachment;
  String fileName = '';

  void uploadRequestFile() async {
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileName = result.files.single.name;
      attachment = File(result.files.single.path!);
      filePicked = true;
      emit(AttachmentUploadFileState());
    }
  }

  void deleteRequestFile() {
    fileName = '';
    emit(AttachmentDeletionFileState());
  }

  bool filePicked = false;

  Future<void> sendJobOfferApproval(int appId, bool value) async {
    if (value) {
      emit(JobContractApprovalLoadingState());
    } else {
      emit(JobContractRejectLoadingState());
    }

    // Map data = {
    //   "candidate_application_id": appId.toString(),
    //   "candidate_approval": value,
    //   "candidate_comment": "job offer stage",
    //   "stage": candidate_contract.toString()
    // };
    FormData formData = FormData.fromMap({
      "candidate_application_id": appId.toString(),
      "candidate_approval": value ? 1 : 0,
      "candidate_comment": "job offer stage",
      "stage": candidate_contract.toString()
    });
    if (attachment != null) {
      formData.files.add(MapEntry(
          'approval_doc', await MultipartFile.fromFile(attachment!.path)));
    }

    jobContractProvider.sendJobContractApproval(formData).then((value) {
      emit(JobContractApprovalSuccessState());
    }).catchError((error) {
      emit(JobContractApprovalFailureState(message: error.failure.message));
    });
  }
}
