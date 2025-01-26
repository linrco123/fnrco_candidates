// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/data/models/profile_get/experiences_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';
import 'package:html/parser.dart' as parser;

class ExperienceCard extends StatelessWidget {
  final GetExperience experience;
  const ExperienceCard({
    Key? key,
    required this.experience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              //color: AppColors.primary.withOpacity(0.5),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 1))
        ],
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        // border: BorderDirectional(
        //     top: BorderSide(color: AppColors.primary, width: 5.0),
        //     bottom: BorderSide(color: AppColors.primary, width: 5.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(kkey: "country", value: experience.countryId!.toString()),
          ProfileItem(kkey: "job_title", value: experience.experienceJobTitle!),
          ProfileItem(kkey: "start_date", value: experience.experienceStartIn!),
          ProfileItem(kkey: "end_date", value: experience.experienceEndIn!),
          ProfileItem(
              kkey: "desc",
              value: convertHtmlToText(experience.experienceDescription!)),
          ProfileItem(
              kkey: "company_name", value: experience.experienceCompany!),
        ],
      ),
    );
  }

  String convertHtmlToText(String desc) {
    return parser.parse(desc).body!.innerHtml;
  }
}
