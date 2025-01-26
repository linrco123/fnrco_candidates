// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/classes/dio_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';

import 'package:fnrco_candidates/data/api_provider/request.dart';
import 'package:fnrco_candidates/data/models/request_model.dart';
import 'package:path_provider/path_provider.dart';
part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestProvider requestProvider;
  RequestCubit(
    this.requestProvider,
  ) : super(RequestInitial());

  final formKey = GlobalKey<FormState>();
  final titleCntroller = TextEditingController();
  final descCntroller = TextEditingController();

  File? attachment;
  String fileName = '';

  void uploadRequestFile() async {
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileName = result.files.single.name;
      attachment = File(result.files.single.path!);
      emit(AttachmentUploadFileState());
    }
  }

  void deleteRequestFile() {
    fileName = '';
    emit(AttachmentDeletionFileState());
  }

  String? validateTitle(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_title");
    }
    return null;
  }

  String? validateDescription(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_desc");
    }
    return null;
  }

  bool isFileDownloaded = false;
  final requests = List<RequestData>.empty(growable: true);
  void getRequestData() {
    emit(GetRequestDataLoadingState());
    requests.clear();
    requestProvider.getRequestData().then((value) {
      requests.addAll(value.data!);
      emit(GetRequestDataSuccessState(requests: value.data!));
    }).catchError((error) {
      emit(GetRequestDataFailureState(message: error.failure.message));
    });
  }

  void downloadRequestAttachment(String path) async {
    try {
      emit(RequestFileDownloadLoadingState());

      final String filename = path.split('/').last;
      final Directory? dirPath;
      if (Platform.isIOS) {
        dirPath = await getDownloadsDirectory();
      } else {
        dirPath = await getTemporaryDirectory();
      }

      if (await dirPath!.exists()) {
        final newPath = '${dirPath.path}/$filename';
        DioHelper.dio.download(path, newPath).then((value) {
          isFileDownloaded = true;
          emit(RequestFileDownloadSuccessState());
        }).catchError((error) {
          emit(RequestFileDownloadFailureState(message: error.toString()));
        });
      }
    } catch (error) {
      emit(RequestFileDownloadFailureState(message: error.toString()));
    }
  }

  Future<void> submit(RequestData request) async {
    if (attachment == null) {
      emit(RequestChooseFileState());
    } else {
      emit(RequestSubmitLoadingState());
      FormData formData = FormData.fromMap({
        'candidate_application_id': request.candidateAppId,
        'documentation_request_id': request.requestId,
        'file_name': descCntroller.text
      });
      if (attachment != null) {
        if (await attachment!.exists()) {
          formData.files.add(
              MapEntry('file', await MultipartFile.fromFile(attachment!.path)));
        }
      }

      requestProvider.submitRequest(formData).then((value) {
        emit(RequestSubmitSuccessState());
      }).catchError((error) {
        emit(RequestFileDownloadFailureState(message: error.failure.message));
      });
    }
  }

  void sendRequestApproval(RequestData request, bool value) async {
    if (value) {
      emit(RequestApprovalLoadingState());
    } else {
      emit(RequestRejectionLoadingState());
    }

    FormData formData = FormData.fromMap({
      'candidate_application_id': request.candidateAppId,
      'documentation_request_id': request.requestId,
      'file_name': descCntroller.text,
      "candidate_approval": value,
    });
    if (attachment != null) {
      if (await attachment!.exists()) {
        formData.files.add(
            MapEntry('file', await MultipartFile.fromFile(attachment!.path)));
      }
    }

    requestProvider.submitRequest(formData).then((value) {
      emit(RequestApprovalSuccessState());
    }).catchError((error) {
      emit(RequestApprovalFailureState(message: error.failure.message));
    });
  }
}
