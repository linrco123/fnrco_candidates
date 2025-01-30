// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';
import 'package:toastification/toastification.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/visa_approval_model.dart';
import 'package:fnrco_candidates/logic/cubit/visa_approval/visa_approval_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class VisaApprovalScreen extends StatelessWidget {
  final VisaApprovalApplication visaApprovalApplication;
  const VisaApprovalScreen({
    Key? key,
    required this.visaApprovalApplication,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateLang(context, 'visa_approval'),
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        leading: ReturnButton(
          color: AppColors.primary,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: BlocConsumer<VisaApprovalCubit, VisaApprovalState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is VisaApprovalSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "visa_approval_submit_success"),
                  type: ToastificationType.success);

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
            if (state is VisaApprovalErrorState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: translateLang(context, "msg_request_failure"),
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTitle(
                        title: "visa_Profession",
                      ),
                      CustomInputField(
                          validate: (context, s) => s,
                          inputType: TextInputType.name,
                          enabled: false,
                          hint: visaApprovalApplication.pipeline != null
                              ? visaApprovalApplication.pipeline!.positionName
                              : "empty data"),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTitle(
                        title: "nationality",
                      ),
                      CustomInputField(
                          validate: (context, s) => s,
                          enabled: false,
                          inputType: TextInputType.name,
                          hint: visaApprovalApplication.pipeline != null
                              ? visaApprovalApplication.pipeline!.country!
                                  .toString()
                              : "empty data"),
                      const SizedBox(
                        height: 16.0,
                      ),
                      // CustomTitle(
                      //   title: "embasy_location",
                      // ),
                      // CustomInputField(
                      //     validate: (context, s) => s,
                      //     inputType: TextInputType.name,
                      //     enabled: false,
                      //     hint: state.pipeline!.),
                      // const SizedBox(
                      //   height: 16.0,
                      // ),
                      CustomTitle(
                        title: "gender",
                      ),
                      CustomInputField(
                          validate: (context, s) => s,
                          inputType: TextInputType.name,
                          enabled: false,
                          hint: visaApprovalApplication.pipeline != null
                              ? visaApprovalApplication.pipeline!.gender!
                                  .toString()
                              : "empty data"),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTitle(
                        title: "visa_no",
                      ),
                      CustomInputField(
                          validate: (context, s) => s,
                          inputType: TextInputType.name,
                          enabled: false,
                          hint: visaApprovalApplication.pipeline != null
                              ? visaApprovalApplication.pipeline!.positionName
                                  .toString()
                              : "empty data"),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTitle(
                        title: "religion",
                      ),
                      CustomInputField(
                          validate: (context, s) => s,
                          inputType: TextInputType.name,
                          enabled: false,
                          hint: visaApprovalApplication.pipeline != null
                              ? visaApprovalApplication.pipeline!.religion!
                                  .toString()
                              : "empty data"),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTitle(
                        title: "visa_remark",
                      ),
                      CustomInputField(
                          controller: context
                              .read<VisaApprovalCubit>()
                              .visaRemarkCntroller,
                          validate: (context, s) => s,
                          inputType: TextInputType.text,
                          hint: translateLang(context, "enter_visa_remark")),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                )),
                visaApprovalApplication.approvals!.candidate!.isApproved == null?
                Visibility(
                  visible: visaApprovalApplication.isAction == 'Not Done',
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: state is VisaApprovalLoadingState
                            ? AnimatedLoadingWidget()
                            : CustomElevatedButton(
                                fun: () {
                                  context
                                      .read<VisaApprovalCubit>()
                                      .sendVisaApproval(
                                          visaApprovalApplication.id!, true);
                                },
                                background: AppColors.success,
                                text: translateLang(context, 'approve')),
                      )),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Center(
                        child: state is VisaRejectionLoadingState
                            ? AnimatedLoadingWidget()
                            : CustomElevatedButton(
                                fun: () {
                                  context
                                      .read<VisaApprovalCubit>()
                                      .sendVisaApproval(
                                          visaApprovalApplication.id!, false);
                                },
                                background: AppColors.primary,
                                text: translateLang(context, 'reject')),
                      ))
                    ],
                  ),
                )
                : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.blurRed,
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(16),
                                topEnd: Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileItem(
                                  kkey: "status",
                                  value: visaApprovalApplication.approvals!.candidate!
                                              .isApproved! ==
                                          '1'
                                      ? translateLang(context, 'approved')
                                      : translateLang(context, 'rejected')),
                              ProfileItem(
                                  kkey: "approve_in",
                                  value: visaApprovalApplication
                                      .approvals!.candidate!.candidateApprovedIn
                                      .toString()),
                              ProfileItem(
                                  kkey: "remark",
                                  value: visaApprovalApplication
                                      .approvals!.candidate!.remarks
                                      .toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
