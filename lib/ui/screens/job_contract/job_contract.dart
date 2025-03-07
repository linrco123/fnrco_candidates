import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../widgets/job_ffer/approval_card.dart';
import '../../../core/classes/dotted_border.dart';
import '../../../data/models/job_contract_model.dart';
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
      floatingActionButton: jobApplication.isAction!.toLowerCase() == 'not done'
          ? Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.08),
              child: FloatingActionButton(
                onPressed: () {
                  _showSheet(context.read<JobContractCubit>(), context);
                },
                child: const Icon(Icons.upload),
              ),
            )
          : null,
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
            Navigator.of(context);
            Navigator.of(context);
            showToast(context,
                title: translateLang(context, 'success'),
                desc: 'Job Contract Approval submitted successfully',
                type: ToastificationType.success);
          }

          if (state is JobContractApprovalFailureState) {
            showToast(context,
                title: translateLang(context, 'error'),
                desc: state.message,
                type: ToastificationType.error);
          }
          if (state is AttachmentUploadFileState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<JobContractCubit>(context);
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
                const AnimatedLoadingWidget(
                  height: 150.0,
                  width: 150.0,
                ),
              if (state is GetJobContractFailureState)
                FailureWidget(
                    showImage: true, title: state.message, onTap: () {}),
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
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                contentPadding: const EdgeInsets.all(30),
                                backgroundColor: AppColors.black,
                                content: Text(
                                  textAlign: TextAlign.center,
                                  ' Error while loading contract !!!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: AppColors.white),
                                ),
                              ));
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
              jobApplication.isAction!.toLowerCase() == "not done"
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          child: jobApplication.isAction == "Done"
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                        child: Center(
                                      child: state
                                              is JobContractApprovalLoadingState
                                          ? const AnimatedLoadingWidget()
                                          : CustomElevatedButton(
                                              fun: () {
                                                context
                                                    .read<JobContractCubit>()
                                                    .sendJobOfferApproval(
                                                        jobApplication.id!,
                                                        true);
                                              },
                                              background: AppColors.success,
                                              text: translateLang(
                                                  context, 'approve')),
                                    )),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                        child: Center(
                                      child: state
                                              is JobContractRejectLoadingState
                                          ? const AnimatedLoadingWidget()
                                          : CustomElevatedButton(
                                              fun: () {
                                                context
                                                    .read<JobContractCubit>()
                                                    .sendJobOfferApproval(
                                                        jobApplication.id!,
                                                        false);
                                              },
                                              background: AppColors.primary,
                                              text: translateLang(
                                                  context, 'reject')),
                                    ))
                                  ],
                                ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: ApprovalCard(
                        isApproved:
                            jobApplication.approvals!.candidate!.isApproved!,
                        approvedIn: jobApplication
                            .approvals!.candidate!.candidateApprovedIn
                            .toString(),
                        remark: jobApplication.approvals!.candidate!.remarks
                            .toString(),
                      ))
            ],
          );
        },
      ),
    );
  }

  _showSheet(JobContractCubit cubit, context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      constraints: const BoxConstraints(maxHeight: 300),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<JobContractCubit, ContractState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 5,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Upload File',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomPaint(
                              painter: DottedBorderPainter(),
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      enableFeedback: true,
                                      maximumSize: const Size(double.infinity, 70),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30.0, horizontal: 15.0),
                                      iconColor: AppColors.primary,
                                      visualDensity: VisualDensity.compact,
                                      // textStyle:TextStyle(color: AppColors.grey, fontSize: 17.0) ,
                                      side: BorderSide.none),
                                  onPressed: () {
                                    cubit.uploadRequestFile();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cubit.fileName.isEmpty
                                              ? translateLang(
                                                  context, "upload_attach")
                                              : cubit.fileName,
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      const Spacer(),
                                      cubit.fileName.isEmpty
                                          ? Icon(
                                              Icons.upload_file_rounded,
                                              color: AppColors.primary,
                                              size: 25.0,
                                            )
                                          : InkWell(
                                              onTap: () {
                                                cubit.deleteRequestFile();
                                              },
                                              child: Icon(
                                                CupertinoIcons.delete_simple,
                                                color: AppColors.primary,
                                                size: 25.0,
                                              ))
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 15.0,
                    right: 15.0,
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.black),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
