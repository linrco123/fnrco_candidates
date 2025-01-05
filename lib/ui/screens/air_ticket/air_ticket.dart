import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/classes/dotted_border.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/models/air_ticket_model.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/date_picker_widget.dart';
import '../../widgets/profile/title_text.dart';
import 'package:toastification/toastification.dart';
import '../../../logic/cubit/air_ticket/air_ticket_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/return_btn.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AirTicketScreen extends StatelessWidget {
  final AirTicketApplication? airTicketApplication;
  AirTicketScreen({super.key, this.airTicketApplication});
  //final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
        appBar: AppBar(
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              translateLang(context, "air_ticket"),
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: ReturnButton(
              color: AppColors.primary,
            )),
        body: BlocConsumer<AirTicketCubit, AirTicketState>(
          listener: (context, state) {
            if (state is PickUpDepartureDateState) {
              showToast(context,
                  title: translateLang(context, "warning"),
                  desc: 'Please , pick up departure date',
                  type: ToastificationType.warning);
            }
            if (state is PickUpArrivalDateState) {
              showToast(context,
                  title: translateLang(context, "warning"),
                  desc: 'Please , pick up arrival date',
                  type: ToastificationType.warning);
            }
            if (state is PickUpDepartureTimeState) {
              showToast(context,
                  title: translateLang(context, "warning"),
                  desc: 'Please , pick up departure time',
                  type: ToastificationType.warning);
            }
            if (state is PickUpArrivalTimeState) {
              showToast(context,
                  title: translateLang(context, "warning"),
                  desc: 'Please , pick up arrival time',
                  type: ToastificationType.warning);
            }
            if (state is PickUpTicketUpAttachmentState) {
              showToast(context,
                  title: translateLang(context, "warning"),
                  desc: 'Please , pick up Air Ticket Attachment',
                  type: ToastificationType.warning);
            }
          },
          builder: (context, state) {
            final airTicketCubit = BlocProvider.of<AirTicketCubit>(context);
            late AirPipeline? pipeLine;
            if (airTicketApplication == null) {
              pipeLine = null;
            } else {
              pipeLine = airTicketApplication!.pipeline;
            }

            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Form(
                      key: airTicketCubit.formKey,
                      child: Column(
                        children: [
                          CustomTitle(
                            title: "ticket_number",
                          ),
                          CustomInputField(
                              enabled: pipeLine == null ? true : false,
                              controller: airTicketCubit.tckNumCntroller,
                              validate: airTicketCubit.validateTckNumber,
                              inputType: TextInputType.number,
                              hint: pipeLine == null
                                  ? translateLang(context, "ticket_number")
                                  : pipeLine.contractPdf),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(
                            title: "air_line",
                          ),
                          CustomInputField(
                              enabled: pipeLine == null ? true : false,
                              controller: airTicketCubit.airlnCntroller,
                              validate: airTicketCubit.validateAirLine,
                              inputType: TextInputType.name,
                              hint: pipeLine == null
                                  ? translateLang(context, "air_line")
                                  : pipeLine.contractPdf),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(
                            title: "flight_number",
                          ),
                          CustomInputField(
                              enabled: pipeLine == null ? true : false,
                              controller: airTicketCubit.flgNumCntroller,
                              validate: airTicketCubit.validateFlgNumber,
                              inputType: TextInputType.number,
                              hint: pipeLine == null
                                  ? translateLang(context, "flight_number")
                                  : pipeLine.contractPdf),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(
                            title: "departure_from",
                          ),
                          CustomInputField(
                              enabled: airTicketApplication!.pipeline == null
                                  ? true
                                  : false,
                              controller: airTicketCubit.dpturefrmCntroller,
                              validate: airTicketCubit.validatedpturefm,
                              inputType: TextInputType.name,
                              hint: pipeLine == null
                                  ? translateLang(context, "departure_from")
                                  : pipeLine.contractPdf),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(
                            title: "arrival_at",
                          ),
                          CustomInputField(
                              enabled: airTicketApplication!.pipeline == null
                                  ? true
                                  : false,
                              controller: airTicketCubit.dpturefrmCntroller,
                              validate: airTicketCubit.validatedpturefm,
                              inputType: TextInputType.name,
                              hint: pipeLine == null
                                  ? translateLang(context, "arrival_at")
                                  : pipeLine.contractPdf),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(
                            title: "departure_date",
                          ),
                          CustomDatePicker(
                              onTap: () {
                                if (pipeLine == null) {
                                  airTicketCubit.selectdptureDate(context);
                                }
                              },
                              text: pipeLine != null
                                  ? pipeLine.contractPdf!
                                  : airTicketCubit.departure_date ??
                                      'Enter Departure Date'),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(
                            title: "arrival_date",
                          ),
                          CustomDatePicker(
                              onTap: () {
                                if (pipeLine == null) {
                                  airTicketCubit.selectArrivalDate(context);
                                }
                              },
                              text: pipeLine != null
                                  ? pipeLine.contractPdf!
                                  : airTicketCubit.arrival_date ??
                                      'Enter Arrival Date'),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(
                            title: "departure_time",
                          ),
                          CustomTimePicker(
                              onTap: () {
                                if (pipeLine == null) {
                                  airTicketCubit.selectdptureTime(context);
                                }
                              },
                              text: pipeLine != null
                                  ? pipeLine.contractPdf!
                                  : airTicketCubit.departure_time ??
                                      'Enter Departure Time'),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(
                            title: "arrival_time",
                          ),
                          CustomTimePicker(
                              onTap: () {
                                if (pipeLine == null) {
                                  airTicketCubit.selectArrivaltime(context);
                                }
                              },
                              text: pipeLine != null
                                  ? pipeLine.contractPdf!
                                  : airTicketCubit.arrival_time ??
                                      'Enter Arrival Time'),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomPaint(
                            painter: DottedBorderPainter(
                                ),
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
                                  airTicketCubit.uploadAttachment();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        airTicketCubit.fileName.isEmpty
                                            ? translateLang(
                                                context, "upload_attach")
                                            : airTicketCubit.fileName,
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    const Spacer(),
                                    airTicketCubit.fileName.isEmpty
                                        ? Icon(
                                            Icons.upload_file_rounded,
                                            color: AppColors.primary,
                                            size: 25.0,
                                          )
                                        : InkWell(
                                            onTap: () {
                                              airTicketCubit.deleteAttachment();
                                            },
                                            child: Icon(
                                              CupertinoIcons.delete_simple,
                                              color: AppColors.primary,
                                              size: 25.0,
                                            ))
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  )),
                  pipeLine == null
                      ? state is submitAirTicketInfoLoadingState
                          ? AnimatedLoadingWidget()
                          : CustomElevatedButton(
                              fun: () {
                                airTicketCubit.submitAirTicketInfo(
                                    airTicketApplication!.id!);
                              },
                              background: AppColors.primary,
                              text: 'Submit Air Ticket')
                      : SizedBox(
                          height: 10.0,
                        ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
