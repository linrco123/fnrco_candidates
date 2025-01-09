import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fnrco_candidates/data/models/job_contract_model.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/contract/contract_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/error_widget.dart';
import 'package:toastification/toastification.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/return_btn.dart';

class JobContractSCreen extends StatelessWidget {
  final ContractApplication jobApplication;
  JobContractSCreen({super.key, required this.jobApplication});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text(
            translateLang(context, "job_contract"),
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: ReturnButton(
            color: AppColors.white,
          )),
      body: BlocConsumer<JobContractCubit, ContractState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is JobContractApprovalSuccessState) {
            showToast(context,
                title: translateLang(context, 'success'),
                desc: 'Job Contract Approval submitted successfully',
                type: ToastificationType.success);

                Navigator.of(context);
                Navigator.of(context);
          }

          if (state is JobContractApprovalFailureState) {
            showToast(context,
                title: translateLang(context, 'error'),
                desc: state.message,
                type: ToastificationType.error);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              if (state is GetJobContractLoadingState)
                AnimatedLoadingWidget(
                  height: 150.0,
                  width: 150.0,
                ),
              if (state is GetJobContractFailureState)
                FailureWidget(showImage: true, title: state.message, onTap: () {}),
              if (context.read<JobContractCubit>().jobContract != null)
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: PDFView(
                    filePath:
                        context.read<JobContractCubit>().jobContract!.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: true,
                    pageSnap: true,
                    defaultPage: 1,
                    fitPolicy: FitPolicy.BOTH,
                    preventLinkNavigation: false,
                    onRender: (p) {
                      // controller.pages = p;
                      // controller.changeIsReady(false);
                    },
                    onError: (error) {
                      // controller.errorMessage = error.toString();
                      // if (kDebugMode) {

                      // }
                    },
                    onPageError: (page, error) {
                      // controller.errorMessage = '$page: ${error.toString()}';
                      // if (kDebugMode) {

                      // }
                    },
                    onViewCreated: (pdfCtrl) {
                      // controller.cTr.complete(pdfCtrl);
                    },
                    onLinkHandler: (String? uri) {
                      // if (kDebugMode) {

                      // }
                    },
                    onPageChanged: (int? page, int? total) {},
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    child: jobApplication.isAction == "Done"
                        ? SizedBox.shrink()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: Center(
                                child: state is JobContractApprovalLoadingState
                                    ? AnimatedLoadingWidget()
                                    : CustomElevatedButton(
                                        fun: () {
                                          context
                                              .read<JobContractCubit>()
                                              .sendJobOfferApproval(
                                                  jobApplication.id!, true);
                                        },
                                        background: AppColors.success,
                                        text:
                                            translateLang(context, 'approve')),
                              )),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                  child: Center(
                                child: state is JobContractRejectLoadingState
                                    ? AnimatedLoadingWidget()
                                    : CustomElevatedButton(
                                        fun: () {
                                          context
                                              .read<JobContractCubit>()
                                              .sendJobOfferApproval(
                                                  jobApplication.id!, false);
                                        },
                                        background: AppColors.primary,
                                        text: translateLang(context, 'reject')),
                              ))
                            ],
                          ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
