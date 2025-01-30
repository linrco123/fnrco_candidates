import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/overview/overview_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class OverviewDetailsScreen extends StatelessWidget {
  final int appId;
  const OverviewDetailsScreen({super.key, required this.appId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(
            translateLang(context, 'overview_details'),
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: ReturnButton(
            color: AppColors.primary,
          )),
      body: BlocConsumer<OverviewCubit, OverviewState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetOverviewDataLoadingState) {
            return AnimatedLoadingWidget(
              height: 150.0,
              width: 150.0,
            );
          }

          if (state is GetOverviewDataFailureState) {
            return FailureWidget(
                showImage: true,
                title: state.message,
                onTap: () {
                  context.read<OverviewCubit>().getOverViewData(appId);
                });
          }
          if (state is GetOverviewDataSuccessState) {
            final overViewData = state.overviewData;
            return Padding(
              padding:
                  const EdgeInsets.only(right: 15.0, left: 15.0, top: 25.0),
              child: ListView(
                children: [
                  // "candidate_app_id": 53,
                  // "candidate_id": 30900,
                  // "client_name": "Siemens Limited Saudi Arabia",
                  // "Position_name": "FAS Projct Suprt Eng",
                  // "Position_contract_type": "",
                  // "Position_contract_duration": "",
                  // "Position_vacation_details": "",
                  // "Position_work_hour": "",
                  // "Position_insurance": "",
                  // "agency_name": "Linrco  Egypt",
                  // "agency_address": "57 Abbas El-Akkad, Al Manteqah Al Oula, Nasr City, Cairo Governorate 4450127",
                  // "agency_contact_name": "Asmaa",
                  // "agency_contact_nbsp_phone": "01099088270"

                  CustomTitle(
                    title: "candidate_id",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.candidateId!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),

                  CustomTitle(
                    title: "client_name",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.clientName!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "Position_name",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.positionName!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "Position_contract_type",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.positionContractType!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "Position_contract_duration",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.positionContractDuration!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "Position_vacation_details",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.positionVacationDetails!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "Position_work_hour",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.positionWorkHour!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "candidate_id",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.positionInsurance!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),

                  CustomTitle(
                    title: "Position_insurance",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.positionInsurance!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "agency_name",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.agencyName!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "agency_address",
                  ),
                  CustomInputField(
                      enabled: false,
                      linesNum: 2,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.agencyAddress!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "agency_contact_name",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.agencyContactName!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTitle(
                    title: "agency_contact_nbsp_phone",
                  ),
                  CustomInputField(
                      enabled: false,
                      controller: TextEditingController(),
                      validate: (c, s) => s,
                      inputType: TextInputType.text,
                      hint: overViewData.agencyContactNbspPhone!.toString()),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            );
          }
          return FailureWidget(
              showImage: true,
              title: 'Error ocurred accidentally , try again !!!',
              onTap: () {
                context.read<OverviewCubit>().getOverViewData(appId);
              });
        },
      ),
    );
  }
}
