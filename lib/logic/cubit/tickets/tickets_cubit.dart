// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
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

  void gfgfgfggff() async {
    try {
      print('===================file================+${files.length}');
      int f1 = await files[0].length();
      int f2 = await files[1].length();
      print("=================f1===========+$f1");
      print("=================f2===========+$f2");
    } catch (e) {
      print('====================erooro=================');
      print(e);
    }
  }

  void tryyyy() async {
    print('===================file================+${files.length}');
    int f1 = await files[0].length();
    int f2 = await files[1].length();
    print("=================f1===========+$f1");
    print("=================f2===========+$f2");
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://develop.fnrcoerp.com/api/ticket'));

    request.fields.addAll({
      'ui_widget_id': '3',
      'erp_ticket_title': 'Vacation Request',
      'erp_ticket_priority': 'high',
      'erp_ticket_text': 'Vacation Request Vacation Request',
      'files[0][erp_ticket_remarks]': 'Vacation Medical Report',
      'files[1][erp_ticket_remarks]': 'Vacation Medical Report sec',
      'erp_ticket_data[0][erp_ticket_data_type]': 'date',
      'erp_ticket_data[0][erp_ticket_data_name]': 'Vacation start Date',
      'erp_ticket_data[0][erp_ticket_data_value]': '2024-12-04',
      'erp_ticket_data[1][erp_ticket_data_type]': 'date',
      'erp_ticket_data[1][erp_ticket_data_name]': 'Vacation End Date',
      'erp_ticket_data[1][erp_ticket_data_value]': '2024-12-05'
    });

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "Auth": "bearer ${CacheHelper.userToken}"
    };
    request.headers.addAll(headers);

    request.files.add(await http.MultipartFile.fromPath(
        'files[0][erp_ticket_file]', files[0].path));
    request.files.add(await http.MultipartFile.fromPath(
        'files[1][erp_ticket_file]', files[1].path));
    http.StreamedResponse response = await request.send();
    print('===============response==============================');
    print(response.statusCode);
////////////////////////////////////////////////////////////////////////////

    // var data = FormData.fromMap({
    //   'files': files,
    //   'ui_widget_id': '3',
    //   'erp_ticket_title': 'Vacation Request',
    //   'erp_ticket_priority': 'high',
    //   'erp_ticket_text': 'Vacation Request Vacation Request',
    //   'files[0][erp_ticket_remarks]': 'Vacation Medical Report',
    //   'files[1][erp_ticket_remarks]': 'Vacation Medical Report sec',
    //   'erp_ticket_data[0][erp_ticket_data_type]': 'date',
    //   'erp_ticket_data[0][erp_ticket_data_name]': 'Vacation start Date',
    //   'erp_ticket_data[0][erp_ticket_data_value]': '2024-12-04',
    //   'erp_ticket_data[1][erp_ticket_data_type]': 'date',
    //   'erp_ticket_data[1][erp_ticket_data_name]': 'Vacation End Date',
    //   'erp_ticket_data[1][erp_ticket_data_value]': '2024-12-05'
    // });

    // var dio = Dio();
    // var response = await dio.request(
    //   'https://develop.fnrcoerp.com/api/ticket',
    //   options: Options(
    //     method: 'POST',
    //     // headers: headers,
    //   ),
    //   data: data,
    // );
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

  var priorties = List.empty(growable: true);
  var types = List.empty(growable: true);

  void submitTicket() {
    if (formKey.currentState!.validate()) {
      print('=====================tickets===================');
      emit(SubmitTicketLoadingState());
      addType();
      // var data = FormData.fromMap({
      //   "ui_widget_id": "3",
      //   "erp_ticket_title": subController.text,
      //   "erp_ticket_text": txtController.text,
      //   // "files": files,
      //   // "erp_ticket_data": erp_ticket_data
      // });
      var data = FormData.fromMap({
        'files': files,
        'ui_widget_id': '3',
        'erp_ticket_title': 'Vacation Request',
        'erp_ticket_priority': 'high',
        'erp_ticket_text': 'Vacation Request Vacation Request',
        'files[0][erp_ticket_remarks]': 'Vacation Medical Report',
        'files[1][erp_ticket_remarks]': 'Vacation Medical Report sec',
        'erp_ticket_data[0][erp_ticket_data_type]': 'date',
        'erp_ticket_data[0][erp_ticket_data_name]': 'Vacation start Date',
        'erp_ticket_data[0][erp_ticket_data_value]': '2024-12-04',
        'erp_ticket_data[1][erp_ticket_data_type]': 'date',
        'erp_ticket_data[1][erp_ticket_data_name]': 'Vacation End Date',
        'erp_ticket_data[1][erp_ticket_data_value]': '2024-12-05'
      });

      print('=====================tickets===================');
      print(data);

      ticketProvider.submitTicket(data).then((value) {
        emit(SubmitTicketSuccessState());
      }).catchError((error) {
        emit(SubmitTicketFailureState(message: error.failure.message));
      });

      emit(SubmitTicketFailureState(message: ''));
    }
  }

  // void selectPriority(Object p1) {
  //   priority = int.parse(p1.toString());
  // }

  void selectType(Object p1) {
    type = int.parse(p1.toString());
  }

  var files = List<File>.empty(growable: true);
  var erp_ticket_data = List<Map<String, dynamic>>.empty(growable: true);

  void addAttachmentAndRemark() async {
    try {
      if (ticket != null) {
        files.add(
          ticket!,
        );
        print('==============exist=====================');
        bool exist = await ticket!.exists();
        print(exist);
        print(ticket!.path);

        //empty attachment fields
        Future.delayed(const Duration(seconds: 1)).then((value) {
          ticket = null;
          fileName = '';
          remarksController.text = '';
          emit(emptyAttachmentAndRemarksState());
        });
      }
    } catch (e) {
      print('==============error===============');
      print(e);
    }
  }

  void printf() {
    files.forEach((value) {
      print('===========================');
      print(value);
    });
    // print(files);
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
