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

  void uploadJobOffer() async {
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      String fileName = result.files.first.name;
      File cvFile = File(result.files.first.path!);
      //emit(JobApplicationUploadResumeState());
      _postJobOffer({});
    }
  }

  void _postJobOffer(Map data) {
    //TODO: code to upload (post) joboffer to backend
  }

  void downloadJobOffer(String jobOffer) async {
    emit(ContractDownloadPDFLoadingState());
    var fileName = jobOffer.substring(jobOffer.lastIndexOf('/') + 1);
    var urlDir = await getExternalStorageDirectory();
    Dio().download(jobOffer, '${urlDir!.path}/${fileName}').then((value) {
      emit(ContractDownloadPDFSuccessState());
    }).catchError((error) {
      emit(ContractDownloadPDFFailureState());
    });
    // File file = File(path)
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

  void sendJobOfferApproval(int appId, bool value) {
    if (value) {
      emit(JobContractApprovalLoadingState());
    } else {
      emit(JobContractRejectLoadingState());
    }

    Map data = {
      "candidate_application_id": appId.toString(),
      "candidate_approval": value,
      "candidate_comment": "job offer stage",
      "stage": candidate_contract.toString()
    };

    jobContractProvider.sendJobContractApproval(data).then((value) {
      emit(JobContractApprovalSuccessState());
    }).catchError((error) {
      emit(JobContractApprovalFailureState(message: error.failure.message));
    });
  }
}
