// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/classes/dotted_border.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/local_process_model.dart';
import 'package:fnrco_candidates/logic/cubit/local_process/local_process_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class LocalProcessScreen extends StatelessWidget {
  final List<LocalProcessPipeLine> localProcessPipeline;
  const LocalProcessScreen({
    Key? key,
    required this.localProcessPipeline,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateLang(context, 'local_process'),
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
        child: BlocConsumer<LocalProcessCubit, LocalProcessState>(
          listener: (context, state) {
            if (state is LocalProcessCheckEmptyAttachmentState) {
              showToast(context,
                  title: translateLang(context, 'warning'),
                  desc: 'Please , Pick up all required attachments',
                  type: ToastificationType.warning);
            }
            if (state is SubmitLocalProcessAttachmentsSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: 'Please , all attachments submitted successfully',
                  type: ToastificationType.success);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }

            if (state is SubmitLocalProcessAttachmentsFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            var localProcessCubit = context.read<LocalProcessCubit>();

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            localProcessPipeline.length,
                            (index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Text(
                                        '*',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                    CustomOnlyEnTitle(
                                        title: localProcessPipeline[index]
                                            .stepName!),
                                  ],
                                ),
                                CustomPaint(
                                  painter: DottedBorderPainter(),
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          enableFeedback: true,
                                          maximumSize:
                                              Size(double.infinity, 70),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 28.0, horizontal: 15.0),
                                          iconColor: AppColors.primary,
                                          visualDensity:
                                              VisualDensity.comfortable,
                                          // textStyle:TextStyle(color: AppColors.grey, fontSize: 17.0) ,
                                          side: BorderSide.none),
                                      onPressed: () {
                                        localProcessCubit.uploadAttachment(
                                            localProcessCubit
                                                .localProcessAttachments[index]
                                                .stepId!);
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              localProcessCubit
                                                      .localProcessAttachments[
                                                          index]
                                                      .pathFile!
                                                      .isEmpty
                                                  ? translateLang(
                                                      context, "upload_attach")
                                                  : _getFileName(localProcessCubit
                                                      .localProcessAttachments[
                                                          index]
                                                      .pathFile!),
                                              style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          const Spacer(),
                                          localProcessCubit
                                                  .localProcessAttachments[
                                                      index]
                                                  .pathFile!
                                                  .isEmpty
                                              ? Icon(
                                                  Icons.upload_file_rounded,
                                                  color: AppColors.primary,
                                                  size: 25.0,
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    localProcessCubit
                                                        .deleteAttachment(
                                                            localProcessCubit
                                                                .localProcessAttachments[
                                                                    index]
                                                                .stepId!);
                                                  },
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .delete_simple,
                                                    color: AppColors.primary,
                                                    size: 25.0,
                                                  ))
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  state is SubmitLocalProcessAttachmentsLoadingState?
                  AnimatedLoadingWidget():
                  CustomElevatedButton(
                      fun: () {
                        context
                            .read<LocalProcessCubit>()
                            .submitAttachments(context);
                      },
                      background: AppColors.primary,
                      text: translateLang(context, 'submit'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getFileName(String filePath) {
    return filePath.substring(filePath.lastIndexOf('/') + 1);
  }
}
