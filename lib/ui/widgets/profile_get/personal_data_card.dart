// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/profile_get/personal_data_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';

class PersonalDataCard extends StatelessWidget {
  final GetPData pData;
  const PersonalDataCard({
    Key? key,
    required this.pData,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileItem(
              kkey: "user_id", value: pData.email!.personId!.toString()),
          ProfileItem(
              kkey: "user_name", value: pData.email!.candidateUserUname!.toString()),
          ProfileItem(
              kkey: "first_name", value: pData.personFirstName!.toString()),
          ProfileItem(
              kkey:"second_name", value: pData.personSecondName!.toString()),
          ProfileItem(
              kkey: "last_name", value: pData.personThirdName!.toString()),
          ProfileItem(
              kkey:  "sur_name" , value: pData.personSurName!.toString()),
          ProfileItem(
              kkey: "residence", value: pData.personCountryResidence!.toString()),
          ProfileItem(
              kkey:  "email" , value: pData.email!.email!.toString()),
          ProfileItem(
              kkey: "gender", value: pData.personGender!.toString()),
                ProfileItem(
              kkey: "marital_status", value: pData.personMartialStatus!.toString()),
        ],
      ),
    );
  }
}
