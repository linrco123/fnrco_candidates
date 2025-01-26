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
import 'package:fnrco_candidates/data/models/documents_category.dart';
import 'package:fnrco_candidates/data/models/local_process_model.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fnrco_candidates/data/api_provider/local_process.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
part 'local_process_state.dart';

class LocalProcessCubit extends Cubit<LocalProcessState> {
  LocalProcessProvider localProcessProvider;
  LocalProcessCubit(
    this.localProcessProvider,
  ) : super(LocalProcessInitial());
  final localProcessApplications = List<LocalProcessApp>.empty(growable: true);
  getLocalProcessData() {
    emit(GetLocalProcessDataLoadingState());
    localProcessProvider.getLocalProcess().then((value) {
      localProcessApplications.addAll(value.applications!);
      emit(GetLocalProcessDataSuccessState(applications: value.applications!));
    }).catchError((error) {
      emit(GetLocalProcessDataFailureState(message: error.failure.message));
    });
  }

  void getDocumentsCategory() {
    emit(DocumentsCategoryGetLoadingState());
    localProcessProvider.getDocumentsCategory().then((value) {
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

  final localProcessAttachments =
      List<LocalProcessPipeLine>.empty(growable: true);

  void storeLocalProcessAttachments(List<LocalProcessPipeLine> list) {
    // ignore: unused_local_variable
    localProcessAttachments.clear();
    // localProcessAttachments.addAll(list);
    logger.e(
        ' localProcessAttachments.length======>>>. ${localProcessAttachments.length}');
    localProcessAttachments.length;
    // int i = 0;
    for (LocalProcessPipeLine pipeline in list) {
      localProcessAttachments.add(pipeline);
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

  void uploadAttachment(int stepId) async {
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
        localProcessAttachments
            .where((element) => element.stepId! == stepId)
            .toList()
            .single
            .changeFilePath(newFile.path);
      }

      emit(LocalProcessUploadAttachmentState());
    }
  }

  void printAttachments() {
    for (int i = 0; i < localProcessAttachments.length; i++) {
      logger.e('====================$i====================');
      logger.e(localProcessAttachments[i].pathFile);
    }
  }

  void deleteAttachment(int stepId) {
    //fileName = '';
    localProcessAttachments
        .where((element) => element.stepId! == stepId)
        .toList()
        .single
        .changeFilePath('');

    emit(LocalProcessDeleteAttachmentState());
  }

  // bool _checkEmptyFile() {
  //   return localProcessAttachments
  //       .where((pipeLine) => pipeLine.pathFile!.isEmpty)
  //       .toList()
  //       .isNotEmpty;
  // }

  void submitAttachments(context) {
    if (_checkNotNewAttachment()) {
      emit(LocalProcessCheckEmptyAttachmentState());
    } else {
      _submit(context);
    }
  }

  int candidate_application_id = 0;

  void passAppID(int Id) {
    candidate_application_id = Id;
  }

  void _submit(context) async {
    emit(SubmitLocalProcessAttachmentsLoadingState());
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

      for (int i = 0; i < localProcessAttachments.length; i++) {
        if (_checkEmptyOrHttpsElementInAttachments(
            localProcessAttachments[i].pathFile!)) {
          request.fields['data[$i][step_id]'] =
              localProcessAttachments[i].stepId!.toString();
        }
      }

      for (int i = 0; i < localProcessAttachments.length; i++) {
        logger.e(localProcessAttachments.length);

        if (_checkEmptyOrHttpsElementInAttachments(
            localProcessAttachments[i].pathFile!)) {
          File file = File(localProcessAttachments[i].pathFile!);
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
        emit(SubmitLocalProcessAttachmentsSuccessState());
      } else {
        emit(SubmitLocalProcessAttachmentsFailureState(
            message: translateLang(context, "msg_request_failure")));
      }
    } catch (e) {
      logger.e('==============error=====================');
      logger.e(e.toString());

      emit(SubmitLocalProcessAttachmentsFailureState(
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
  //   final List<LocalProcessPipeLine> list = localProcessAttachments
  //       .where((element) =>
  //           element.pathFile!.isEmpty || element.pathFile!.contains('https'))
  //       .toList();

  //   for (int i = 0; i < list.length; i++) {
  //     localProcessAttachments.remove(list[i]);
  //   }
  // }

  bool _checkNotNewAttachment() {
    return localProcessAttachments
        .where((element) =>
            _checkEmptyOrHttpsElementInAttachments(element.pathFile!))
        .toList()
        .isEmpty;
  }

  bool _checkEmptyOrHttpsElementInAttachments(String path) {
    return path.isNotEmpty && !path.contains('https');
  }
}
