import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
part 'job_offer_state.dart';

class JobOfferCubit extends Cubit<JobOfferState> {
  JobOfferCubit() : super(JobOfferInitial());

  void getJobOffer() {
    emit(GeneratingPDFLoadingState());
    //TODO: task of getting job offer
    //getJobOffer
    //if success
    convertPdfData(' url_job_offer');
    //if converted successfully emit(GeneratingPDFSuccessState(pdf: file));
    //if not
    //emit(GeneratingPDFErrorState(message: e.toString()));
  }

  Future<void> convertPdfData(String url) async {
    //emit(GeneratingPDFLoadingState());
    Completer<File> completer = Completer();
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      if (await file.exists()) {}
      emit(GeneratingPDFSuccessState(pdf: file));
      completer.complete(file);
    } catch (e) {
      emit(GeneratingPDFErrorState(message: e.toString()));
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
    var urlDir = await getExternalStorageDirectory();
    Dio().download(jobOffer, '${urlDir!.path}/${fileName}');
   // File file = File(path)
  }
}
