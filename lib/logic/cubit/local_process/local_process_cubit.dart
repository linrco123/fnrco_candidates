// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/documents_category.dart';
import 'package:fnrco_candidates/data/models/local_process_model.dart';
import 'package:meta/meta.dart';

import 'package:fnrco_candidates/data/api_provider/local_process.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
part 'local_process_state.dart';

class LocalProcessCubit extends Cubit<LocalProcessState> {
  LocalProcessProvider localProcessProvider;
  LocalProcessCubit(
    this.localProcessProvider,
  ) : super(LocalProcessInitial());

  getLocalProcessData() {
    emit(GetLocalProcessDataLoadingState());
    localProcessProvider.getLocalProcess().then((value) {
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

  var localProcessAttachments =
      List<LocalProcessPipeLine>.empty(growable: true);

  void storeLocalProcessAttachments(List<LocalProcessPipeLine> list) {
    // ignore: unused_local_variable
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
    if (result != null) {
      localProcessAttachments
          .where((element) => element.stepId! == stepId)
          .toList()
          .single
          .changeFilePath(result.files.single.path!);

      emit(LocalProcessUploadAttachmentState());
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

  bool _checkEmptyFile() {
    return localProcessAttachments
        .where((pipeLine) => pipeLine.pathFile!.isEmpty)
        .toList()
        .isNotEmpty;
  }

  void submitAttachments(context) {
    if (_checkEmptyFile()) {
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
        request.fields['data[$i][step_id]'] =
            localProcessAttachments[i].stepId!.toString();
      }

      for (int i = 0; i < localProcessAttachments.length; i++) {
        logger.e(
            '============================local process files=====================');

        //bool exist = await File(localProcessAttachments[i].pathFile!).exists();
        if (true) {
          logger.e('===========================iiiiiiiiiii===${i+1}===============');
          logger.d(
              '============================exist   ${await File(localProcessAttachments[i].pathFile!).exists()}=====================');
          logger.e(
              '==============filepath==============${localProcessAttachments[i].pathFile!}=====================');

          String filePath = localProcessAttachments[i]
              .pathFile!
              .replaceAll(RegExp(r'^File: '), '')
              .replaceAll(RegExp(r"^'|'$"), '')
              .trim();

          request.files.add(
              await http.MultipartFile.fromPath('data[$i][file]', filePath));
        }
      }

      // http.StreamedResponse streamedResponse = await request.send();
      // final response = await http.Response.fromStream(streamedResponse);
      // print('=====================local proceess response=============');
      // logger.e(response.body);
      // if (response.statusCode == 200) {
      //   emit(SubmitLocalProcessAttachmentsSuccessState());
      // } else {
      //   emit(SubmitLocalProcessAttachmentsFailureState(
      //       message: translateLang(context, "msg_request_failure")));
      // }
    } catch (e) {
       logger.e(
              '==============error=====================');
              logger.e(e.toString());

      emit(SubmitLocalProcessAttachmentsFailureState(
          message: translateLang(context, "msg_request_failure")));
    }
  }
}
