import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/profile_get/education_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';

class EducationCard extends StatelessWidget {
  final GetEducation education;
  const EducationCard({
    Key? key,
    required this.education,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            // "person_cred_cat": "ssdsss",
            // "person_cred_name": "sssss",
            // "person_cred_number": "12345678",
            // "person_cred_status": "",
            // "person_cred_issued_in": "2024-11-12",
            // "person_cred_exp_in": "2024-11-21"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: "degree",
              ),
              Text(
                education.eduDegree!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title:  "specialization",
              ),
              Text(
                education.eduFieldOfStudy!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title:  "education_years",
              ),
              Text(
                education.eduYears!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title:  "pass_year",
              ),
              Text(
                education.eduGraduationYear!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),

           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title:   "institution_name"
        ,
              ),
              Text(
                education.eduInstitutionName!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: "cert_issue_date"
              ),
              Text(
                education.eduCertificationIssuesIn!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: "cert_expire_date",
              ),
              Text(
                education.eduCertificationExpiryIn!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title:"cert_name",
              ),
              Text(
                education.eduCertificationName!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
         
        ],
      ),
    );
  }
}
