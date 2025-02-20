import 'package:flutter/material.dart';
import '../../../data/models/profile_get/education_model.dart';
import 'profile_item.dart';

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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
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
          ProfileItem(kkey: "degree", value: education.eduDegree!),
          ProfileItem(
              kkey: "specialization", value: education.eduFieldOfStudy!),
          ProfileItem(kkey: "education_years", value: education.eduYears!),
          ProfileItem(kkey: "pass_year", value: education.eduGraduationYear!),
          ProfileItem(
              kkey: "institution_name", value: education.eduInstitutionName!),
          ProfileItem(
              kkey: "cert_issue_date",
              value: education.eduCertificationIssuesIn!),
          ProfileItem(
              kkey: "cert_expire_date",
              value: education.eduCertificationExpiryIn!),
          ProfileItem(
              kkey: "cert_name", value: education.eduCertificationName!),
        ],
      ),
    );
  }
}
