// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/data/models/profile_get/credentials_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';

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
          //     bottom: BorderSide(color: AppColors.primary, width: 5.0)),
              ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(
            kkey: "credentials_cat",
            value: credential.personCredCat!,
          ),
          ProfileItem(
            kkey: "credentials_name",
            value: credential.personCredName!,
          ),
          ProfileItem(
              kkey: "credentials_Number", value: credential.personCredNumber!),
          ProfileItem(
              kkey: "issue_date", value: credential.personCredIssuedIn!),
          ProfileItem(kkey: "expire_date", value: credential.personCredExpIn!),
          ProfileItem(kkey: "status", value: credential.personCredStatus!),
        ],
      ),
    );
  }
}
