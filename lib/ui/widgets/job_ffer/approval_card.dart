// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';

class ApprovalCard extends StatelessWidget {
  final String isApproved;
  final String approvedIn;
  final String remark;
  const ApprovalCard({
    Key? key,
    required this.isApproved,
    required this.approvedIn,
    required this.remark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.blurRed,
          borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(16), 
              topEnd: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileItem(
                kkey: "status",
                value: isApproved == '1'
                    ? translateLang(context, 'approved')
                    : translateLang(context, 'rejected')),
            ProfileItem(kkey: "approve_in", value: approvedIn.toString()),
            ProfileItem(kkey: "remark", value: remark.toString()),
          ],
        ),
      ),
    );
  }
}
