// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/profile_get/get_jobs_model.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_job_details.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';

class AppliedJobCard extends StatelessWidget {
  final GetJob appliedJob;
  const AppliedJobCard({
    Key? key,
    required this.appliedJob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => GetJobDetailsScreen(job: appliedJob),
        ));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 5.0,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(0, 1))
            ],
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
            border: BorderDirectional(
                top: BorderSide(color: AppColors.primary, width: 5.0),
                bottom: BorderSide(color: AppColors.primary, width: 5.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileItem(
              kkey: "position",
              value: appliedJob.erpMprItemId!.position!,
            ),
            ProfileItem(
              kkey: "working_hours",
              value: appliedJob.erpMprItemId!.erpMprItemWorkingHours!,
            ),
            ProfileItem(
              kkey: "gender",
              value: appliedJob.erpMprItemId!.erpMprItemPositionGender!,
            ),
            ProfileItem(
              kkey: "location",
              value: appliedJob.erpMprItemId!.erpMprItemWorkLocation!,
            ),
            ProfileItem(
              kkey: "salary",
              value: appliedJob.erpMprItemId!.erpMprItemSalary!,
            ),
            ProfileItem(
              kkey: "category",
              value: appliedJob.erpMprItemId!.erpMprItemWorkforceCategory!,
            ),
            ProfileItem(
              kkey: "status",
              value: appliedJob.erpMprItemId!.erpMprItemStatus!,
            ),
            ProfileItem(
              kkey: "remarks",
              value: appliedJob.erpMprItemId!.erpMprItemRemarks!,
            ),
            ProfileItem(
              kkey: "vacation_details",
              value: appliedJob.erpMprItemId!.erpMprItemVacationDetails!,
            ),
          ],
        ),
      ),
    );
  }
}
