// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/data/api_provider/joining_date.dart';
import 'package:fnrco_candidates/data/models/joining_date_model.dart';

part 'joining_date_state.dart';

class JoiningDateCubit extends Cubit<JoiningDateState> {
  JoiningDateProvider joiningDateProvider;
  JoiningDateCubit(
    this.joiningDateProvider,
  ) : super(JoiningDateInitial());

  final joinDateRemark = TextEditingController();
  int candidate_app_id = 0;

  void sendJoiningDate(int applicationID, bool answer) {
    // if (answer) {
    //   emit(JoiningDateApprovalLoadingState());
    // } else if (!answer) {
    //   emit(JoiningDateRejectionLoadingState());
    // }

    Map data = {
      "candidate_application_id": applicationID,
      "candidate_approval": answer,
      "candidate_comment": joinDateRemark.text,
      "stage": joining_date.toString(),
    };

    joiningDateProvider.sendJoiningDate(data).then((value) {
      emit(JoiningDateApprovalSuccessState());
    }).catchError((error) {
      emit(JoiningDateApprovalErrorState(message: error.failure.message));
    });
  }

  getJoiningDateInfo() {
    emit(GetJoiningDateLoadingState());
    joiningDateProvider.getJoiningDate().then((value) {
      emit(GetJoiningDateSuccessState(applications: value.dateApplications!));
    }).catchError((error) {
      emit(GetJoiningDateFailureState(error.failure.message));
    });
  }
}
