// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/classes/dotted_border.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/required_documents/required_documents_cubit.dart';
import 'package:fnrco_candidates/logic/cubit/required_documents/required_documents_state.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class RequiredDocumentsScreen extends StatefulWidget {
  const RequiredDocumentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RequiredDocumentsScreen> createState() =>
      _RequiredDocumentsScreenState();
}

class _RequiredDocumentsScreenState extends State<RequiredDocumentsScreen>
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
          translateLang(context, 'required_documents'),
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
        child: BlocConsumer<RequiredDocumentsCubit, RequiredDocumentsState>(
          listener: (context, state) {
            if (state is RequiredDocumentsCheckEmptyAttachmentState) {
              showToast(context,
                  title: translateLang(context, 'warning'),
                  desc: 'Please , Choose at least one attachment',
                  type: ToastificationType.warning);
            }
            if (state is SubmitRequiredDocumentsAttachmentsSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: 'Please , all attachments submitted successfully',
                  type: ToastificationType.success);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }

            if (state is SubmitRequiredDocumentsAttachmentsFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<RequiredDocumentsCubit>(context);
            if (state is GetRequiredDocumentsDataLoadingState) {
              return AnimatedLoadingWidget(
                height: 150,
                width: 150,
              );
            }
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
                            cubit.requiredDocumentsAttachments.length,
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
                                        title: cubit
                                            .requiredDocumentsAttachments[index]
                                            .stepName!),
                                    const Spacer(),
                                    // if (cubit
                                    //         .requiredDocumentsAttachments[index]
                                    //         .verified ==
                                    //    null)
                                      Image.asset(
                                        AppImages.circle_checked,
                                        height: 30.0,
                                        width: 30.0,
                                      ),
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
                                        cubit.uploadAttachment(
                                            cubit.requiredDocumentsAttachments[
                                                index]);
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              cubit
                                                      .requiredDocumentsAttachments[
                                                          index]
                                                      .filePath!
                                                      .isEmpty
                                                  ? translateLang(
                                                      context, "upload_attach")
                                                  : _getFileName(cubit
                                                      .requiredDocumentsAttachments[
                                                          index]
                                                      .filePath!),
                                              style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20.0,
                                          ),
                                          cubit
                                                  .requiredDocumentsAttachments[
                                                      index]
                                                  .filePath!
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
                                                          cubit.deleteAttachment(
                                                              cubit
                                                                  .requiredDocumentsAttachments[
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
                                                                child: cubit.showDocument(
                                                                    cubit
                                                                        .requiredDocumentsAttachments[
                                                                            index]
                                                                        .filePath!,
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
                                //     visible: RequiredDocumentsCubit
                                //         .RequiredDocumentsAttachments[index]
                                //         .pathFile!
                                //         .isNotEmpty,
                                //     child: RequiredDocumentsCubit.showDocument(
                                //         RequiredDocumentsCubit
                                //             .RequiredDocumentsAttachments[index]
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
                  state is SubmitRequiredDocumentsAttachmentsLoadingState
                      ? AnimatedLoadingWidget()
                      : CustomElevatedButton(
                          fun: () {
                            context
                                .read<RequiredDocumentsCubit>()
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
