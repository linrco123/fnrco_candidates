// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/data/models/profile_get/keywords_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';

class ReferencesCard extends StatelessWidget {
  final GetReference reference;
  const ReferencesCard({
    Key? key,
    required this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
              // color: AppColors.primary.withOpacity(0.1),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 1))
        ],
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        // border: BorderDirectional(
        //     top: BorderSide(color: AppColors.primary, width: 5.0),
        //     bottom: BorderSide(color: AppColors.primary, width: 5.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileItem(kkey: "company_name", value: reference.company!),
          ProfileItem(kkey: 'job_title', value: reference.jobTitle!),
          ProfileItem(kkey: 'full_name', value: reference.name!),
          ProfileItem(kkey: 'email', value:  reference.email!),
          ProfileItem(kkey: "phone_number", value: reference.phone!),

        ],
      ),
    );
  }
}
