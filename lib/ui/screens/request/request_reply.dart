import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../../constants/app_colors.dart';
import '../../../core/classes/dotted_border.dart';
import '../../../core/functions/show_snackbar.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/models/request_model.dart';
import '../../../logic/cubit/request/request_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:toastification/toastification.dart';

class RequestReplyScreen extends StatelessWidget {
  final RequestData request;
  const RequestReplyScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateLang(context, 'reply'),
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        leading: ReturnButton(
          color: AppColors.primary,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return BlocConsumer<RequestCubit, RequestState>(
          listener: (context, state) {
            if (state is RequestFileDownloadLoadingState) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        contentPadding: const EdgeInsets.all(30),
                        backgroundColor: AppColors.black,
                        content: Row(
                          children: [
                            CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              ' Loading.....',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ));
            }
            if (state is RequestFileDownloadSuccessState) {
              Navigator.of(context).pop();

              // showToast(context,
              //     title: translateLang(context, 'success'),
              //     desc: 'Request File downloaded successfully',
              //     type: ToastificationType.success);
              showSuccessSnackBar(context,
                  text: 'Request File downloaded successfully');
            }
            if (state is RequestFileDownloadFailureState) {
              Navigator.of(context).pop();
              // showToast(context,
              //     title: translateLang(context, 'error'),
              //     desc: state.message,
              //     type: ToastificationType.error);
              showSuccessSnackBar(context, text: state.message);
            }

            if (state is RequestSubmitSuccessState) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: 'Request submitted successfully',
                  type: ToastificationType.success);
            }
            if (state is RequestApprovalSuccessState) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: 'Request Approval submitted successfully',
                  type: ToastificationType.success);
            }
            if (state is RequestSubmitfailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.messsage,
                  type: ToastificationType.error);
            }
            if (state is RequestApprovalFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
            if (state is RequestChooseFileState) {
              showToast(context,
                  title: translateLang(context, 'warning'),
                  desc: "Please , pick up a request file",
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<RequestCubit>(context);
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              color: AppColors.white,
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            CustomTitle(
                              title: "title",
                            ),
                            CustomInputField(
                                enabled: false,
                                controller: cubit.titleCntroller,
                                validate: cubit.validateTitle,
                                inputType: TextInputType.name,
                                hint: request.title),
                            const SizedBox(
                              height: 16.0,
                            ),
                            CustomTitle(
                              title: "remark",
                            ),
                            CustomInputField(
                                enabled: true,
                                linesNum: 3,
                                controller: cubit.descCntroller,
                                validate: cubit.validateDescription,
                                inputType: TextInputType.name,
                                hint: request.remarks),
                            const SizedBox(
                              height: 16.0,
                            ),
                            if (request.requestType!.toLowerCase() ==
                                    'upload file' &&
                                (cubit.isFileDownloaded ||
                                    request.file!.isEmpty))
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 12.0,
                                    ),
                                    child: Text(
                                      '*',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTitle(
                                      title: "upload_attach",
                                    ),
                                  )
                                ],
                              ),
                            if (cubit.isFileDownloaded || request.file!.isEmpty)
                              CustomPaint(
                                painter: DottedBorderPainter(),
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        enableFeedback: true,
                                        maximumSize: Size(double.infinity, 70),
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
                            if (cubit.fileName.isNotEmpty)
                              const SizedBox(
                                height: 16.0,
                              ),
                            if (cubit.fileName.isNotEmpty)
                              showAttachment(cubit.attachment!.path),
                            // Visibility(
                            //     visible: cubit.fileName.isNotEmpty,
                            //     child: showAttachment(cubit.attachment!.path)),
                            const SizedBox(
                              height: 16.0,
                            ),
                            if (!cubit.isFileDownloaded &&
                                request.file!.isNotEmpty)
                              Stack(
                                children: [
                                  Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      color: AppColors.white,
                                      child: SizedBox(
                                          height: 400,
                                          width: double.infinity,
                                          child: SfPdfViewer.network(
                                              request.file!))),
                                  Positioned(
                                      top: 5.0,
                                      right: 5.0,
                                      child: InkWell(
                                        onTap: () {
                                          context
                                              .read<RequestCubit>()
                                              .downloadRequestAttachment(
                                                  request.file!);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5.0),
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: AppColors.black,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.file_download,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    //"Approval Request"
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: request.requestType == "Upload File"
                            ? state is RequestSubmitLoadingState
                                ? AnimatedLoadingWidget()
                                : CustomElevatedButton(
                                    fun: () {
                                      context
                                          .read<RequestCubit>()
                                          .submit(request);
                                    },
                                    background: AppColors.primary,
                                    text: translateLang(context, 'submit'))
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                      child: Center(
                                    child: state is RequestApprovalLoadingState
                                        ? AnimatedLoadingWidget()
                                        : CustomElevatedButton(
                                            fun: () {
                                              context
                                                  .read<RequestCubit>()
                                                  .sendRequestApproval(
                                                      request, true);
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
                                    child: state is RequestRejectionLoadingState
                                        ? AnimatedLoadingWidget()
                                        : CustomElevatedButton(
                                            fun: () {
                                              context
                                                  .read<RequestCubit>()
                                                  .sendRequestApproval(
                                                      request, false);
                                            },
                                            background: AppColors.primary,
                                            text: translateLang(
                                                context, 'reject')),
                                  ))
                                ],
                              ))
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget showAttachment(String path) {
    if (path.contains('.pdf')) {
      return Card(
        shadowColor: AppColors.black,
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: SizedBox(
            height: 300.0,
            width: double.infinity,
            child: PDFView(
              filePath: path,
            )),
      );
    } else {
      return Card(
        shadowColor: AppColors.black,
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Image.file(
          File(path),
          // height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
