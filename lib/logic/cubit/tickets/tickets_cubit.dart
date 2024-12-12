// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/ticket_provider.dart';

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
    final PermissionStatus result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      uploadTicketFile();
    } else if (result == PermissionStatus.denied) {
      print('give permission for app to accesss local storage');
    } else if (result == PermissionStatus.permanentlyDenied) {
      // access settings to grant app permission
    }
  }

  void uploadTicketFile() async {
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileName = result.files.first.name;
      ticket = File(result.files.first.path!);
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
      var data = FormData.fromMap({
        "ui_widget_id": "3",
        "erp_ticket_title": subController.text,
        "erp_ticket_text": txtController.text,
        // "files": files,
        // "erp_ticket_data": erp_ticket_data
      }) ;
      
      data.files.forEach((action){
        action.value.contentType!.type;
      });
       
      print('=====================tickets===================');
      print(data);

      // ticketProvider.submitTicket(FormData.fromMap(data)).then((value) {
      //   emit(SubmitTicketSuccessState());
      // }).catchError((error) {
      //   emit(SubmitTicketFailureState(message: error.failure.message));
      // });

      ///  emit(SubmitTicketFailureState(message: ''));
    }
  }

  // void selectPriority(Object p1) {
  //   priority = int.parse(p1.toString());
  // }

  void selectType(Object p1) {
    type = int.parse(p1.toString());
  }

  var files = List<Map<String, dynamic>>.empty(growable: true);
  var erp_ticket_data = List<Map<String, dynamic>>.empty(growable: true);

  void addAttachmentAndRemark() async {
    if (ticket != null && remarksController.text.isNotEmpty) {
      files.add({
        'erp_ticket_file':
            await MultipartFile.fromFile(ticket!.path, filename: fileName),
        "erp_ticket_remarks": remarksController.text,
      });

      //empty attachment fields
      Future.delayed(const Duration(seconds: 1)).then((value) {
        ticket = null;
        fileName = '';
        remarksController.text = '';
        emit(emptyAttachmentAndRemarksState());
      });
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
