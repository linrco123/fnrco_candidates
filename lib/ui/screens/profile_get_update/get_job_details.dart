// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/profile_get/get_jobs_model.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class GetJobDetailsScreen extends StatelessWidget {
  final GetJob job;
  const GetJobDetailsScreen({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            'Applied Job Details',
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [
                ProfileItem(
                  kkey: "position",
                  value: job.erpMprItemId!.position!,
                ),
                ProfileItem(
                  kkey: "gender",
                  value: job.erpMprItemId!.erpMprItemPositionGender!,
                ),
                ProfileItem(
                  kkey: "location",
                  value: job.erpMprItemId!.erpMprItemWorkLocation!,
                ),
                ProfileItem(
                  kkey: "salary",
                  value: job.erpMprItemId!.erpMprItemSalary!,
                ),
                ProfileItem(
                  kkey: "category",
                  value: job.erpMprItemId!.erpMprItemWorkforceCategory!,
                ),
                ProfileItem(
                  kkey: "status",
                  value: job.erpMprItemId!.erpMprItemStatus!,
                ),
                ProfileItem(
                  kkey: "contract_duration",
                  value: job.erpMprItemId!.erpMprItemContractDuration!,
                ),
                ProfileItem(
                  kkey: "work_experience",
                  value: job.erpMprItemId!.erpMprItemYearsOfExperience!,
                ),
                const CustomDivider(
                  vPadding: 10.0,
                  hPadding: 10.0,
                ),
                detailsItem(context,
                    title: "working_hours",
                    body: job.erpMprItemId!.erpMprItemWorkingHours!),
                const CustomDivider(
                  vPadding: 10.0,
                  hPadding: 10.0,
                ),
                detailsItem(context,
                    title: "remarks",
                    body: job.erpMprItemId!.erpMprItemRemarks!),
                const CustomDivider(
                  vPadding: 10.0,
                  hPadding: 10.0,
                ),
                detailsItem(context,
                    title: "vacation_details",
                    body: job.erpMprItemId!.erpMprItemVacationDetails!),
              ],
            )));
  }
}

Widget detailsItem(context, {required String title, required String body}) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translateLang(
                context,
                title,
              ),
              style: Theme.of(context).textTheme.headlineLarge,
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                textAlign: TextAlign.center,
                body,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w900),
              ))
            ],
          ),
        )
      ],
    );
