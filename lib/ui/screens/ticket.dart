import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/classes/dotted_border.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/ticket_provider.dart';
import 'package:fnrco_candidates/logic/cubit/tickets/tickets_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketsCubit(TicketProvider()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            translateLang(context, 'tickets'),
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(
            color: AppColors.white,
          ),
          centerTitle: true,
        ),
        backgroundColor: AppColors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return BlocConsumer<TicketsCubit, TicketsState>(
            listener: (context, state) {
              if (state is SubmitTicketSuccessState) {
                showToast(context,
                    title: translateLang(context, 'success'),
                    desc: translateLang(context, 'msg_submit_tck_success'),
                    type: ToastificationType.success);
                Navigator.of(context).pop();
              }
              if (state is SubmitTicketFailureState) {
                showToast(context,
                    title: translateLang(context, 'error'),
                    desc: state.message,
                    type: ToastificationType.error);
              }
            },
            builder: (context, state) {
              final cubit = BlocProvider.of<TicketsCubit>(context);
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                color: AppColors.grey.withOpacity(0.3),
                child: Column(
                  children: [
                    Form(
                      key: cubit.formKey,
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomTitle(
                                title: "subject",
                              ),
                              CustomInputField(
                                  controller: cubit.subController,
                                  validate: cubit.validateSubject,
                                  inputType: TextInputType.name,
                                  hint: translateLang(
                                      context, "enter_subject_here")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomTitle(
                                title: "text",
                              ),
                              CustomInputField(
                                  controller: cubit.txtController,
                                  validate: cubit.validateTckText,
                                  inputType: TextInputType.name,
                                  hint: translateLang(
                                      context, "enter_text_here")),
                              // const SizedBox(
                              //   height: 16.0,
                              // ),
                              //  CustomTitle(
                              //   title: "priority",
                              // ),
                              // cubit.priorties.isEmpty
                              //     ? SignUpLoadingWidget()
                              //     : CustomDropTextField(
                              //         items: cubit.priorties
                              //             .map((priority) =>
                              //                 DropdownMenuItem<int>(
                              //                   //alignment: Alignment.center,
                              //                   child: Text(
                              //                       '${priority.countryName!}'),
                              //                   value: priority.id,
                              //                 ))
                              //             .toList(),
                              //         text: translateLang(context, 'tck_prior'),
                              //         icon: SvgPicture.asset(
                              //           AppImages.priority,
                              //           height: 25.0,
                              //           width: 25.0,
                              //         ),
                              //         onChanged: cubit.selectPriority,
                              //       ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomTitle(
                                title: "type",
                              ),
                              CustomInputField(
                                controller: cubit.typeControler,
                                validate: cubit.validateTckType,
                                hint: translateLang(context, 'enter_tck_type'),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomPaint(
                                      painter: DottedBorderPainter(),
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              enableFeedback: true,
                                              maximumSize:
                                                  Size(double.infinity, 48),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 15.0),
                                              iconColor: AppColors.primary,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              // textStyle:TextStyle(color: AppColors.grey, fontSize: 17.0) ,
                                              side: BorderSide.none),
                                          onPressed: () {
                                            cubit.uploadTicketFile();
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  cubit.fileName.isEmpty
                                                      ? translateLang(context,
                                                          "upload_attach")
                                                      : cubit.fileName,
                                                  style: TextStyle(
                                                      color: AppColors.grey,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              const Spacer(),
                                              cubit.fileName.isEmpty
                                                  ? Icon(
                                                      Icons.upload_file_rounded,
                                                      color: AppColors.primary,
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        cubit
                                                            .deleteTicketFile();
                                                      },
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .delete_simple,
                                                        color:
                                                            AppColors.primary,
                                                        size: 25.0,
                                                      ))
                                            ],
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    CustomTitle(
                                      title: "remark",
                                    ),
                                    CustomInputField(
                                        autovalidateMode: true,
                                        controller: cubit.remarksController,
                                        validate:
                                            cubit.validateTckAttachRemarks,
                                        inputType: TextInputType.name,
                                        hint: translateLang(
                                            context, "enter_remark_here")),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton.outlined(
                                            style: IconButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.black,
                                                foregroundColor:
                                                    AppColors.white),
                                            onPressed: () {
                                              cubit.addAttachmentAndRemark();
                                            },
                                            icon: Icon(CupertinoIcons.add))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    state is SubmitTicketLoadingState
                        ? AnimatedLoadingWidget()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: CustomElevatedButton(
                                fun: () {
                                  cubit.submitTicket();
                                },
                                background: AppColors.primary,
                                text: translateLang(context, 'save'))),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
