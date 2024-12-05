// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/profile_get/credentials_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';

class CredentialCard extends StatelessWidget {
  final GetCredential credential;
  const CredentialCard({
    Key? key,
    required this.credential,
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
                title: "credentials_cat",
              ),
              Text(
                credential.personCredCat!,
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
                title: "credentials_name",
              ),
              Text(
                credential.personCredName!,
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
                title: "credentials_Number",
              ),
              Text(
                credential.personCredNumber!,
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
                title:  "issue_date",
              ),
              Text(
                credential.personCredIssuedIn!,
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
                title: "expire_date",
              ),
              Text(
                credential.personCredExpIn!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
        //  Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       CustomTitle(
        //         title: "status",
        //       ),
        //       Text(
        //         credential.personCredStatus!,
        //         style: Theme.of(context).textTheme.headlineLarge,
        //       ),
        //     ],
        //   ),
        //   const SizedBox(
        //     height: 10.0,
        //   ),
         
        ],
      ),
    );
  }
}
