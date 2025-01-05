// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/data/api_provider/job_offer.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import 'package:path_provider/path_provider.dart';

part 'job_offer_state.dart';

class JobOfferCubit extends Cubit<JobOfferState> {
  JobOfferProvider jobOfferProvider;
  JobOfferCubit(
    this.jobOfferProvider,
  ) : super(JobOfferInitial());

  // void getJobOffer(int index) {
  //   emit(GetJobOfferApplicationsLoadingState());
  //   jobOfferProvider.getJobOffer().then((value) {
  //     convertPdfData(value.toString());
  //   }).catchError((error) {
  //     emit(GetJobofferErrorState(error.failure.message));
  //   });
  // }

  //  void requestPersmission() async {
  //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  // }

  Future<void> getTemp() async {
    getTemporaryDirectory();
    getApplicationDocumentsDirectory();
    Dio dio = Dio();
    //   Directory tempDir =
    //       await getTemporaryDirectory();
    //   String filePath =
    //       '${tempDir.path}/${"NameOfPdf"}.pdf';
    //   await dio.download(
    //       "UrlOfPdf", filePath);
    //   OpenFilex.open(filePath);
    // } catch (e) {
    //   Fluttertoast.showToast(
    //     msg: "Error: $e",
    //     backgroundColor: Colors.red,
    //     webBgColor: '#FF0000',
    //     timeInSecForIosWeb: 2,
    //   );// Handle Error or show toasts
  }

  File? jobOffer;
  Future<void> convertJobOfferToPdfFile(String url) async {
    emit(GetJobofferLoadingState());
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
        jobOffer = file;
      }
      emit(GetJobofferSuccessState(file));
      completer.complete(file);
    } catch (e) {
      emit(GetJobofferErrorState(e.toString()));
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
    emit(JobOfferDownloadPDFLoadingState());
    var fileName = jobOffer.substring(jobOffer.lastIndexOf('/') + 1);
    var urlDir = await getTemporaryDirectory();
    Dio().download(jobOffer, '${urlDir.path}/${fileName}').then((value) {
      emit(JobOfferDownloadPDFSuccessState());
    }).catchError((error) {
      emit(JobOfferDownloadPDFFailureState());
    });
    // File file = File(path)
  }

  var jobApplications = List.empty(growable: true);

  getJobApplications() {
    emit(GetJobOfferApplicationsLoadingState());
    jobOfferProvider.getJobApplications().then((value) {
      emit(GetJobOfferApplicationsSuccessState(
          applications: value.applications!));
    }).catchError((error) {
      emit(GetJobOfferApplicationsFailureState(message: error.failure.message));
    });
  }

  void sendJobOfferApproval(int appId, bool value) {
    if (value) {
      emit(JobOfferApprovalLoadingState());
    } else {
      emit(JobOfferRejectLoadingState());
    }

    Map data = {
      "candidate_application_id": appId,
      "candidate_approval": value,
      "candidate_comment": "job offer stage",
      "stage": job_offer.toString()
    };

    jobOfferProvider.sendJobOfferApproval(data).then((value) {
      emit(JobOfferApprovalSuccessState());
    }).catchError((error) {
      emit(JobOfferApprovalFailureState(message: error.failure.message));
    });
  }
}
