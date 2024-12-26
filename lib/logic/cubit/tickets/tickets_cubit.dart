// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/ticket_provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:http/http.dart' as http;

part 'tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  final TicketProvider ticketProvider;
  TicketsCubit(
    this.ticketProvider,
  ) : super(TicketsInitial());

  final formKey = GlobalKey<FormState>();
  final subController = TextEditingController();
  final txtController = TextEditingController();
  final remarksController = TextEditingController();
  final typeControler = TextEditingController();
  //int priority = 0;
  int type = 0;

  File? ticket;
  String fileName = '';

  String? validateSubject(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_tck_subject");
    }
    return null;
  }

  String? validateTckText(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_tck_text");
    }
    return null;
  }

  String? validateTckAttachRemarks(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_tck_attach_remarks");
    }
    return null;
  }

  String? validateTckType(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_tck_type");
    }
    return null;
  }

  void requestPermission() async {
    try {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        uploadTicketFile();
      } else if (result == PermissionStatus.denied) {
        print('give permission for app to accesss local storage');
      } else if (result == PermissionStatus.permanentlyDenied) {
        // access settings to grant app permission
      }
    } catch (e) {
      logger.e('================  requestPermission  ==================');
      logger.e(e);
    }
  }

  void submitTicket(context) async {
    emit(SubmitTicketLoadingState());
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${AppLinks.baseUrl}${AppLinks.ticket}'));

      Map<String, String> headers = {
        "content-type": "application/json",
        "accept": "application/json",
        "Auth": "bearer ${CacheHelper.userToken}"
      };

      request.headers.addAll(headers);

      if (formKey.currentState!.validate()) {
        request.fields.addAll({
          'ui_widget_id': uIWidgetID.toString(),
          'erp_ticket_title': subController.text,
          'erp_ticket_priority': 'high',
          'erp_ticket_text': txtController.text,
        });

        for (int i = 0; i < files_remarks.length; i++) {
          request.fields['files[$i][erp_ticket_remarks]'] = files_remarks[i];
        }

        for (int i = 0; i < files.length; i++) {
          bool exist = await File(files[i].path).exists();
          if (exist) {
            String filePath = files[i]
                .path
                .replaceAll(RegExp(r'^File: '), '')
                .replaceAll(RegExp(r"^'|'$"), '')
                .trim();

            request.files.add(await http.MultipartFile.fromPath(
                'files[$i][erp_ticket_file]', filePath));
          }
        }

        for (int i = 0; i < erp_ticket_data.length; i++) {
          request.fields['erp_ticket_data[$i][erp_ticket_data_type]'] =
              erp_ticket_data[i]["erp_ticket_data_type"];

          request.fields["erp_ticket_data[$i][erp_ticket_data_name]"] =
              erp_ticket_data[i]["erp_ticket_data_name"];

          request.fields["erp_ticket_data[$i][erp_ticket_data_value]"] =
              erp_ticket_data[i]["erp_ticket_data_value"];
        }

        http.StreamedResponse streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode == 200) {
          emit(SubmitTicketSuccessState());
        } else {
          emit(SubmitTicketFailureState(
              message: translateLang(context, "msg_request_failure")));
        }
      }
    } catch (e) {
      emit(SubmitTicketFailureState(
          message: translateLang(context, e.toString())));
    }
  }

  void uploadTicketFile() async {
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileName = result.files.single.name;
      ticket = File(result.files.single.path!);
      emit(TicketUploadFileState());
    }
  }

  void deleteTicketFile() {
    fileName = '';
    emit(TicketDeletionFileState());
  }

  int? uIWidgetID = 0;
  void getUIWidget() {
    emit(TicketUIWidgetLoadingState());
    ticketProvider.getUIWidget().then((value) {
      uIWidgetID = value.data!.supporting!.first.id;
      emit(TicketUIWidgetSuccessState());
    }).catchError((error) {
      emit(TicketUIWidgetFailureState(message: error.message.toString()));
    });
  }

  void selectType(Object p1) {
    type = int.parse(p1.toString());
  }

  var files = List<File>.empty(growable: true);
  var files_remarks = List<String>.empty(growable: true);
  var erp_ticket_data = List<Map<String, dynamic>>.empty(growable: true);

  void addAttachmentAndRemark() async {
    try {
      if (ticket != null) {
        files.add(
          ticket!,
        );

        files_remarks.add(remarksController.text);

        //empty attachment fields
        Future.delayed(const Duration(seconds: 1)).then((value) {
          ticket = null;
          fileName = '';
          remarksController.clear();
          emit(emptyAttachmentAndRemarksState());
        });
      }
    } catch (e) {
      print('==============error===============');
      print(e);
    }
  }

  void addType() {
    erp_ticket_data.add({
      "erp_ticket_data_type": "select",
      "erp_ticket_data_name": "Type",
      "erp_ticket_data_value": typeControler.text
    });
  }

  var cseCntroller = TextEditingController();
  void addCause() {
    erp_ticket_data.add({
      "erp_ticket_data_type": "text",
      "erp_ticket_data_name": "Cause",
      "erp_ticket_data_value": cseCntroller.text
    });
  }
}
