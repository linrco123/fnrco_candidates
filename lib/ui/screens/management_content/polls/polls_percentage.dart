// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/management_content/poll_percentage_model.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/percentage_indicator/linear_percentage_indicator.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class PollsPercentageScreen extends StatelessWidget {
  final String question;
  final VotePercentages votePercentages;
  const PollsPercentageScreen({
    Key? key,
    required this.question,
    required this.votePercentages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.accent,
        title: Text(
          translateLang(context, "polls_assess"),
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        leading: ReturnButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppPagesNames.HOMEPAGE, (s) => true);
          },
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.accent,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20.0,
          children: [
            // Center(
            //     child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text(
            //       translateLang(context, "polls_view"),
            //       style: Theme.of(context)
            //           .textTheme
            //           .headlineLarge!
            //           .copyWith(color: AppColors.grey),
            //     ),
            //     const SizedBox(
            //       height: 20.0,
            //     ),
            //     CircularPercentageIndicator(
            //       percentage: 80,
            //       size: 150,
            //       color: AppColors.success,
            //       strokeWidth: 20,
            //     ),
            //   ],
            // )),
            const SizedBox(
              height: 0.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    question,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.greyDeep,height: 1.5,fontSize: 20),
                  ),
                ),
              ],
            ),
            CustomDivider(hPadding: 10.0,vPadding: 10.0,),
              const SizedBox(
              height: 10.0,
            ),
            ...List.generate(votePercentages.toJson().keys.toList().length,
                (int index) {
              final String key = votePercentages.toJson().keys.toList()[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomOnlyEnTitle(
                    title: key,
                    textColor: AppColors.grey,
                  ),
                  //CustomOnlyEnTitle(title: "Job Posting & Advertising"),
                  LinearPercentageIndicator(
                      percentage: votePercentages.toJson()[key]),
                ],
              );
            }),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     CustomOnlyEnTitle(
            //       title: "Job Posting & Advertising",
            //       textColor: AppColors.grey,
            //     ),
            //     //CustomOnlyEnTitle(title: "Job Posting & Advertising"),
            //     LinearPercentageIndicator(percentage: 30),
            //   ],
            // ),
            // Column(
            //   children: [
            //     CustomOnlyEnTitle(
            //       title: "Candidate Sourcing",
            //       textColor: AppColors.grey,
            //     ),
            //     LinearPercentageIndicator(percentage: 70),
            //   ],
            // ),
            // Column(
            //   children: [
            //     CustomOnlyEnTitle(
            //       title: "Applicant Tracking System (ATS)",
            //       textColor: AppColors.grey,
            //     ),
            //     LinearPercentageIndicator(percentage: 35),
            //   ],
            // ),
            // Column(
            //   children: [
            //     CustomOnlyEnTitle(
            //       title: "Interview Scheduling",
            //       textColor: AppColors.grey,
            //     ),
            //     LinearPercentageIndicator(percentage: 60),
            //   ],
            // ),
            // Column(
            //   children: [
            //     CustomOnlyEnTitle(
            //       title: "Candidate Screening & Assessments",
            //       textColor: AppColors.grey,
            //     ),
            //     LinearPercentageIndicator(percentage: 20),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
