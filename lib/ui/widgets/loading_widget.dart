import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 30.0,
            width: 30.0,
            child: Platform.isAndroid
                ? CircularProgressIndicator(
                    color: AppColors.primary,
                    semanticsLabel: 'Loading.......',
                  )
                : CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.primary,strokeWidth: 20.0,
                  )));
  }
}
