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

class LocalProcessScreen extends StatefulWidget {
  final List<LocalProcessPipeLine> localProcessPipeline;
  const LocalProcessScreen({
    Key? key,
    required this.localProcessPipeline,
  }) : super(key: key);

  @override
  State<LocalProcessScreen> createState() => _LocalProcessScreenState();
}

class _LocalProcessScreenState extends State<LocalProcessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Define the Tween
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    ));
  }

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
                  desc: 'Please , Choose at least one attachment',
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
            var localProcessCubit = BlocProvider.of<LocalProcessCubit>(context);
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
                            widget.localProcessPipeline.length,
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
                                        title: widget
                                            .localProcessPipeline[index]
                                            .stepName!),
                                  ],
                                ),
                                CustomPaint(
                                  painter: DottedBorderPainter(),
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          enableFeedback: true,
                                          maximumSize:
                                            const  Size(double.infinity, 70),
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
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                          const SizedBox(
                                            width: 20.0,
                                          ),
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
                                              : Row(
                                                  children: [
                                                    InkWell(
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
                                                          color:
                                                              AppColors.primary,
                                                          size: 25.0,
                                                        )),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          // showGeneralDialog(
                                                          //   // barrierDismissible:
                                                          //   //     true,
                                                          //   transitionDuration:
                                                          //       const Duration(
                                                          //           seconds: 4),
                                                          //   context: context,
                                                          //   pageBuilder: (context,
                                                          //           animation,
                                                          //           secondaryAnimation) =>
                                                          //       Container(),
                                                          //   transitionBuilder: (context,
                                                          //           animation,
                                                          //           secondaryAnimation,
                                                          //           child) =>
                                                          //       ScaleTransition(
                                                          //     scale: _animation,
                                                          //     child:
                                                          //         AlertDialog(
                                                          //       content:
                                                          //           Container(
                                                          //         clipBehavior:
                                                          //             Clip.antiAlias,
                                                          //         decoration: BoxDecoration(
                                                          //             borderRadius:
                                                          //                 BorderRadius.circular(
                                                          //                     30.0)),
                                                          //         margin: const EdgeInsets
                                                          //             .symmetric(
                                                          //             horizontal:
                                                          //                 20.0),
                                                          //         child: localProcessCubit.showDocument(
                                                          //             localProcessCubit
                                                          //                 .localProcessAttachments[
                                                          //                     index]
                                                          //                 .pathFile!,
                                                          //             _controller
                                                          //                 .value),
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // );
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Center(
                                                              // height: 250.0,
                                                              child: Container(
                                                                //constraints: BoxConstraints(maxHeight: 250),
                                                                // height: 300,
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16.0)),
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20.0),
                                                                child: localProcessCubit.showDocument(
                                                                    localProcessCubit
                                                                        .localProcessAttachments[
                                                                            index]
                                                                        .pathFile!,
                                                                    _controller
                                                                        .value),
                                                              ),
                                                            ),
                                                          );
                                                          // // Start the animation
                                                          // _controller.forward();
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .preview_outlined,
                                                          color:
                                                              AppColors.primary,
                                                          size: 25.0,
                                                        )),
                                                  ],
                                                )
                                        ],
                                      )),
                                ),

                                const SizedBox(
                                  height: 20.0,
                                ),
                                // Visibility(
                                //     visible: localProcessCubit
                                //         .localProcessAttachments[index]
                                //         .pathFile!
                                //         .isNotEmpty,
                                //     child: localProcessCubit.showDocument(
                                //         localProcessCubit
                                //             .localProcessAttachments[index]
                                //             .pathFile!))
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
                  state is SubmitLocalProcessAttachmentsLoadingState
                      ? const AnimatedLoadingWidget()
                      : CustomElevatedButton(
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
