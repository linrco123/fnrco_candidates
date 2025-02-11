// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/required_documents.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import 'package:fnrco_candidates/data/models/required_documents.dart';
import 'package:fnrco_candidates/logic/cubit/required_documents/required_documents_state.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class RequiredDocumentsCubit extends Cubit<RequiredDocumentsState> {
  RequiredDocumentsProvider requiredDocumentsProvider;
  RequiredDocumentsCubit(
    this.requiredDocumentsProvider,
  ) : super(RequiredDocumentsInitial());

  final jobApplications = List<JobApplication>.empty(growable: true);

  getJobApplications() {
    emit(GetRequiredDocumentsAppsLoadingState());
    requiredDocumentsProvider.getJobApplications().then((value) {
      jobApplications.addAll(value.applications!);
      emit(GetRequiredDocumentsAppsSuccessState(
          applications: value.applications!));
    }).catchError((error) {
      emit(
          GetRequiredDocumentsAppsFailureState(message: error.failure.message));
    });
  }

  getRequiredDocumentsData(int appID) {
    emit(GetRequiredDocumentsDataLoadingState());
    requiredDocumentsProvider.getRequiredDocuments(appID).then((value) {
      storeRequiredDocuments(value.data!.requiredDocuments!);
      value.data!.requiredDocuments;
      emit(GetRequiredDocumentsDataSuccessState(
          docs: value.data!.requiredDocuments!));
    }).catchError((error) {
      emit(
          GetRequiredDocumentsDataFailureState(message: error.failure.message));
    });
  }

  void getDocumentsCategory() {
    emit(DocumentsCategoryGetLoadingState());
    requiredDocumentsProvider.getDocumentsCategory().then((value) {
      emit(DocumentsCategoryGetSuccessState(documents: value.documents!));
    }).catchError((error) {
      emit(DocumentsCategoryGetFailureState(message: error.failure.message));
    });
  }

  String? documentCategory;
  void selectDocCategory(String category) {
    documentCategory = category;
    // emit(ChooseDocumentCategoryState());
  }

  final requiredDocumentsAttachments =
      List<RequiredDocument>.empty(growable: true);

  void storeRequiredDocuments(List<RequiredDocument> list) {
    // ignore: unused_local_variable
    requiredDocumentsAttachments.clear();
    // RequiredDocumentsAttachments.addAll(list);
    logger.e(
        ' RequiredDocumentsAttachments.length======>>>. ${requiredDocumentsAttachments.length}');
    requiredDocumentsAttachments.length;
    // int i = 0;
    for (RequiredDocument doc in list) {
      requiredDocumentsAttachments.add(doc);
    }
  }

  void requestPermission() async {
    final PermissionStatus result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      //uploadAttachment();
    } else if (result == PermissionStatus.denied) {
      print('give permission for app to accesss local storage');
    } else if (result == PermissionStatus.permanentlyDenied) {
      // access settings to grant app permission
    }
  }

  void uploadAttachment(RequiredDocument doc) async {
    if(doc.verified == 'verified'){
      emit(RequiredDocumentVerifiedState());
    }
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      // Open file picker

      File originalFile = File(result.files.single.path!);

      // Get app's document directory
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      String newFilePath = '$appDocPath/${originalFile.path.split('/').last}';
      logger.e('===================file path======================');
      logger.e(newFilePath);
      // Copy the file
      File newFile = await originalFile.copy(newFilePath);

      // Verify file existence
      if (await newFile.exists()) {
        requiredDocumentsAttachments
            .where((element) => element.stepId! == doc.stepId)
            .toList()
            .single
            .changeFilePath(newFile.path);
      }

      emit(RequiredDocumentsUploadAttachmentState());
    }
  }

  void printAttachments() {
    for (int i = 0; i < requiredDocumentsAttachments.length; i++) {
      logger.e('====================$i====================');
      logger.e(requiredDocumentsAttachments[i].filePath);
    }
  }

  void deleteAttachment(int stepId) {
    //fileName = '';
    requiredDocumentsAttachments
        .where((element) => element.stepId! == stepId)
        .toList()
        .single
        .changeFilePath('');

    emit(RequiredDocumentsDeleteAttachmentState());
  }

  // bool _checkEmptyFile() {
  //   return RequiredDocumentsAttachments
  //       .where((pipeLine) => pipeLine.pathFile!.isEmpty)
  //       .toList()
  //       .isNotEmpty;
  // }

  void submitAttachments(context) {
    if (_checkNotNewAttachment()) {
      emit(RequiredDocumentsCheckEmptyAttachmentState());
    } else {
      _submit(context);
    }
  }

  int candidate_application_id = 0;

  void passAppID(int Id) {
    candidate_application_id = Id;
  }

  void _submit(context) async {
    emit(SubmitRequiredDocumentsAttachmentsLoadingState());
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('${AppLinks.baseUrl}${AppLinks.submit_local_process}'));

      Map<String, String> headers = {
        "content-type": "application/json",
        "accept": "application/json",
        "Auth": "bearer ${CacheHelper.userToken}"
      };

      request.headers.addAll(headers);

      request.fields.addAll({
        'candidate_application_id': candidate_application_id.toString(),
      });

      for (int i = 0; i < requiredDocumentsAttachments.length; i++) {
        if (_checkEmptyOrHttpsElementInAttachments(
            requiredDocumentsAttachments[i].filePath!)) {
          request.fields['data[$i][step_id]'] =
              requiredDocumentsAttachments[i].stepId!.toString();
        }
      }

      for (int i = 0; i < requiredDocumentsAttachments.length; i++) {
        logger.e(requiredDocumentsAttachments.length);

        if (_checkEmptyOrHttpsElementInAttachments(
            requiredDocumentsAttachments[i].filePath!)) {
          File file = File(requiredDocumentsAttachments[i].filePath!);
          logger.e('=======================file===$i===============');
          logger.e(await file.exists());
          if (await file.exists()) {
            var filePath = file.path
                .replaceAll(RegExp(r'^File: '), '')
                .replaceAll(RegExp(r"^'|'$"), '')
                .trim();
            request.files.add(
                await http.MultipartFile.fromPath('data[$i][file]', filePath));
          }
        }
      }

      http.StreamedResponse streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      logger.e('===========================response=============');
      logger.e(response.body);
      if (response.statusCode == 200) {
        emit(SubmitRequiredDocumentsAttachmentsSuccessState());
      } else {
        emit(SubmitRequiredDocumentsAttachmentsFailureState(
            message: translateLang(context, "msg_request_failure")));
      }
    } catch (e) {
      logger.e('==============error=====================');
      logger.e(e.toString());

      emit(SubmitRequiredDocumentsAttachmentsFailureState(
          message: translateLang(context, "msg_request_failure")));
    }
  }

  File? pdfFile;
  Future<void> convertUrlFileToPdfFile(String url) async {
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
        pdfFile = file;
      }
      completer.complete(file);
    } catch (e) {}
  }

  Widget showDocument(String path, double value) {
    if (path.contains('.pdf')) {
      if (path.contains('https')) {
        return SizedBox(
            height: 300.0,
            width: double.infinity,
            child: SfPdfViewer.network(
              path,
            ));
      } else {
        return SizedBox(
            height: 300.0,
            width: double.infinity,
            child: PDFView(
              filePath: path,
            ));
      }
    } else {
      if (path.contains('https')) {
        return CachedNetworkImage(
          // height: 300.0,
          width: double.infinity,
          fit: BoxFit.cover,
          imageUrl: path,
          progressIndicatorBuilder: (context, url, progress) =>
              AnimatedLoadingWidget(),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: AppColors.primary,
            size: 25.0,
          ),
        );
      } else {
        return Image.file(
          File(path),
          // height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      }
    }
  }

  // void _deleteEmptyAndUploadedFiles() {
  //   final List<RequiredDocumentsPipeLine> list = RequiredDocumentsAttachments
  //       .where((element) =>
  //           element.pathFile!.isEmpty || element.pathFile!.contains('https'))
  //       .toList();

  //   for (int i = 0; i < list.length; i++) {
  //     RequiredDocumentsAttachments.remove(list[i]);
  //   }
  // }

  bool _checkNotNewAttachment() {
    return requiredDocumentsAttachments
        .where((element) =>
            _checkEmptyOrHttpsElementInAttachments(element.filePath!))
        .toList()
        .isEmpty;
  }

  bool _checkEmptyOrHttpsElementInAttachments(String path) {
    return path.isNotEmpty && !path.contains('https');
  }
}
