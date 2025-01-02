// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/local_process.dart';
import 'package:fnrco_candidates/logic/cubit/local_process/local_process_cubit.dart';
import 'package:fnrco_candidates/logic/cubit/visa_approval/visa_approval_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class LocalProcessScreen extends StatelessWidget {
  const LocalProcessScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LocalProcessCubit(LocalProcessProvider())..getLocalProcessData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'local_process'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
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
          child: BlocConsumer<LocalProcessCubit, LocalProcessState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetLocalProcessDataLoadingState) {
                return AnimatedLoadingWidget(
                  height: 150.0,
                  width: 150.0,
                );
              }
              if (state is GetLocalProcessDataFailureState) {
                return FailureWidget(
                    title: state.message,
                    onTap: () {
                      context.read<VisaApprovalCubit>().getVisadata();
                    });
              }
              final localProcessList =
                  (state as GetLocalProcessDataSuccessState).data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    localProcessList.length,
                    (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // color: AppColors.grey,
                          child: Checkbox(
                            value: true,
                            onChanged: (value) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Degree attestation",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Degree attestation",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Document Preparation",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Profession Change in passport",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Enjaz registration",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Medical Exam",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Biometric Exam",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Police Clearance",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Passport Submission",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Military Permit",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: AppColors.grey,
                  //       child: Checkbox(
                  //         value: true,
                  //         onChanged: (value) {},
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5.0),
                  //       child: Text(
                  //         "Visa",
                  //         style: Theme.of(context).textTheme.labelMedium,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
