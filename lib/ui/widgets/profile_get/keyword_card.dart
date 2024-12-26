// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/data/models/profile_get/keywords_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/custom_profile_text.dart';

class KeyWordCard extends StatelessWidget {
  final GetKeyword keyword;
  const KeyWordCard({
    Key? key,
    required this.keyword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
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
          CustomProfileText(text: keyword.keywordText!),
        ],
      ),
    );
  }
}
