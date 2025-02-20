// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';

class FailureWidget extends StatelessWidget {
  final String title;
  final bool showImage;
  final void Function() onTap;
  const FailureWidget({
    Key? key,
    required this.title,
    required this.showImage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            textAlign: TextAlign.center,
            textHeightBehavior: const TextHeightBehavior(
              leadingDistribution: TextLeadingDistribution.even,
                applyHeightToFirstAscent: true, 
                applyHeightToLastDescent: true),
                
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: AppColors.grey,height: 1.5)),
        const SizedBox(
          height: 10.0,
        ),
        showImage ? Lottie.asset(AppImages.SERVER_ERROR) : const SizedBox.shrink(),
        const SizedBox(
          height: 10.0,
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
    ;
  }
}
