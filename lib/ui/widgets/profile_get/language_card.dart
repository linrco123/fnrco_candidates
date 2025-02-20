import 'package:flutter/material.dart';
import '../../../data/models/profile_get/languages_model.dart';
import 'profile_item.dart';

class LanguageCard extends StatelessWidget {
  final GetLanguage language;
  const LanguageCard({
    Key? key,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(kkey: "language", value: language.langText!),
          ProfileItem(kkey: "lang_test_by", value: language.langTestBy!),
          ProfileItem(
              kkey: "lang_test_by", value: language.langLevel!.toString()),
        ],
      ),
    );
  }
}
