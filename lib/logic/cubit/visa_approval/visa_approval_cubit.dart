// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/data/api_provider/visa_approval.dart';
import 'package:fnrco_candidates/data/models/visa_approval_model.dart';

part 'visa_approval_state.dart';

class VisaApprovalCubit extends Cubit<VisaApprovalState> {
  final VisaApprovalProvider visaApprovalProvider;
  VisaApprovalCubit(
    this.visaApprovalProvider,
  ) : super(VisaApprovalInitial());

  final visaRemarkCntroller = TextEditingController();
  int candidate_app_id = 0;

  void sendVisaApproval(int id,bool answer) {
    if (answer) {
      emit(VisaApprovalLoadingState());
    } else if (!answer) {
      emit(VisaRejectionLoadingState());
    }
    Map data = {
      "candidate_application_id": id,
      "candidate_approval": answer,
      "candidate_comment": visaRemarkCntroller.text,
      "stage": visa_selection.toString(),
    };
    print("=======================================");
    print(data);
    visaApprovalProvider.sendVisaApproval(data).then((value) {
      emit(VisaApprovalSuccessState());
    }).catchError((error) {
      emit(VisaApprovalErrorState(message: error.failure.message));
    });
    // if (visaRemark.text.isEmpty) {
    // } else if (visaRemark.text.isEmpty) {}
  }
String nationality ='';
final visaApplications = List<VisaApprovalApplication>.empty(growable: true);
  getVisadata() {
    emit(GetVisaApprovalDataLoadingState());
    visaApprovalProvider.getVisadata().then((value) {
      visaApplications.clear();
      visaApplications.addAll(value.visaApplications!);
      emit(GetVisaApprovalDataSuccessState(
          applications: value.visaApplications!));
    }).catchError((error) {
      emit(GetVisaApprovalDataFailureState(message: error.failure.message));
    });
  }
}
