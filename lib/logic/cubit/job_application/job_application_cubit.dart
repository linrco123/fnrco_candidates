// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/job_application.dart';

part 'job_application_state.dart';

class JobApplicationCubit extends Cubit<JobApplicationState> {
  JobApplicationProvider jobApplicationProvider;
  JobApplicationCubit(
    this.jobApplicationProvider,
  ) : super(JobApplicationInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  File? cvFile;
  String fileName = '';

  String? validateFullName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_full_name");
    } else if (value.length < 6) {
      return translateLang(context, "msg_plz_name_should_be_more_than_6_char");
    }
    return null;
  }

  String? validatePhone(context, String? value) {
    // final regExp = RegExp(
    //   'Constance.phoneRegExp',
    //   caseSensitive: false,
    //   multiLine: false,
    // );

    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_phone");
    }
    // else if (!regExp.hasMatch(value)) {
    //   return translateLang(context, "msg_plz_enter_correct_phone");
    // }
    return null;
  }

  String? validateEmail(context, String? value) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_email");
    } else if (!regex.hasMatch(value)) {
      return translateLang(context, "msg_plz_enter_correct_email");
    }
    return null;
  }

  void requestPermission() async {
    final PermissionStatus result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      uploadResume();
    } else if (result == PermissionStatus.denied) {
      print('give permission for app to accesss local storage');
    } else if (result == PermissionStatus.permanentlyDenied) {
      // access settings to grant app permission
    }
  }

  void uploadResume() async {
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileName = result.files.first.name;
      cvFile = File(result.files.first.path!);
      emit(JobApplicationUploadResumeState());
    }
  }

  void deleteCVPDF() {
    fileName = '';
    emit(JobApplicationDeletionResumeState());
  }

  void applyJob(int jobID) {
    emit(JobApplicationLoadingState());
    var data = {"erp_mpr_id": MODULE_ID, "erp_mpr_item_id": jobID};

    jobApplicationProvider.applyJob(data).then((value) {
      emit(JobApplicationSuccessState());
    }).catchError((error) {
      emit(JobApplicationFailureState(error: error.failure.message));
    });
  }
}
