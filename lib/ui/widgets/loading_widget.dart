import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:lottie/lottie.dart';

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
                : Platform.isWindows
                    ? CircularProgressIndicator(
                        color: AppColors.primary,
                        semanticsLabel: 'Loading.......',
                      )
                    : CircularProgressIndicator.adaptive(
                        backgroundColor: AppColors.primary,
                        strokeWidth: 20.0,
                      )));
  }
}

class AnimatedLoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  const AnimatedLoadingWidget(
      {super.key, this.height = 100.0, this.width = 100.0});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: height,
            width: width,
            child:
                Lottie.asset(AppImages.CIRCLELOADING, height: height, width: width)));
  }
}
