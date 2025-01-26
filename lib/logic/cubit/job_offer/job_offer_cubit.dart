// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/classes/dotted_border.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/job_offer.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

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
  // var jobApplications = List.empty(growable: true);
  final jobApplications = List<JobApplication>.empty(growable: true);

  getJobApplications() {
    emit(GetJobOfferApplicationsLoadingState());
    jobOfferProvider.getJobApplications().then((value) {
      jobApplications.addAll(value.applications!);
      emit(GetJobOfferApplicationsSuccessState(
          applications: value.applications!));
    }).catchError((error) {
      emit(GetJobOfferApplicationsFailureState(message: error.failure.message));
    });
  }

  Future<void> sendJobOfferApproval(int appId, bool value) async {
    if (value) {
      emit(JobOfferApprovalLoadingState());
    } else {
      emit(JobOfferRejectLoadingState());
    }
    FormData formData = FormData.fromMap({
      "candidate_application_id": appId,
      "candidate_approval": value ? 1 : 0,
      "candidate_comment": "job offer stage",
      "stage": job_offer.toString()
    });
    // Map data = {
    //   "candidate_application_id": appId,
    //   "candidate_approval": value,
    //   "candidate_comment": "job offer stage",
    //   "stage": job_offer.toString()
    // };
    if (attachment != null) {
      logger.e('=============== attachment!.exists()==============');
      logger.e(await attachment!.exists());
      formData.files.add(MapEntry(
          'approval_doc', await MultipartFile.fromFile(attachment!.path)));
    }

    jobOfferProvider.sendJobOfferApproval(formData).then((value) {
      emit(JobOfferApprovalSuccessState());
    }).catchError((error) {
      emit(JobOfferApprovalFailureState(message: error.failure.message));
    });
  }

  void changeUploadFileToApprove() {
    emit(changeUploadFileToApproveState());
  }
//////////////////////???????/////////////
  void showBottomSheet(context) {
    showCupertinoModalPopup(
      context: context,
      // isDismissible: true,
      // isScrollControlled: true,
      // constraints: BoxConstraints(maxHeight: 300),
      builder: (context) => Container(
        color: AppColors.primary,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 60,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomPaint(
                  painter: DottedBorderPainter(),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          enableFeedback: true,
                          maximumSize: Size(double.infinity, 70),
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 15.0),
                          iconColor: AppColors.primary,
                          visualDensity: VisualDensity.compact,
                          // textStyle:TextStyle(color: AppColors.grey, fontSize: 17.0) ,
                          side: BorderSide.none),
                      onPressed: () {
                        uploadRequestFile();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              fileName.isEmpty
                                  ? translateLang(context, "upload_attach")
                                  : fileName,
                              style: TextStyle(
                                  color: AppColors.grey, fontSize: 16.0),
                            ),
                          ),
                          const Spacer(),
                          fileName.isEmpty
                              ? Icon(
                                  Icons.upload_file_rounded,
                                  color: AppColors.primary,
                                  size: 25.0,
                                )
                              : InkWell(
                                  onTap: () {
                                    deleteRequestFile();
                                  },
                                  child: Icon(
                                    CupertinoIcons.delete_simple,
                                    color: AppColors.primary,
                                    size: 25.0,
                                  ))
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
