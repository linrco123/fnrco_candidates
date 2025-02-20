// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:toastification/toastification.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/joining_date_model.dart';
import 'package:fnrco_candidates/logic/cubit/joining_date/joining_date_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

import '../../widgets/profile_get/profile_item.dart';

class JoiningDateSCreen extends StatelessWidget {
  final JoiningDateApplication joiningDateApp;
  const JoiningDateSCreen({
    Key? key,
    required this.joiningDateApp,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateLang(context, 'joining_date'),
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
        child: BlocConsumer<JoiningDateCubit, JoiningDateState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is JoiningDateApprovalSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "date_join_submit_success"),
                  type: ToastificationType.success);

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
            if (state is JoiningDateApprovalErrorState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: translateLang(context, "msg_request_failure"),
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            translateLang(context, "dear_candidate"),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            CacheHelper.getName()!,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            translateLang(context, "join_date"),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            joiningDateApp.pipeline!.joiningDate! ??
                                'Not Determined',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      joiningDateApp.isAction == 'Done'
                          ? const SizedBox.shrink()
                          : CustomInputField(
                              enabled: joiningDateApp.isAction == 'Done'
                                  ? false
                                  : true,
                              controller: context
                                  .read<JoiningDateCubit>()
                                  .joinDateRemark,
                              validate: (context, s) => s,
                              inputType: TextInputType.text,
                              hint: translateLang(
                                  context, "enter_joiningD_remark")),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  )),
                  Visibility(
                    visible: joiningDateApp.isAction != 'Done',
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                          child: state is JoiningDateApprovalLoadingState
                              ? const AnimatedLoadingWidget()
                              : CustomElevatedButton(
                                  fun: () {
                                    if (joiningDateApp.pipeline!.joiningDate !=
                                        null) {
                                      context
                                          .read<JoiningDateCubit>()
                                          .sendJoiningDate(
                                              joiningDateApp.id!, true);
                                    }
                                  },
                                  background: AppColors.success,
                                  text: translateLang(context, 'approve')),
                        )),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                            child: Center(
                          child: state is JoiningDateRejectionLoadingState
                              ? const AnimatedLoadingWidget()
                              : CustomElevatedButton(
                                  fun: () {
                                    if (joiningDateApp.pipeline!.joiningDate !=
                                        null) {
                                      context
                                          .read<JoiningDateCubit>()
                                          .sendJoiningDate(
                                              joiningDateApp.id!, false);
                                    }
                                  },
                                  background: AppColors.primary,
                                  text: translateLang(context, 'reject')),
                        ))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: joiningDateApp.isAction == 'Done',
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        child: Container(
                          height: 200.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.blurRed,
                              borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(16),
                                topEnd: Radius.circular(16),
                                bottomEnd: Radius.circular(16),
                                bottomStart: Radius.circular(16),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileItem(
                                    kkey: "status",
                                    value: joiningDateApp.approvals!.candidate!
                                                .isApproved! ==
                                            '1'
                                        ? translateLang(context, 'approved')
                                        : translateLang(context, 'rejected')),
                                ProfileItem(
                                    kkey: "approve_in",
                                    value: joiningDateApp.approvals!.candidate!
                                        .candidateApprovedIn
                                        .toString()),
                                ProfileItem(
                                    kkey: "remark",
                                    value: joiningDateApp
                                        .approvals!.candidate!.remarks
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
