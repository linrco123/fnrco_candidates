// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final double frontP ;
  const CustomTitle({
    Key? key,
    required this.title,
     this.frontP = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             SizedBox(
              width: frontP,
            ),
            Text(
              translateLang(context, title),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
