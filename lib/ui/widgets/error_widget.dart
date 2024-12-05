// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';

class FailureWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const FailureWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.center,
          title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: AppColors.grey)),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: CustomElevatedButton(
              fun: onTap,
              background: AppColors.primary,
              text: translateLang(context, 'reload')),
        )
      ],
    );
  }
}
