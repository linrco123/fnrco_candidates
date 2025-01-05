import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../core/functions/translate.dart';
import '../../../data/models/air_ticket_model.dart';
import '../../../data/api_provider/air_ticket.dart';
import 'package:permission_handler/permission_handler.dart';
part 'air_ticket_state.dart';

class AirTicketCubit extends Cubit<AirTicketState> {
  AirTicketProvider airTicketProvider;
  AirTicketCubit(
    this.airTicketProvider,
  ) : super(AirTicketInitial());

  final formKey = GlobalKey<FormState>();
  final tckNumCntroller = TextEditingController();
  final airlnCntroller = TextEditingController();
  final flgNumCntroller = TextEditingController();
  final dpturefrmCntroller = TextEditingController();
  final arrivAtCntroller = TextEditingController();

  String? validateTckNumber(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_tck_number");
    }
    return null;
  }

  String? validateAirLine(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_air_line");
    }
    return null;
  }

  String? validateFlgNumber(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_flg_number");
    }
    return null;
  }

  String? validatedpturefm(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_depat_frm");
    }
    return null;
  }

  String? validateArrivAt(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_arrival_at");
    }
    return null;
  }

  String? departure_date;
  void selectdptureDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2020), lastDate: DateTime.now());
    departure_date =
        "${pickedDate!.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    emit(DeparturePickingUpDateState());
  }

  String? arrival_date;
  void selectArrivalDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2020), lastDate: DateTime.now());
    arrival_date =
        "${pickedDate!.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    emit(ArrivalPickingUpDateState());
  }

  String? departure_time;
  void selectdptureTime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 1, minute: 1));
    if (pickedTime != null) {
      departure_time = pickedTime.format(context);
    }
    emit(DeparturePickingUpTimeState());
  }

  String? arrival_time;
  void selectArrivaltime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 1, minute: 1));
    if (pickedTime != null) {
      arrival_time = pickedTime.format(context);
      emit(ArrivalTimingPickingUpTimeState());
    }
  }

  String? arrival_At;
  void selectArrivalAt(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 1, minute: 1));
    if (pickedTime != null) {
      arrival_At = pickedTime.format(context);
      emit(ArrivalAtTimingPickingUpTimeState());
    }
  }

  var airApplications = List<AirTicketApplication>.empty(growable: true);
  void getAirTicketInfo() {
    emit(GetAirTicketInfoLoadingState());
    airTicketProvider.getAirApplications().then((value) {
      airApplications.addAll(value.airApplications!);
      emit(GetAirTicketInfoSuccessState(applications: value.airApplications!));
    }).catchError((error) {
      emit(GetAirTicketInfoFailureState(message: error.failure.message));
    });
  }

  File? attachment;
  String fileName = '';

  void requestPermission() async {
    final PermissionStatus result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      uploadAttachment();
    } else if (result == PermissionStatus.denied) {
      print('give permission for app to accesss local storage');
    } else if (result == PermissionStatus.permanentlyDenied) {
      // access settings to grant app permission
    }
  }

  void uploadAttachment() async {
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileName = result.files.first.name;
      attachment = File(result.files.first.path!);
      emit(AirTicketUploadAttachmentState());
    }
  }

  void deleteAttachment() {
    fileName = '';
    emit(AirTicketDeleteAttachmentState());
  }



  Future<void> submitAirTicketInfo(int applicationId) async {
    if (formKey.currentState!.validate()) {
      if (departure_date == null) {
        emit(PickUpDepartureDateState());
      } else if (arrival_date == null) {
        emit(PickUpArrivalDateState());
      } else if (arrival_time == null) {
        emit(PickUpArrivalTimeState());
      } else if (departure_time == null) {
        emit(PickUpDepartureTimeState());
      } else if (attachment == null) {
        emit(PickUpTicketUpAttachmentState());
      } else {
        emit(submitAirTicketInfoLoadingState());

        FormData formData = FormData.fromMap({
          "candidate_application_id": applicationId,
          "airline_ticket_number": int.parse(tckNumCntroller.text.toString()),
          "airlines": airlnCntroller.text,
          "flight_number": int.parse(flgNumCntroller.text.toString()),
          "departure_from": dpturefrmCntroller.text,
          "departure_date": departure_date,
          "arrival_date": arrival_date,
          "departure_time": departure_time,
          "arrival_at": arrival_At,
          "arrival_time": arrival_time,
        });

        formData.files.add(MapEntry(
            'airline_ticket_document',
            await MultipartFile.fromFile(attachment!.path,
                filename: fileName)));

        airTicketProvider.sendAirTicketInfo(formData).then((value) {
          if (value == true) {
            emit(submitAirTicketInfoSuccesState());
          }
        }).catchError((error) {
          emit(submitAirTicketInfoFailureState(message: error.failure.message));
        });
      }
    }
  }

}
