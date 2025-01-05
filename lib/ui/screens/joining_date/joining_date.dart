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
                      CustomInputField(
                          controller:
                              context.read<JoiningDateCubit>().joinDateRemark,
                          validate: (context, s) => s,
                          inputType: TextInputType.text,
                          hint:
                              translateLang(context, "enter_joiningD_remark")),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: state is JoiningDateApprovalLoadingState
                            ? LoadingWidget()
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
                            ? LoadingWidget()
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
