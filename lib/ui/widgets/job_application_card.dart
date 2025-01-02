import 'package:flutter/material.dart';
import '../../data/models/job_offer_model.dart';
import 'profile_get/profile_item.dart';
import '../../../constants/app_colors.dart';

class JobApplicationCard extends StatelessWidget {
  final JobApplication application;
  const JobApplicationCard({
    Key? key,
    required this.application,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppColors.grey,
              blurRadius: 5.0,
              spreadRadius: 5.0,
              blurStyle: BlurStyle.outer,
              offset: Offset(1, 1))
        ],
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(
              kkey: "candidate_name",
              value: application.candidateName.toString()),
          ProfileItem(
              kkey: "nationality",
              value: application.candidateNationality!.toString()),
          ProfileItem(kkey: "position", value: application.position.toString()),
          ProfileItem(
              kkey: "client_name", value: application.clientName.toString()),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Text(
          //         application.!,
          //         style: Theme.of(context)
          //             .textTheme
          //             .headlineLarge!
          //             .copyWith(color: AppColors.black),
          //       ),
          //     ),

          //   ],
          // ),
        ],
      ),
    );
  }
}
